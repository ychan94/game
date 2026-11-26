extends RefCounted
## 방 하나의 전투 규칙. 화면과 무관하게 돌아간다 (테스트·봇·성능 측정이 이걸 직접 돌린다).
##
## 공개 API (테스트와 화면이 쓰는 것)
##   World.new(seed)              시드가 같으면 결과가 같다
##   spawn_player / spawn_enemy / spawn_echo
##   step(inputs)                 inputs = {"move": Vector2, "aim": Vector2, "attack": bool, "dodge": bool}
##   observe() / nearest_foe(u) / threat_toward(u, r)
##   state_hash()                 회귀 비교용 지문
##   SYSTEMS                      프레임마다 도는 함수 (성능 측정용)

const Data = preload("res://src/core/data.gd")
const Echo = preload("res://src/core/echo.gd")

const ROOM := Rect2(0, 0, 640, 352)
const WALL := 16.0
const SYSTEMS := ["update_controlled", "update_enemies", "update_shots", "resolve_combat", "separate_units", "cleanup"]


class Unit:
	var id := 0
	var team := "enemy"
	var kind := ""
	var pos := Vector2.ZERO
	var radius := 9.0
	var hp := 10.0
	var max_hp := 10.0
	var speed := 1.0
	var facing := Vector2.RIGHT
	var weapon := ""
	var abilities: Array = []
	var attack_cd := 0
	var dodge_t := 0
	var dodge_dir := Vector2.ZERO
	var dodge_charges := 1
	var dodge_max := 1
	var dodge_recharge := 0
	var invuln := 0
	var exposed := 0
	var state := "spawn"
	var timer := 0
	var aim_dir := Vector2.ZERO
	var alive := true
	var brain = null
	var is_echo := false
	var hit_flash := 0
	var last_attack_frame := -999

	func has(ability: String) -> bool:
		return abilities.has(ability)


class Shot:
	var pos := Vector2.ZERO
	var vel := Vector2.ZERO
	var radius := 4.0
	var damage := 0.0
	var team := "enemy"
	var pierce := 0
	var life := 60
	var alive := true
	var hit_ids: Array = []
	var owner_id := 0


var rng := RandomNumberGenerator.new()
var frame := 0
var units: Array = []
var shots: Array = []
var player: Unit = null
var inputs := {}
var habits = null          # 플레이어 습관 기록기 (없어도 된다)
var events: Array = []     # 이번 프레임에 일어난 일 (화면 효과용)
var kills := 0
var _next_id := 1


func _init(seed_value: int = 1) -> void:
	rng.seed = seed_value


# ---------------- 만들기 ----------------
func _new_unit(team: String, kind: String, pos: Vector2) -> Unit:
	var u := Unit.new()
	u.id = _next_id
	_next_id += 1
	u.team = team
	u.kind = kind
	u.pos = pos
	units.append(u)
	return u


func _apply_build(u: Unit, weapon: String, abilities: Array) -> void:
	u.weapon = weapon
	u.abilities = abilities.duplicate()
	u.speed = Data.PLAYER_SPEED * (1.25 if u.has("sprint") else 1.0)
	u.dodge_max = 2 if u.has("double_roll") else 1
	u.dodge_charges = u.dodge_max
	u.radius = Data.PLAYER_RADIUS
	u.state = "ready"


func spawn_player(weapon: String, abilities: Array, pos := Vector2(320, 300), hp := Data.PLAYER_HP) -> Unit:
	var u := _new_unit("player", "player", pos)
	_apply_build(u, weapon, abilities)
	u.max_hp = Data.PLAYER_HP
	u.hp = hp
	u.facing = Vector2.UP
	player = u
	return u


func spawn_enemy(kind: String, pos: Vector2) -> Unit:
	var spec: Dictionary = Data.ENEMIES[kind]
	var u := _new_unit("enemy", kind, pos)
	u.hp = spec["hp"]
	u.max_hp = spec["hp"]
	u.speed = spec["speed"]
	u.radius = spec["radius"]
	u.state = "spawn"
	u.timer = Data.SPAWN_DELAY
	if kind == "archer":
		u.timer = Data.SPAWN_DELAY + rng.randi_range(0, 40)
	return u


func spawn_echo(profile: Dictionary, pos := Vector2(320, 80), seed_value := 7) -> Unit:
	var u := _new_unit("enemy", "echo", pos)
	_apply_build(u, profile["weapon"], profile["abilities"])
	u.max_hp = Data.ECHO_HP
	u.hp = Data.ECHO_HP
	u.is_echo = true
	u.facing = Vector2.DOWN
	u.brain = Echo.Brain.new(Echo.brain_params(profile["habits"], profile["weapon"]), seed_value)
	return u


# ---------------- 한 프레임 ----------------
func step(player_inputs: Dictionary) -> void:
	inputs = player_inputs
	events.clear()
	for s in SYSTEMS:
		call(s)
	frame += 1


func update_controlled() -> void:
	for u in units:
		if not u.alive:
			continue
		if u == player:
			_control(u, inputs)
		elif u.brain != null:
			_control(u, u.brain.decide(self, u))


func _control(u: Unit, inp: Dictionary) -> void:
	u.attack_cd = maxi(0, u.attack_cd - 1)
	u.invuln = maxi(0, u.invuln - 1)
	u.hit_flash = maxi(0, u.hit_flash - 1)
	if u.dodge_charges < u.dodge_max:
		u.dodge_recharge -= 1
		if u.dodge_recharge <= 0:
			u.dodge_charges += 1
			u.dodge_recharge = Data.DODGE_RECHARGE if u.dodge_charges < u.dodge_max else 0
	if u.exposed > 0:
		u.exposed -= 1
		return
	if u.state == "windup":
		u.timer -= 1
		if u.timer <= 0:
			u.state = "ready"
			_attack(u)
		return
	var move: Vector2 = inp.get("move", Vector2.ZERO)
	if move.length() > 1.0:
		move = move.normalized()
	var aim: Vector2 = inp.get("aim", Vector2.ZERO)
	if aim.length() > 0.01:
		u.facing = aim.normalized()
	elif move.length() > 0.01:
		u.facing = move.normalized()

	if u.dodge_t > 0:
		u.pos += u.dodge_dir * u.speed * Data.DODGE_SPEED_MUL
		u.dodge_t -= 1
		if u.dodge_t == 0:
			_on_dodge_end(u)
	elif inp.get("dodge", false) and u.dodge_charges > 0:
		u.dodge_charges -= 1
		if u.dodge_recharge <= 0:
			u.dodge_recharge = Data.DODGE_RECHARGE
		u.dodge_t = Data.DODGE_FRAMES
		u.dodge_dir = move.normalized() if move.length() > 0.01 else u.facing
		u.invuln = maxi(u.invuln, Data.DODGE_FRAMES)
		_event("dodge", u)
		if u == player and habits != null:
			habits.on_dodge(threat_toward(u, 90.0) != null)
	else:
		u.pos += move * u.speed
		if inp.get("attack", false) and u.attack_cd == 0:
			if u.is_echo:
				u.state = "windup"
				u.timer = Data.ECHO_WINDUP
				_event("windup", u)
			else:
				_attack(u)
	_clamp(u)


func _on_dodge_end(u: Unit) -> void:
	if u.has("blast_roll"):
		for t in _foes_of(u):
			if t.pos.distance_to(u.pos) <= 44.0 + t.radius:
				_damage(t, 10.0, u)
		_event("blast", u)
		_used(u, "blast_roll")
	if u.is_echo:
		u.exposed = Data.ECHO_EXPOSED
		_event("exposed", u)


func _attack(u: Unit) -> void:
	var w: Dictionary = Data.WEAPONS[u.weapon]
	var dmg: float = w["damage"] * (1.3 if u.has("heavy") else 1.0)
	var cd: float = w["cooldown"] * (1.15 if u.has("heavy") else 1.0)
	if u.is_echo:
		cd *= Data.ECHO_ATTACK_CD_MUL
	u.attack_cd = int(cd)
	u.last_attack_frame = frame
	if u.has("heavy"):
		_used(u, "heavy")
	if u == player and habits != null:
		habits.on_attack()
	if u.weapon == "sword":
		var reach: float = w["range"] + (12.0 if u.has("pierce") else 0.0)
		var arc: float = 360.0 if u.has("spin") else w["arc"]
		if u.has("spin"):
			_used(u, "spin")
		if u.has("pierce"):
			_used(u, "pierce")
		for t in _foes_of(u):
			var to: Vector2 = t.pos - u.pos
			if to.length() <= reach + u.radius + t.radius:
				if arc >= 360.0 or absf(u.facing.angle_to(to)) <= deg_to_rad(arc / 2.0):
					_damage(t, dmg, u)
		_event("slash", u, {"arc": arc, "reach": reach + u.radius})
	else:
		var dirs := [u.facing]
		if u.has("spin"):
			dirs = [u.facing.rotated(-0.26), u.facing, u.facing.rotated(0.26)]
			_used(u, "spin")
		for d in dirs:
			var s := Shot.new()
			s.pos = u.pos + d * (u.radius + 4.0)
			s.vel = d * float(w["shot_speed"])
			s.damage = dmg
			s.team = u.team
			s.pierce = 2 if u.has("pierce") else 0
			s.life = w["life"]
			s.owner_id = u.id
			shots.append(s)
		_event("shoot", u)


func _damage(t: Unit, amount: float, src) -> void:
	if not t.alive or t.invuln > 0:
		return
	var dmg := amount * (Data.ECHO_EXPOSED_DMG_MUL if t.exposed > 0 else 1.0)
	t.hp -= dmg
	t.hit_flash = 6
	if t.team == "player":
		t.invuln = Data.HURT_INVULN
	_event("hit", t, {"amount": dmg})
	if t.has("thorns") and src != null and src.alive and src.team != t.team:
		_used(t, "thorns")
		_damage(src, 6.0, null)
	if t.hp <= 0.0:
		t.hp = 0.0
		t.alive = false
		_event("death", t)
		if src != null and src.alive and src.team != t.team:
			if src.has("bloodthirst"):
				src.hp = minf(src.max_hp, src.hp + 4.0)
				_used(src, "bloodthirst")
			if src == player:
				kills += 1


func _used(u: Unit, ability: String) -> void:
	if u == player and habits != null:
		habits.on_ability(ability)


# ---------------- 적 ----------------
func update_enemies() -> void:
	if player == null:
		return
	for u in units:
		if not u.alive or u.team != "enemy" or u.brain != null:
			continue
		var spec: Dictionary = Data.ENEMIES[u.kind]
		u.hit_flash = maxi(0, u.hit_flash - 1)
		if u.state == "spawn":
			u.timer -= 1
			if u.timer <= 0:
				u.state = "idle"
				u.timer = 0
			continue
		var to: Vector2 = player.pos - u.pos
		var d := maxf(to.length(), 0.001)
		var dir := to / d
		match u.kind:
			"slime":
				u.pos += dir * u.speed
			"archer":
				if d < spec["keep"] - 20.0:
					u.pos -= dir * u.speed
				elif d > spec["keep"] + 30.0:
					u.pos += dir * u.speed
				else:
					u.pos += dir.orthogonal() * u.speed * 0.5
				u.timer -= 1
				if u.state == "idle" and u.timer <= 0:
					u.state = "aim"
					u.timer = spec["aim"]
					u.aim_dir = dir
				elif u.state == "aim":
					u.aim_dir = dir
					if u.timer <= 0:
						var s := Shot.new()
						s.pos = u.pos + dir * (u.radius + 3.0)
						s.vel = dir * float(spec["shot_speed"])
						s.damage = spec["shot_damage"]
						s.team = "enemy"
						s.life = 180
						s.owner_id = u.id
						shots.append(s)
						u.state = "idle"
						u.timer = spec["reload"]
			"charger":
				match u.state:
					"idle":
						u.pos += dir * u.speed
						if d < spec["sight"]:
							u.state = "telegraph"
							u.timer = spec["telegraph"]
							u.aim_dir = dir
					"telegraph":
						u.timer -= 1
						if u.timer <= 0:
							u.state = "dash"
							u.timer = spec["dash"]
					"dash":
						u.pos += u.aim_dir * float(spec["dash_speed"])
						u.timer -= 1
						if u.timer <= 0:
							u.state = "recover"
							u.timer = spec["recover"]
					"recover":
						u.timer -= 1
						if u.timer <= 0:
							u.state = "idle"
		_clamp(u)


func update_shots() -> void:
	for s in shots:
		s.pos += s.vel
		s.life -= 1
		if s.life <= 0 or not ROOM.grow(8.0).has_point(s.pos):
			s.alive = false


func resolve_combat() -> void:
	for s in shots:
		if not s.alive:
			continue
		for u in units:
			if not u.alive or u.team == s.team or s.hit_ids.has(u.id):
				continue
			if s.pos.distance_to(u.pos) <= s.radius + u.radius:
				s.hit_ids.append(u.id)
				_damage(u, s.damage, _unit_by_id(s.owner_id))
				if s.pierce > 0:
					s.pierce -= 1
				else:
					s.alive = false
					break
	if player == null or not player.alive:
		return
	for u in units:
		if not u.alive or u.team != "enemy" or u.is_echo or u.state == "spawn":
			continue
		if u.pos.distance_to(player.pos) <= u.radius + player.radius:
			var spec: Dictionary = Data.ENEMIES[u.kind]
			var dmg: float = spec["dash_contact"] if u.state == "dash" else spec["contact"]
			_damage(player, dmg, u)


func separate_units() -> void:
	var n := units.size()
	for i in n:
		var a: Unit = units[i]
		if not a.alive or a.dodge_t > 0:
			continue
		for j in range(i + 1, n):
			var b: Unit = units[j]
			if not b.alive or b.dodge_t > 0:
				continue
			var delta: Vector2 = b.pos - a.pos
			var d := delta.length()
			var m := a.radius + b.radius
			if d > 0.0 and d < m:
				var push := delta / d * (m - d) * 0.5
				a.pos -= push
				b.pos += push


func cleanup() -> void:
	var keep: Array = []
	for u in units:
		if u.alive or u == player:
			keep.append(u)
	units = keep
	var ks: Array = []
	for s in shots:
		if s.alive:
			ks.append(s)
	shots = ks
	for u in units:
		_clamp(u)
	if habits != null:
		habits.sample(self)


# ---------------- 도우미 ----------------
func _clamp(u: Unit) -> void:
	u.pos.x = clampf(u.pos.x, WALL + u.radius, ROOM.size.x - WALL - u.radius)
	u.pos.y = clampf(u.pos.y, WALL + u.radius, ROOM.size.y - WALL - u.radius)


func _foes_of(u: Unit) -> Array:
	var out: Array = []
	for t in units:
		if t.alive and t.team != u.team:
			out.append(t)
	return out


func _unit_by_id(id: int):
	for u in units:
		if u.id == id:
			return u
	return null


func _event(kind: String, u: Unit, extra := {}) -> void:
	var e := {"kind": kind, "pos": u.pos, "unit": u.id, "facing": u.facing, "team": u.team}
	e.merge(extra)
	events.append(e)


func nearest_foe(u: Unit):
	var best = null
	var bd := INF
	for t in units:
		if t.alive and t.team != u.team and t.state != "spawn":
			var d: float = t.pos.distance_squared_to(u.pos)
			if d < bd:
				bd = d
				best = t
	return best


func foes_left() -> int:
	var n := 0
	for u in units:
		if u.alive and u.team == "enemy":
			n += 1
	return n


## 위험이 다가오는 방향(정규화)을 돌려준다. 없으면 null.
func threat_toward(u: Unit, radius: float):
	for s in shots:
		if s.alive and s.team != u.team:
			var to: Vector2 = u.pos - s.pos
			if to.length() < radius and to.dot(s.vel) > 0.0:
				return s.vel.normalized()
	for t in units:
		if not t.alive or t.team == u.team:
			continue
		var to: Vector2 = u.pos - t.pos
		var d := to.length()
		if (t.state == "telegraph" or t.state == "dash") and d < radius * 2.0:
			var side := absf(t.aim_dir.cross(to))
			if side < u.radius + t.radius + 6.0 and t.aim_dir.dot(to) > 0.0:
				return t.aim_dir
		if t.state != "spawn" and d < t.radius + u.radius + 10.0:
			return to.normalized() if d > 0.0 else Vector2.RIGHT
		if t.state == "windup" and d < 90.0:
			return t.facing
		if t.weapon == "sword" and frame - t.last_attack_frame <= 4 and d < 60.0:
			return t.facing
	return null


func observe() -> Dictionary:
	var foes: Array = []
	for t in units:
		if t.alive and t.team != "player":
			foes.append({"kind": t.kind, "pos": t.pos, "hp": t.hp, "state": t.state, "aim_dir": t.aim_dir, "exposed": t.exposed > 0})
	var ps: Array = []
	for s in shots:
		ps.append({"pos": s.pos, "vel": s.vel, "team": s.team})
	var p := {}
	if player != null:
		p = {"pos": player.pos, "hp": player.hp, "can_attack": player.attack_cd == 0,
			"can_dodge": player.dodge_t == 0 and player.dodge_charges > 0, "weapon": player.weapon}
	return {"frame": frame, "player": p, "foes": foes, "shots": ps}


func state_hash() -> String:
	var parts := PackedStringArray([str(frame)])
	for u in units:
		parts.append("%s:%.3f,%.3f,%.2f" % [u.kind, u.pos.x, u.pos.y, u.hp])
	for s in shots:
		parts.append("s:%.3f,%.3f" % [s.pos.x, s.pos.y])
	return ",".join(parts).md5_text().substr(0, 16)
