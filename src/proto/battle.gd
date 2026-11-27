extends RefCounted
## 1분 시험판 공용 전투. 왼쪽 마을을 오른쪽에서 오는 도깨비 떼로부터 지킨다.
## 아군은 알아서 싸운다 (손놀림 없음). 화면과 무관하게 돌아간다.

const D = preload("res://src/proto/data.gd")

const FIELD := Rect2(0, 0, 640, 260)
const VILLAGE_X := 40.0


class U:
	var id := 0
	var team := "ally"
	var kind := ""        # 아군: 역할(spear/archer/shield), 적: 종류(goblin/imp/brute)
	var element := ""
	var tier := "normal"
	var name := ""
	var pos := Vector2.ZERO
	var home := Vector2.ZERO
	var hp := 10.0
	var max_hp := 10.0
	var atk := 1.0
	var range := 20.0
	var speed := 0.0
	var cd_max := 60
	var cd := 0
	var radius := 9.0
	var village_dmg := 0.0
	var slow_t := 0
	var burn_t := 0
	var stun_t := 0
	var special_t := 0
	var hit_flash := 0
	var alive := true


var rng := RandomNumberGenerator.new()
var frame := 0
var units: Array = []
var events: Array = []
var village_hp := D.VILLAGE_HP
var spawn_queue: Array = []
var synergy_t := {}
var done := false
var result := ""
var stats := {"kills": 0, "specials": 0, "synergies": 0, "damage": 0.0}
var _next_id := 1
var synergy_power: float = D.SYNERGY_POWER


func _init(seed_value: int, plan: Array = []) -> void:
	rng.seed = seed_value
	spawn_queue = (plan if not plan.is_empty() else D.wave_plan()).duplicate(true)


# ---------------- 만들기 ----------------
func add_ally(role: String, element: String, tier: String, name: String, stat_mul := 1.0) -> U:
	var s: Dictionary = D.ROLE_STATS[role]
	var u := U.new()
	u.id = _next_id
	_next_id += 1
	u.team = "ally"
	u.kind = role
	u.element = element
	u.tier = tier
	u.name = name
	var m: float = D.TIER_MUL[tier] * stat_mul
	u.max_hp = s["hp"] * m
	u.hp = u.max_hp
	u.atk = s["atk"] * m
	u.range = s["range"]
	u.cd_max = s["cd"]
	u.speed = s["speed"]
	u.radius = 9.0 + (3.0 if tier == "legend" else 0.0)
	u.special_t = D.SPECIAL_EVERY / 2
	units.append(u)
	_arrange()
	return u


## 아군 대열: 방패 앞, 창 가운데, 궁수 뒤
func _arrange() -> void:
	var col := {"shield": 190.0, "spear": 150.0, "archer": 95.0}
	var by_role := {"shield": [], "spear": [], "archer": []}
	for u in units:
		if u.team == "ally":
			by_role[u.kind].append(u)
	for role in by_role:
		var list: Array = by_role[role]
		for i in list.size():
			var y := FIELD.size.y * (i + 1) / (list.size() + 1)
			list[i].home = Vector2(col[role], y)
			list[i].pos = list[i].home


func add_enemy(kind: String, y: float, stat_override := {}) -> U:
	var s: Dictionary = D.ENEMIES.get(kind, {}).duplicate()
	s.merge(stat_override, true)
	var u := U.new()
	u.id = _next_id
	_next_id += 1
	u.team = "enemy"
	u.kind = kind
	u.name = s.get("name", kind)
	u.element = s.get("element", "")
	u.max_hp = s["hp"]
	u.hp = u.max_hp
	u.atk = s["atk"]
	u.range = s["range"]
	u.cd_max = s["cd"]
	u.speed = s["speed"]
	u.radius = s.get("radius", 9.0)
	u.village_dmg = s.get("village", 8.0)
	u.pos = Vector2(FIELD.size.x + 10.0, y)
	units.append(u)
	return u


# ---------------- 한 프레임 ----------------
func step() -> void:
	if done:
		return
	events.clear()
	while not spawn_queue.is_empty() and spawn_queue[0][0] <= frame:
		var e: Array = spawn_queue.pop_front()
		add_enemy(e[1], rng.randf_range(30.0, FIELD.size.y - 30.0), e[2] if e.size() > 2 else {})
	_synergy()
	for u in units:
		if u.alive:
			_act(u)
	var keep: Array = []
	for u in units:
		if u.alive:
			keep.append(u)
	units = keep
	if village_hp <= 0.0:
		village_hp = 0.0
		done = true
		result = "lose"
	elif spawn_queue.is_empty() and _count("enemy") == 0:
		done = true
		result = "win"
	frame += 1


func _count(team: String) -> int:
	var n := 0
	for u in units:
		if u.alive and u.team == team:
			n += 1
	return n


func _act(u: U) -> void:
	u.hit_flash = maxi(0, u.hit_flash - 1)
	u.cd = maxi(0, u.cd - 1)
	u.slow_t = maxi(0, u.slow_t - 1)
	if u.burn_t > 0:
		u.burn_t -= 1
		_hurt(u, D.BURN_DPS / D.FPS, null, false)
		if not u.alive:
			return
	if u.stun_t > 0:
		u.stun_t -= 1
		return
	var spd := u.speed * (D.SLOW_MUL if u.slow_t > 0 else 1.0)
	if u.team == "ally" and u.tier == "legend":
		u.special_t -= 1
		if u.special_t <= 0:
			u.special_t = D.SPECIAL_EVERY
			_special(u)
	var target = _pick_target(u)
	if u.team == "enemy":
		if target != null and u.pos.distance_to(target.pos) <= u.range + target.radius + u.radius:
			_attack(u, target)
		else:
			u.pos.x -= spd
			if target != null and absf(target.pos.y - u.pos.y) > 4.0 and u.pos.distance_to(target.pos) < 120.0:
				u.pos.y += signf(target.pos.y - u.pos.y) * spd * 0.6
			if u.pos.x <= VILLAGE_X:
				village_hp -= u.village_dmg
				u.alive = false
				events.append({"kind": "village_hit", "pos": u.pos, "amount": u.village_dmg})
		return
	# 아군
	if target != null:
		var d: float = u.pos.distance_to(target.pos)
		if d <= u.range + target.radius + u.radius:
			_attack(u, target)
		elif spd > 0.0 and d < 130.0:
			u.pos += (target.pos - u.pos).normalized() * spd
	elif spd > 0.0 and u.pos.distance_to(u.home) > 2.0:
		u.pos += (u.home - u.pos).normalized() * minf(spd, u.pos.distance_to(u.home))


## 아군: 가장 가까운 적. 적: 근처 방패 → 바로 옆 아군 → 없으면 null (마을로 행진)
func _pick_target(u: U):
	var best = null
	var bd := INF
	var shield = null
	var sd := INF
	for t in units:
		if not t.alive or t.team == u.team:
			continue
		var d: float = u.pos.distance_to(t.pos)
		if d < bd:
			bd = d
			best = t
		if t.kind == "shield" and d < sd:
			sd = d
			shield = t
	if u.team == "ally":
		return best
	if shield != null and sd <= D.SHIELD_TAUNT:
		return shield
	if best != null and bd <= 40.0 + u.range:
		return best
	return null


func _attack(u: U, t: U) -> void:
	if u.cd > 0:
		return
	u.cd = u.cd_max
	if u.range > 60.0:
		events.append({"kind": "shot", "from": u.pos, "to": t.pos, "team": u.team, "element": u.element})
	else:
		events.append({"kind": "swing", "pos": u.pos, "to": t.pos, "team": u.team, "element": u.element})
	_hurt(t, u.atk, u, true)
	if u.team == "ally":
		match u.element:
			"fire":
				t.burn_t = D.BURN_FRAMES
				for o in units:
					if o.alive and o.team != u.team and o != t and o.pos.distance_to(t.pos) < 32.0:
						_hurt(o, u.atk * D.FIRE_SPLASH, u, true)
			"water":
				t.slow_t = D.SLOW_FRAMES
			"earth":
				t.pos.x = minf(t.pos.x + D.KNOCKBACK, FIELD.size.x)


func _hurt(t: U, amount: float, src, show: bool) -> void:
	if not t.alive:
		return
	var a := amount
	if t.kind == "shield" and t.team == "ally":
		a *= 1.0 - D.SHIELD_REDUCE
	t.hp -= a
	if t.team == "enemy":
		stats["damage"] += a
	if show:
		t.hit_flash = 5
		events.append({"kind": "hit", "pos": t.pos, "amount": a, "team": t.team,
			"element": src.element if src != null else ""})
	if t.hp <= 0.0:
		t.alive = false
		events.append({"kind": "death", "pos": t.pos, "team": t.team, "big": t.kind == "brute" or t.tier == "legend"})
		if t.team == "enemy":
			stats["kills"] += 1


## 요변·전설 하나가 혼자 쓰는 특수기 (주변 70px)
func _special(u: U) -> void:
	stats["specials"] += 1
	events.append({"kind": "special", "pos": u.pos, "element": u.element, "name": u.name})
	for t in units:
		if t.alive and t.team == "enemy" and t.pos.distance_to(u.pos) < 70.0:
			_element_burst(t, u.element, 30.0, u)


## 같은 속성 3이면 합동 기술 (화면 전체)
func _synergy() -> void:
	var counts := {}
	for u in units:
		if u.alive and u.team == "ally" and u.element != "":
			counts[u.element] = counts.get(u.element, 0) + 1
	for e in counts:
		if counts[e] < D.SYNERGY_COUNT:
			synergy_t.erase(e)
			continue
		if not synergy_t.has(e):
			synergy_t[e] = D.SYNERGY_FIRST
		synergy_t[e] -= 1
		if synergy_t[e] <= 0:
			synergy_t[e] = D.SYNERGY_EVERY
			stats["synergies"] += 1
			var power: float = synergy_power * counts[e] / D.SYNERGY_COUNT
			events.append({"kind": "synergy", "element": e, "count": counts[e], "name": D.SYNERGY_NAME[e]})
			for t in units:
				if t.alive and t.team == "enemy":
					_element_burst(t, e, power, null)


func _element_burst(t: U, element: String, power: float, src) -> void:
	match element:
		"fire":
			_hurt(t, power, src, true)
			t.burn_t = D.BURN_FRAMES
		"water":
			_hurt(t, power * 0.6, src, true)
			t.pos.x = minf(t.pos.x + 80.0, FIELD.size.x)
			t.slow_t = D.SLOW_FRAMES * 2
		"earth":
			_hurt(t, power * 0.6, src, true)
			t.stun_t = 90


func state_hash() -> String:
	var parts := PackedStringArray([str(frame), str(village_hp)])
	for u in units:
		parts.append("%s:%.2f,%.2f,%.2f" % [u.kind, u.pos.x, u.pos.y, u.hp])
	return ",".join(parts).md5_text().substr(0, 16)
