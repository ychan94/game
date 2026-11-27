extends RefCounted
## 1분 시험판 공용 전투. 왼쪽 마을을 오른쪽에서 오는 도깨비 떼로부터 지킨다.
## 아군은 알아서 싸운다 (손놀림 없음). 화면과 무관하게 돌아간다.

const D = preload("res://src/proto/data.gd")

const FIELD := Rect2(0, 0, 640, 260)
const VILLAGE_X: float = D.VILLAGE_LINE


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
	var heal := 0.0
	var regen := 0.0         # 장비(약 호리병): 초당 최대 체력의 몇 할을 회복
	var armor := 0.0         # 적: 한 대마다 이만큼 피해를 깎는다
	var heavy := false       # 적: 밀리지 않는다 (대장·거인·원귀)
	var summon_kind := ""    # 적 대장: 부하를 부른다
	var summon_every := 0
	var summon_t := 0
	var grow := 1.0          # 불가사리: 처치할수록 커진다
	var base_atk := 0.0
	var base_hp := 0.0
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
var waves: Array = []           # 지나가는 합동 기술 파도 [{element, x, power}]
var _summons: Array = []        # 이번 프레임에 대장이 부른 부하 [[종류, 자리, 능력치]]


func _init(seed_value: int, plan: Array = []) -> void:
	rng.seed = seed_value
	spawn_queue = (plan if not plan.is_empty() else D.wave_plan()).duplicate(true)


# ---------------- 만들기 ----------------
## mods: 장비 배율 {atk, hp, haste, regen}
func add_ally(role: String, element: String, tier: String, name: String, stat_mul := 1.0, mods := {}) -> U:
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
	u.max_hp = s["hp"] * m * (1.0 + mods.get("hp", 0.0))
	u.hp = u.max_hp
	u.atk = s["atk"] * m * (1.0 + mods.get("atk", 0.0))
	u.regen = mods.get("regen", 0.0)
	u.heal = D.HEAL_AMOUNT * (1.0 + (m - 1.0) * D.HEAL_SCALE) if role == "healer" else 0.0
	u.range = s["range"]
	u.cd_max = maxi(6, roundi(s["cd"] / (1.0 + mods.get("haste", 0.0))))
	u.speed = s["speed"]
	u.radius = 9.0 + (3.0 if tier == "legend" else 0.0) + (5.0 if role in ["haetae", "dragon", "bulgasari"] else 0.0)
	u.base_atk = u.atk
	u.base_hp = u.max_hp
	u.special_t = D.SPECIAL_EVERY / 2
	units.append(u)
	_arrange()
	return u


## 아군 대열: 방패 앞, 창 가운데, 궁수 뒤
func _arrange() -> void:
	var line_of := {"shield": "front", "cavalry": "front", "haetae": "front", "bulgasari": "front",
		"spear": "mid", "axe": "mid", "twin": "mid", "general": "mid", "cheoyong": "mid",
		"archer": "back", "slinger": "back", "sniper": "back",
		"healer": "rear", "cannon": "rear", "dragon": "rear"}
	var col := {"front": VILLAGE_X + 160.0, "mid": VILLAGE_X + 118.0, "back": VILLAGE_X + 62.0, "rear": VILLAGE_X + 26.0}
	var by_line := {"front": [], "mid": [], "back": [], "rear": []}
	for u in units:
		if u.team == "ally":
			by_line[line_of.get(u.kind, "mid")].append(u)
	for line in by_line:
		var list: Array = by_line[line]
		for i in list.size():
			var y := FIELD.size.y * (i + 1) / (list.size() + 1)
			list[i].home = Vector2(col[line] + (8.0 if i % 2 == 1 else 0.0), y)
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
	u.armor = s.get("armor", 0.0)
	u.heavy = s.get("heavy", false)
	if s.has("summon"):
		u.summon_kind = s["summon"][0]
		u.summon_every = s["summon"][1]
		u.summon_t = u.summon_every
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
	_move_waves()
	for u in units:
		if u.alive:
			_act(u)
	for e2 in _summons:
		var m = add_enemy(e2[0], clampf(e2[1].y + rng.randf_range(-40.0, 40.0), 20.0, FIELD.size.y - 20.0), e2[2])
		m.pos.x = e2[1].x + 20.0
		events.append({"kind": "summon", "pos": m.pos, "unit": m.id, "who": m.kind})
	_summons.clear()
	_spread_enemies()
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
	if u.regen > 0.0 and u.hp < u.max_hp:
		u.hp = minf(u.max_hp, u.hp + u.max_hp * u.regen / D.FPS)
	if u.team == "enemy" and u.summon_every > 0:
		u.summon_t -= 1
		if u.summon_t <= 0:
			u.summon_t = u.summon_every
			var ms: Dictionary = D.ENEMIES[u.summon_kind]
			var hk: float = u.max_hp / D.ENEMIES[u.kind]["hp"]   # 대장 체력 배율만큼 부하도
			_summons.append([u.summon_kind, u.pos, {"hp": ms["hp"] * maxf(1.0, hk) * 1.5}])
	if u.team == "ally" and u.kind == "cheoyong":
		for o in units:
			if o.alive and o.team == "enemy" and o.pos.distance_to(u.pos) < D.CHEOYONG_AURA:
				o.slow_t = maxi(o.slow_t, 2)
	if u.team == "ally" and u.tier == "legend":
		u.special_t -= 1
		if u.special_t <= 0:
			u.special_t = D.SPECIAL_EVERY
			_special(u)
	if u.team == "ally" and u.kind == "healer":
		_heal(u)
		return
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
				events.append({"kind": "village_hit", "pos": u.pos, "amount": u.village_dmg, "unit": u.id})
		return
	# 아군
	if target != null:
		var d: float = u.pos.distance_to(target.pos)
		if d <= u.range + target.radius + u.radius:
			_attack(u, target)
		elif spd > 0.0 and d < D.ALLY_AGGRO and target.pos.distance_to(u.home) < D.ALLY_LEASH + D.ALLY_AGGRO * 0.5:
			u.pos += (target.pos - u.pos).normalized() * spd
		elif spd > 0.0 and u.pos.distance_to(u.home) > 2.0:
			u.pos += (u.home - u.pos).normalized() * minf(spd, u.pos.distance_to(u.home))
	elif spd > 0.0 and u.pos.distance_to(u.home) > 2.0:
		u.pos += (u.home - u.pos).normalized() * minf(spd, u.pos.distance_to(u.home))


## 아군: 가장 가까운 적 (신궁은 사거리 안 가장 강한 적). 적: 근처 방패·해치 → 바로 옆 아군 → 없으면 null (마을로 행진)
func _pick_target(u: U):
	var best = null
	var bd := INF
	var shield = null
	var sd := INF
	var strong = null
	var sh := -1.0
	for t in units:
		if not t.alive or t.team == u.team:
			continue
		var d: float = u.pos.distance_to(t.pos)
		if d < bd:
			bd = d
			best = t
		if u.team == "ally" and u.kind == "sniper" and d <= u.range and t.hp > sh:
			sh = t.hp
			strong = t
		if u.team == "enemy":
			var taunt: float = D.SHIELD_TAUNT if t.kind == "shield" else (D.HAETAE_TAUNT if t.kind == "haetae" else 0.0)
			if taunt > 0.0 and d <= taunt and d < sd:
				sd = d
				shield = t
	if u.team == "ally":
		return strong if strong != null else best
	if shield != null:
		return shield
	if best != null and bd <= 40.0 + u.range:
		return best
	return null


func _attack(u: U, t: U) -> void:
	if u.cd > 0:
		return
	u.cd = u.cd_max
	var atk: float = u.atk * (_general_buff(u) if u.team == "ally" else 1.0)
	if u.team == "ally" and u.kind == "dragon":
		# 청룡: 앞쪽 한 줄을 모두 꿰뚫는다
		events.append({"kind": "beam", "from": u.pos, "to": Vector2(FIELD.size.x, t.pos.y), "element": u.element, "unit": u.id, "team": u.team})
		for o in units:
			if o.alive and o.team == "enemy" and o.pos.x > u.pos.x and absf(o.pos.y - t.pos.y) < D.DRAGON_LINE:
				_hurt(o, atk, u, true)
		return
	if u.range > 60.0:
		events.append({"kind": "shot", "from": u.pos, "to": t.pos, "team": u.team, "element": u.element, "unit": u.id, "target": t.id, "role": u.kind})
	else:
		events.append({"kind": "swing", "pos": u.pos, "to": t.pos, "team": u.team, "element": u.element, "unit": u.id, "target": t.id, "role": u.kind})
	_hurt(t, atk, u, true)
	if u.team == "ally" and u.kind in ["axe", "cannon", "haetae"]:
		var r := 34.0 if u.kind == "axe" else 44.0
		var k: float = {"axe": D.AXE_CLEAVE, "cannon": D.CANNON_SPLASH, "haetae": D.HAETAE_BREATH}[u.kind]
		for o in units:
			if o.alive and o.team != u.team and o != t and o.pos.distance_to(t.pos) < r:
				_hurt(o, atk * k, u, true)
				if u.kind == "haetae":
					o.burn_t = D.BURN_FRAMES
	if u.team == "ally" and u.kind == "slinger":
		_push(t, D.SLING_PUSH)
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
				_push(t, D.KNOCKBACK)


## 적을 오른쪽으로 민다 (대장·거인·원귀처럼 무거운 적은 안 밀린다)
func _push(t: U, dx: float) -> void:
	if not t.heavy:
		t.pos.x = minf(t.pos.x + dx, FIELD.size.x)


## 장수 곁이면 공격력 +30% (여럿이어도 한 번)
func _general_buff(u: U) -> float:
	for o in units:
		if o.alive and o.team == "ally" and o.kind == "general" and o != u and o.pos.distance_to(u.pos) <= D.GENERAL_AURA:
			return 1.0 + D.GENERAL_BUFF
	return 1.0


## 무당: 사거리 안에서 가장 많이 다친 병사를 고친다
func _heal(u: U) -> void:
	if u.cd > 0:
		return
	var best = null
	var worst := 0.98
	for o in units:
		if o.alive and o.team == "ally" and o.pos.distance_to(u.pos) <= u.range:
			var k: float = o.hp / o.max_hp
			if k < worst:
				worst = k
				best = o
	if best == null:
		return
	u.cd = u.cd_max
	var amt: float = minf(u.heal, best.max_hp - best.hp)
	best.hp += amt
	events.append({"kind": "heal", "pos": best.pos, "from": u.pos, "amount": amt, "unit": u.id, "target": best.id, "element": u.element})


func _hurt(t: U, amount: float, src, show: bool) -> void:
	if not t.alive:
		return
	var a := amount
	if t.kind == "shield" and t.team == "ally":
		a *= 1.0 - D.SHIELD_REDUCE
	if t.armor > 0.0:
		a = maxf(a * 0.25, a - t.armor)   # 갑옷: 약한 공격은 덜 들어간다 (최소 25%)
	t.hp -= a
	if t.team == "enemy":
		stats["damage"] += a
	if show:
		t.hit_flash = 5
		events.append({"kind": "hit", "pos": t.pos, "amount": a, "team": t.team, "unit": t.id, "from": src.pos if src != null else t.pos,
			"element": src.element if src != null else ""})
	if t.hp <= 0.0:
		t.alive = false
		events.append({"kind": "death", "pos": t.pos, "team": t.team, "big": t.kind in ["brute", "giant"] or t.kind in D.BOSSES or t.tier == "legend", "unit": t.id, "who": t.kind, "element": t.element})
		if t.team == "enemy":
			stats["kills"] += 1
			if src != null and src.kind == "bulgasari" and src.grow < D.BULGASARI_MAX:
				src.grow = minf(D.BULGASARI_MAX, src.grow + D.BULGASARI_GROW)
				src.atk = src.base_atk * src.grow
				var nh: float = src.base_hp * src.grow
				src.hp += nh - src.max_hp
				src.max_hp = nh


## 요변·전설 하나가 혼자 쓰는 특수기 (주변 70px)
func _special(u: U) -> void:
	stats["specials"] += 1
	events.append({"kind": "special", "pos": u.pos, "element": u.element, "name": u.name, "unit": u.id})
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
			waves.append({"element": e, "x": VILLAGE_X, "power": power})


## 합동 기술 파도: 마을 쪽에서 오른쪽으로 휩쓸며, 지나가는 자리의 적이 맞는다
func _move_waves() -> void:
	for w in waves:
		var x0: float = w["x"]
		w["x"] = x0 + D.SYNERGY_WAVE_SPEED
		var hit: Array = w.get("hit", [])
		for u in units:
			if u.alive and u.team == "enemy" and u.pos.x > x0 and u.pos.x <= w["x"] and not hit.has(u.id):
				hit.append(u.id)   # 한 파도는 한 적을 한 번만 (해일에 밀린 적을 또 맞혀 끝까지 끌고 가지 않게)
				_element_burst(u, w["element"], w["power"], null)
		w["hit"] = hit
	waves = waves.filter(func(w): return w["x"] < FIELD.size.x + 20.0)


## 도깨비끼리 겹치지 않게 살짝 밀어낸다
func _spread_enemies() -> void:
	var es: Array = []
	for u in units:
		if u.alive and u.team == "enemy" and u.stun_t == 0:
			es.append(u)
	for i in es.size():
		for j in range(i + 1, es.size()):
			var a = es[i]
			var c = es[j]
			var d: Vector2 = c.pos - a.pos
			var m: float = maxf(D.ENEMY_SPREAD, (a.radius + c.radius) * 0.8)
			var l := d.length()
			if l > 0.01 and l < m:
				var push := d / l * (m - l) * 0.25
				a.pos -= push
				c.pos += push


func _element_burst(t: U, element: String, power: float, src) -> void:
	match element:
		"fire":
			_hurt(t, power, src, true)
			t.burn_t = D.BURN_FRAMES
		"water":
			_hurt(t, power * 0.6, src, true)
			_push(t, 80.0)   # 대장은 밀리지 않는다 (밀기·느려짐이 걸음과 맞비겨 멈추지 않게)
			t.slow_t = D.SLOW_FRAMES * 2
		"earth":
			_hurt(t, power * 0.6, src, true)
			t.stun_t = 90


func state_hash() -> String:
	var parts := PackedStringArray([str(frame), str(village_hp)])
	for u in units:
		parts.append("%s:%.2f,%.2f,%.2f" % [u.kind, u.pos.x, u.pos.y, u.hp])
	return ",".join(parts).md5_text().substr(0, 16)
