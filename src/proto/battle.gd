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
	var sneak := false       # 적: 아군을 피해 마을로 파고든다
	var boss_dmg := 0.0      # 아군: 대장에게 주는 피해 +
	var star := 1            # 아군: 별 (화면 표시)
	var heavy := false       # 적: 밀리지 않는다 (대장·거인·원귀)
	var summon_kind := ""    # 적 대장: 부하를 부른다
	var summon_every := 0
	var summon_t := 0
	var grow := 1.0
	var base_atk := 0.0
	var base_hp := 0.0
	# 스킬 (병사: 제 스킬 + 전직으로 흡수한 스킬)
	var skills: Array = []        # 역할 이름들
	var skill_t: Array = []
	var skill_lv := 0
	var skill_pow := 1.0          # 비급서 등
	var cdr := 0.0                # 스킬 재사용 단축
	# 잠깐 걸리는 효과
	var guard_t := 0              # 방패 벽: 받는 피해 -40%
	var buff_t := 0               # 진군의 북: 공격력 ↑
	var buff_val := 0.0
	var haste_t := 0              # 진군의 북 ★5: 공격 속도 ↑
	var taunt_t := 0              # 방패 벽 ★5: 적을 끌어당김
	var shield_hp := 0.0          # 보호막 (먼저 깎인다)
	# 목표 붙잡기 (앞뒤로 오가지 않게)
	var tgt = null
	var idle_t := 0
	var fixed_home := false       # 사용자가 직접 배치한 자리
	var move_t := 0               # 전투 중 이동 명령: 걷는 동안은 싸우지 않는다
	var hit_flash := 0
	var alive := true


var rng := RandomNumberGenerator.new()
var frame := 0
var units: Array = []
var events: Array = []
var village_hp := D.VILLAGE_HP
var spawn_queue: Array = []
var synergy_t := {}             # 합동 기술 남은 시간 {combo_id: 프레임}
var combo_id := ""               # 고른 합동 기술 (D.COMBOS), 없으면 ""
var no_rout := false             # 시험용: 아군이 없어도 전투를 끝내지 않는다
var night_loss := 0.0             # 이번 밤 마을이 잃은 체력 (상한 ROUT_CAP)
var had_allies := false           # 아군이 한 번이라도 있었나 (아군 없는 시험 전투는 약탈로 끝내지 않는다)
var combo_pow_mul := 1.0          # 전술 강화: 합동 기술 피해 배율
var combo_heal := 0.0             # 전술 강화: 합동 기술 때 모든 아군 회복
var combo_cd_mul := 1.0          # 전술 강화: 합동 기술 재사용 배율
var combo_first_cut := 0         # 전술 강화: 첫 발동 앞당김 (프레임)
var done := false
var result := ""
var stats := {"kills": 0, "specials": 0, "synergies": 0, "damage": 0.0}
var _next_id := 1
var synergy_power: float = D.SYNERGY_POWER
var waves: Array = []           # 지나가는 합동 기술 파도 [{element, x, power}]
var village_guard := 0.0       # 전술 강화: 마을이 받는 피해 감소
var _summons: Array = []        # 이번 프레임에 대장이 부른 부하 [[종류, 자리, 능력치]]


func _init(seed_value: int, plan: Array = []) -> void:
	rng.seed = seed_value
	spawn_queue = (plan if not plan.is_empty() else D.wave_plan()).duplicate(true)


# ---------------- 만들기 ----------------
## mods: 장비·상점·진영·전직 배율 {atk, hp, haste, regen, shield, cdr, skill, skills(추가 스킬), star}
## home: 사용자가 배치한 자리 (없으면 대열에 맞춰 자동)
func add_ally(role: String, element: String, tier: String, name: String, stat_mul := 1.0, mods := {}, home := Vector2.INF) -> U:
	had_allies = true
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
	u.boss_dmg = mods.get("boss_dmg", 0.0)
	u.heal = D.HEAL_AMOUNT * (1.0 + (m - 1.0) * D.HEAL_SCALE) if role == "healer" else 0.0
	u.range = s["range"] * (1.0 + mods.get("range", 0.0))
	u.cd_max = maxi(6, roundi(s["cd"] / (1.0 + mods.get("haste", 0.0))))
	u.speed = s["speed"]
	u.radius = 9.0 + (3.0 if tier == "legend" else 0.0) 
	u.base_atk = u.atk
	u.base_hp = u.max_hp
	u.special_t = D.SPECIAL_EVERY / 2
	u.shield_hp = u.max_hp * mods.get("shield", 0.0)
	# 고유 스킬은 가마의 병사(챕터 한 판)에만: kiln_run 이 별(star)을 넘겨줄 때. 1분 시험판·둥지 괴수는 스킬 없음
	u.skills = ([role] + mods.get("skills", [])) if mods.has("star") and D.SKILLS.has(role) else []
	u.skill_lv = D.skill_level(mods.get("star", 1))
	u.star = mods.get("star", 1)
	u.skill_pow = 1.0 + mods.get("skill", 0.0)
	u.cdr = clampf(mods.get("cdr", 0.0), 0.0, 0.6)
	for r in u.skills:
		u.skill_t.append(roundi(D.SKILLS[r]["cd"] * D.SKILL_FIRST * (1.0 - u.cdr)))
	units.append(u)
	if home != Vector2.INF:
		u.home = home
		u.pos = home
		u.fixed_home = true
	_arrange()
	return u


static func default_line() -> Dictionary:
	return {"shield": "front", "cavalry": "front", "haetae": "front", "hyeonmu": "front", "baekho": "front",
		"spear": "mid", "axe": "mid", "twin": "mid", "general": "mid", "cheoyong": "mid",
		"archer": "back", "slinger": "back", "sniper": "back",
		"healer": "rear", "cannon": "rear", "dragon": "rear", "jujak": "rear"}


## 병사를 둘 수 있는 곳: 마을 담장 앞부터 전장 끝까지 어디든 (사용자: "모든 맵에 자유롭게")
## 아군이 나갈 수 있는 오른쪽 끝: 적이 나오는 화면 끝까지 쫓아가 전투가 화면 밖으로 밀리지 않게
## 싸움터를 화면 가운데로 (2026-11-28 "거의 끝에서만 전투가 일어나니까 ... 적들이 조금 더 화면에 나올때부터 공격이 가능하도록")
## 아군은 화면 70% 선까지만 나가고, 적은 그 선 근처까지 걸어 들어와야 공격한다. 원거리 아군은 화면에 보이는 적만 쏜다
const ALLY_MAX_X: float = FIELD.size.x * 0.7
const ENEMY_ATTACK_X: float = ALLY_MAX_X + 24.0
const VISIBLE_X: float = FIELD.size.x - 24.0
const DEPLOY := Rect2(VILLAGE_X + 12.0, 12.0, ALLY_MAX_X - VILLAGE_X - 12.0, FIELD.size.y - 24.0)


## 아군 대열: 방패 앞, 창 가운데, 궁수 뒤 (직접 배치한 병사는 그대로)
func _arrange() -> void:
	var line_of := default_line()
	var col := {"front": VILLAGE_X + 160.0, "mid": VILLAGE_X + 118.0, "back": VILLAGE_X + 62.0, "rear": VILLAGE_X + 26.0}
	var by_line := {"front": [], "mid": [], "back": [], "rear": []}
	for u in units:
		if u.team == "ally" and not u.fixed_home:
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
	u.sneak = s.get("sneak", false)
	if u.sneak:
		u.speed *= D.SNEAK_SPEED
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
	elif had_allies and _count("ally") == 0 and not no_rout:
		# 아군 전멸: 남은 도깨비(+ 아직 안 온 도깨비)가 약탈하고 물러간다. 한 밤 약탈은 상한까지
		var loot := 0.0
		for u in units:
			if u.alive and u.team == "enemy":
				loot += u.village_dmg
		for e in spawn_queue:
			loot += D.ENEMIES[e[1]].get("village", 8.0)
		var lost: float = minf(loot, maxf(0.0, D.VILLAGE_HP * D.ROUT_CAP - night_loss))
		night_loss += lost
		village_hp -= lost
		events.append({"kind": "rout", "amount": lost})
		done = true
		result = "lose" if village_hp <= 0.0 else "hold"
		village_hp = maxf(0.0, village_hp)
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
	u.guard_t = maxi(0, u.guard_t - 1)
	u.buff_t = maxi(0, u.buff_t - 1)
	u.haste_t = maxi(0, u.haste_t - 1)
	u.taunt_t = maxi(0, u.taunt_t - 1)
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
		_tick_skills(u)
		_heal(u)
		return
	var target = _pick_target(u)
	if u.team == "enemy" and u.sneak:
		target = null   # 몰래 파고드는 도깨비는 싸우지 않고 마을로
	if u.team == "enemy":
		if target != null and u.pos.x <= ENEMY_ATTACK_X and u.pos.distance_to(target.pos) <= u.range + target.radius + u.radius:
			u.tgt = target
			_attack(u, target)
		else:
			u.tgt = null
			u.pos.x -= spd
			if target != null and absf(target.pos.y - u.pos.y) > 4.0 and u.pos.distance_to(target.pos) < 120.0:
				u.pos.y += signf(target.pos.y - u.pos.y) * spd * 0.6
			if u.pos.x <= VILLAGE_X:
				# 한 밤에 잃는 마을 체력은 상한까지 (그 뒤로 들어온 도깨비는 약탈하고 물러간다)
				var dmg: float = minf(u.village_dmg * (1.0 - village_guard), maxf(0.0, D.VILLAGE_HP * D.ROUT_CAP - night_loss))
				village_hp -= dmg
				night_loss += dmg
				u.alive = false
				events.append({"kind": "village_hit", "pos": u.pos, "amount": dmg, "unit": u.id})
		return
	# 아군: 목표를 붙잡고, 적이 정말 없을 때만 잠깐 기다렸다가 제자리로 (앞뒤로 오가지 않게)
	_tick_skills(u)
	if not u.alive:
		return
	if u.move_t > 0:
		u.move_t -= 1
		var d0: float = u.pos.distance_to(u.home)
		if d0 <= 2.0:
			u.move_t = 0
		else:
			u.pos += (u.home - u.pos).normalized() * minf(maxf(spd, 1.0) * 1.3, d0)
			return
	if target != null:
		var d: float = u.pos.distance_to(target.pos)
		if d <= u.range + target.radius + u.radius:
			u.idle_t = 0
			_attack(u, target)
		elif spd > 0.0 and (target.pos.distance_to(u.home) < D.ALLY_LEASH + D.ALLY_AGGRO or target.tgt == u):
			u.idle_t = 0
			u.pos += (target.pos - u.pos).normalized() * spd
			u.pos.x = minf(u.pos.x, ALLY_MAX_X)
		else:
			u.idle_t += 1
	else:
		u.idle_t += 1
	if u.idle_t > D.ALLY_LINGER and spd > 0.0 and u.pos.distance_to(u.home) > 2.0:
		u.pos += (u.home - u.pos).normalized() * minf(spd * 0.8, u.pos.distance_to(u.home))


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
		if u.team == "ally" and t.pos.x > VISIBLE_X:
			continue   # 아직 화면 밖
		var d: float = u.pos.distance_to(t.pos)
		if d < bd:
			bd = d
			best = t
		if u.team == "ally" and u.kind == "sniper" and d <= u.range and t.hp > sh:
			sh = t.hp
			strong = t
		if u.team == "enemy":
			var taunt: float = D.SHIELD_TAUNT if t.kind == "shield" else (D.HAETAE_TAUNT if t.kind == "haetae" else (D.HYEONMU_TAUNT if t.kind == "hyeonmu" else 0.0))
			if t.taunt_t > 0:
				taunt = maxf(taunt, 150.0)
			if taunt > 0.0 and d <= taunt and d < sd:
				sd = d
				shield = t
	if u.team == "ally":
		# 나를 때리는 적이 있으면 그 적부터 (멀리서 쏘는 적에게 가만히 맞고 있지 않게). 지금 목표를 이미 때리고 있으면 그대로
		var busy: bool = u.tgt != null and u.tgt.alive and u.pos.distance_to(u.tgt.pos) <= u.range + u.tgt.radius + u.radius
		if not busy:
			var att = null
			var ad := INF
			for t2 in units:
				if t2.alive and t2.team != u.team and t2.tgt == u and u.pos.distance_to(t2.pos) < ad:
					ad = u.pos.distance_to(t2.pos)
					att = t2
			if att != null:
				u.tgt = att
				return att
		# 붙잡은 목표가 살아 있고 너무 멀어지지 않았으면 그대로 (신궁은 사거리 안 가장 강한 적)
		if u.kind != "sniper" and u.tgt != null and u.tgt.alive and u.pos.distance_to(u.tgt.pos) <= maxf(u.range + 40.0, D.ALLY_AGGRO * 1.3):
			return u.tgt
		u.tgt = strong if strong != null else (best if best != null and bd <= maxf(u.range + 40.0, D.ALLY_AGGRO * 1.3) else null)
		return u.tgt
	if shield != null:
		return shield
	if best != null and bd <= 40.0 + u.range:
		return best
	return null


func _attack(u: U, t: U) -> void:
	if u.cd > 0:
		return
	u.cd = roundi(u.cd_max * (0.7 if u.haste_t > 0 else 1.0))
	var atk: float = u.atk * (_general_buff(u) * (1.0 + (u.buff_val if u.buff_t > 0 else 0.0)) if u.team == "ally" else 1.0)
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
	if u.team == "ally" and u.kind in ["axe", "cannon", "haetae", "jujak"]:
		var r := 34.0 if u.kind == "axe" else 44.0
		var k: float = {"axe": D.AXE_CLEAVE, "cannon": D.CANNON_SPLASH, "haetae": D.HAETAE_BREATH, "jujak": D.JUJAK_SPLASH}[u.kind]
		for o in units:
			if o.alive and o.team != u.team and o != t and o.pos.distance_to(t.pos) < r:
				_hurt(o, atk * k, u, true)
				if u.kind in ["haetae", "jujak"]:
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
	if src != null and src.boss_dmg > 0.0 and t.kind in D.BOSSES:
		a *= 1.0 + src.boss_dmg   # 전술 강화 '봉화'
	if t.kind == "shield" and t.team == "ally":
		a *= 1.0 - D.SHIELD_REDUCE
	if t.armor > 0.0:
		a = maxf(a * 0.25, a - t.armor)   # 갑옷: 약한 공격은 덜 들어간다 (최소 25%)
	if t.team == "ally":
		if t.kind == "hyeonmu":
			a *= 1.0 - D.HYEONMU_REDUCE
		if t.guard_t > 0:
			a *= 0.6
		if t.shield_hp > 0.0:
			var ab: float = minf(t.shield_hp, a)
			t.shield_hp -= ab
			a -= ab
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


## 요변·전설 하나가 혼자 쓰는 특수기 (주변 70px)
func _special(u: U) -> void:
	stats["specials"] += 1
	events.append({"kind": "special", "pos": u.pos, "element": u.element, "name": u.name, "unit": u.id})
	for t in units:
		if t.alive and t.team == "enemy" and t.pos.distance_to(u.pos) < 70.0:
			_element_burst(t, u.element, 30.0, u)


## 합동 기술 (병사 조합): 로비에서 고른 것(combo_id) 하나만. 필요한 병사가 살아 있으면 재사용마다 발동
func _synergy() -> void:
	if combo_id == "":
		return
	var roles: Array = []
	var n := 0
	var cr: Array = D.combo_roles(combo_id)
	for u in units:
		if u.alive and u.team == "ally":
			if not roles.has(u.kind):
				roles.append(u.kind)
			if cr.has(u.kind):
				n += 1
	if not D.combo_ok(combo_id, roles):
		synergy_t.erase(combo_id)
		return
	if not synergy_t.has(combo_id):
		synergy_t[combo_id] = maxi(30, roundi(D.SYNERGY_FIRST * combo_cd_mul) - combo_first_cut)
	synergy_t[combo_id] -= 1
	if synergy_t[combo_id] > 0:
		return
	synergy_t[combo_id] = roundi(D.SYNERGY_EVERY * combo_cd_mul)
	stats["synergies"] += 1
	var c: Dictionary = D.COMBOS[combo_id]
	# 피해: 조합에 드는 병사(살아 있는 그 종류 모두)의 공격력 합 × pct × 전술 강화
	var atk_sum := 0.0
	for u in units:
		if u.alive and u.team == "ally" and cr.has(u.kind):
			atk_sum += u.atk
	var dmg: float = atk_sum * c["pct"] * combo_pow_mul
	events.append({"kind": "synergy", "element": c["element"], "count": n, "name": c["name"], "combo": combo_id, "dmg": dmg, "atk_sum": atk_sum})
	waves.append({"element": c["element"], "x": VILLAGE_X, "power": dmg, "bonus": c["bonus"], "combo": true})
	if combo_heal > 0.0:
		for u2 in _allies():
			u2.hp = minf(u2.max_hp, u2.hp + u2.max_hp * combo_heal)
	for u in _allies():
		match c["bonus"]:
			"atk":
				u.buff_t = maxi(u.buff_t, D.COMBO_ATK_FRAMES)
				u.buff_val = maxf(u.buff_val, D.COMBO_ATK)
			"shield":
				u.shield_hp += u.max_hp * D.COMBO_SHIELD
			"heal":
				u.hp = minf(u.max_hp, u.hp + u.max_hp * D.COMBO_HEAL)


## 합동 기술 파도: 마을 쪽에서 오른쪽으로 휩쓸며, 지나가는 자리의 적이 맞는다
func _move_waves() -> void:
	for w in waves:
		var x0: float = w["x"]
		w["x"] = x0 + D.SYNERGY_WAVE_SPEED
		var hit: Array = w.get("hit", [])
		for u in units:
			if u.alive and u.team == "enemy" and u.pos.x > x0 and u.pos.x <= w["x"] and not hit.has(u.id):
				hit.append(u.id)   # 한 파도는 한 적을 한 번만 (해일에 밀린 적을 또 맞혀 끝까지 끌고 가지 않게)
				if w.get("combo", false):
					_combo_hit(u, w["element"], w["power"])
				else:
					_element_burst(u, w["element"], w["power"], null)
				match w.get("bonus", ""):
					"stun":
						u.stun_t = maxi(u.stun_t, D.COMBO_STUN)
					"slow":
						u.slow_t = maxi(u.slow_t, D.SLOW_FRAMES * 3)
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


## 합동 기술 파도 한 대: 계산한 피해 그대로 + 유약 효과 (불 화상 · 물 밀기·느리게 · 흙 기절)
func _combo_hit(t: U, element: String, dmg: float) -> void:
	_hurt(t, dmg, null, true)
	match element:
		"fire":
			t.burn_t = D.BURN_FRAMES
		"water":
			_push(t, 80.0)
			t.slow_t = D.SLOW_FRAMES * 2
		"earth":
			t.stun_t = maxi(t.stun_t, 90)


func state_hash() -> String:
	var parts := PackedStringArray([str(frame), str(village_hp)])
	for u in units:
		parts.append("%s:%.2f,%.2f,%.2f" % [u.kind, u.pos.x, u.pos.y, u.hp])
	return ",".join(parts).md5_text().substr(0, 16)


# ---------------- 고유 스킬 ----------------
func _tick_skills(u: U) -> void:
	if _count("enemy") == 0:
		return
	for i in u.skills.size():
		u.skill_t[i] -= 1
		if u.skill_t[i] <= 0:
			var role: String = u.skills[i]
			if role == "healer" and not units.any(func(o): return o.alive and o.team == "ally" and o.hp < o.max_hp * 0.9):
				u.skill_t[i] = 30
				continue
			u.skill_t[i] = roundi(D.SKILLS[role]["cd"] * (1.0 - u.cdr))
			_skill(u, role)


func _enemies() -> Array:
	return units.filter(func(o): return o.alive and o.team == "enemy")


func _allies() -> Array:
	return units.filter(func(o): return o.alive and o.team == "ally")


func _nearest_enemies(p: Vector2, n: int, max_d := INF) -> Array:
	var es: Array = _enemies().filter(func(o): return o.pos.distance_to(p) <= max_d and o.pos.x <= VISIBLE_X)
	es.sort_custom(func(a, b): return a.pos.distance_to(p) < b.pos.distance_to(p))
	return es.slice(0, n)


## 스킬 한 번. lv: ★3 = 1, ★4 = 2, ★5 = 3. 위력 = 1 + 0.5 × lv (비급서는 따로 곱한다)
func _skill(u: U, role: String) -> void:
	var lv: int = u.skill_lv
	var pw: float = (1.0 + 0.5 * lv) * u.skill_pow
	if u.element == "fire":
		pw *= D.SKILL_FIRE_POW   # 진사: 피해 +25%
	var atk: float = u.atk * _general_buff(u)
	var hits: Array = []
	var helped: Array = []   # 돕는 스킬을 받은 아군 (유약 효과를 준다)
	match role:
		"spear":
			var t = _nearest_enemies(u.pos, 1, 180.0)
			if not t.is_empty():
				u.pos = t[0].pos - Vector2(t[0].radius + u.radius, 0)
				u.pos.x = minf(u.pos.x, ALLY_MAX_X)
				_hurt(t[0], atk * D.SKILLS["spear"]["pct"] * pw, u, true)
				if lv >= 3:
					t[0].stun_t = maxi(t[0].stun_t, 60)
				hits = t
		"archer":
			hits = _nearest_enemies(u.pos, 3 + lv, u.range + 60.0)
			for t in hits:
				_hurt(t, atk * D.SKILLS["archer"]["pct"] * pw, u, true)
		"shield":
			for o in _allies():
				if o.pos.distance_to(u.pos) <= 70.0 + 30.0 * lv:
					o.guard_t = 240
					helped.append(o)
			if lv >= 3:
				u.taunt_t = 240
		"axe":
			hits = _nearest_enemies(u.pos, 99, 45.0 + 8.0 * lv)
			for t in hits:
				_hurt(t, atk * D.SKILLS["axe"]["pct"] * pw, u, true)
		"cavalry":
			var x0: float = u.pos.x
			var x1: float = minf(FIELD.size.x - 10.0, x0 + 110.0 + 30.0 * lv)
			for t in _enemies():
				if t.pos.x >= x0 - 10.0 and t.pos.x <= x1 and absf(t.pos.y - u.pos.y) < 26.0:
					_hurt(t, atk * D.SKILLS["cavalry"]["pct"] * pw, u, true)
					if lv >= 3:
						_push(t, 30.0)
					hits.append(t)
			u.pos.x = x1
		"slinger":
			var t2 = _nearest_enemies(u.pos, 1, u.range + 60.0)
			if not t2.is_empty():
				_hurt(t2[0], atk * D.SKILLS["slinger"]["pct"] * pw, u, true)
				t2[0].stun_t = maxi(t2[0].stun_t, 50 + 20 * lv)
				hits = t2
				if lv >= 2:
					for o in _nearest_enemies(t2[0].pos, 99, 36.0):
						if o != t2[0]:
							_hurt(o, atk * 1.2 * pw, u, true)
		"healer":
			for o in _allies():
				if o.pos.distance_to(u.pos) <= u.range + 30.0:
					var amt: float = minf(o.max_hp - o.hp, u.heal * 1.5 * (1.0 + 0.5 * lv) * u.skill_pow)
					o.hp += amt
					helped.append(o)
					if lv >= 3:
						o.shield_hp += o.max_hp * 0.1
					events.append({"kind": "heal", "pos": o.pos, "from": u.pos, "amount": amt, "unit": u.id, "target": o.id, "element": u.element})
		"cannon":
			var es: Array = _enemies()
			for i in (4 + lv):
				if es.is_empty():
					break
				var t3 = es[rng.randi() % es.size()]
				_hurt(t3, atk * D.SKILLS["cannon"]["pct"] * pw, u, true)
				for o in _nearest_enemies(t3.pos, 99, 30.0):
					if o != t3:
						_hurt(o, atk * D.SKILLS["cannon"]["pct"] * 0.5 * pw, u, true)
				hits.append(t3)
		"twin":
			for i in (6 + lv):
				var near: Array = _nearest_enemies(u.pos, 3, 46.0)
				if near.is_empty():
					break
				var t4 = near[i % near.size()]
				_hurt(t4, atk * D.SKILLS["twin"]["pct"] * pw, u, true)
				hits.append(t4)
		"general":
			for o in _allies():
				o.buff_t = 300
				o.buff_val = 0.3 + 0.1 * lv
				helped.append(o)
				if lv >= 3:
					o.haste_t = 300
		"sniper":
			var t5 = _nearest_enemies(u.pos, 1, u.range + 40.0)
			if not t5.is_empty():
				var dir: Vector2 = (t5[0].pos - u.pos).normalized()
				for o in _enemies():
					var rel: Vector2 = o.pos - u.pos
					if rel.dot(dir) > 0.0 and absf(rel.cross(dir)) < 16.0:
						_hurt(o, atk * D.SKILLS["sniper"]["pct"] * pw, u, true)
						hits.append(o)
		"haetae":
			for o in _enemies():
				if o.pos.x > u.pos.x - 10.0 and o.pos.distance_to(u.pos) < 90.0 + 30.0 * lv:
					_hurt(o, atk * D.SKILLS["haetae"]["pct"] * pw, u, true)
					o.burn_t = D.BURN_FRAMES * (2 if lv >= 3 else 1)
					hits.append(o)
		"cheoyong":
			for o in _nearest_enemies(u.pos, 99, 120.0 + 25.0 * lv):
				_hurt(o, atk * D.SKILLS["cheoyong"]["pct"] * pw, u, true)
				o.stun_t = maxi(o.stun_t, 60 + 20 * lv)
				hits.append(o)
		"dragon":
			for o in _enemies():
				_hurt(o, atk * D.SKILLS["dragon"]["pct"] * pw, u, true)
				o.slow_t = maxi(o.slow_t, 180)
				hits.append(o)
		"baekho":
			var best = null
			for o in _enemies():
				if best == null or o.hp > best.hp:
					best = o
			if best != null:
				u.pos = best.pos - Vector2(best.radius + u.radius, 0)
				u.pos.x = minf(u.pos.x, ALLY_MAX_X)
				_hurt(best, atk * D.SKILLS["baekho"]["pct"] * pw, u, true)
				for o in _nearest_enemies(best.pos, 99, 50.0):
					o.stun_t = maxi(o.stun_t, 45 + (30 if lv >= 3 else 0))
				hits = [best]
		"jujak":
			var es2: Array = _enemies()
			for i in (8 + 2 * lv):
				if es2.is_empty():
					break
				var t6 = es2[rng.randi() % es2.size()]
				_hurt(t6, atk * D.SKILLS["jujak"]["pct"] * pw, u, true)
				t6.burn_t = D.BURN_FRAMES
				hits.append(t6)
		"hyeonmu":
			for o in _allies():
				o.shield_hp += o.max_hp * (0.2 + 0.05 * lv) * u.skill_pow
				helped.append(o)
	# 유약 효과 (청자 느리게 · 진사 화상 · 흑유 기절+보호막 / 돕는 스킬은 회복 · 공격력 · 보호막)
	match u.element:
		"water":
			for o in hits:
				if o.alive:
					o.slow_t = maxi(o.slow_t, D.SKILL_WATER_SLOW)
			for o in helped:
				o.hp = minf(o.max_hp, o.hp + o.max_hp * D.SKILL_SUP_HEAL)
		"fire":
			for o in hits:
				if o.alive:
					o.burn_t = maxi(o.burn_t, D.BURN_FRAMES)
			for o in helped:
				if o.buff_t <= 0 or o.buff_val < D.SKILL_SUP_ATK:
					o.buff_val = maxf(o.buff_val if o.buff_t > 0 else 0.0, D.SKILL_SUP_ATK)
				o.buff_t = maxi(o.buff_t, 240)
		"earth":
			for o in hits:
				if o.alive:
					o.stun_t = maxi(o.stun_t, D.SKILL_EARTH_STUN)
			if not hits.is_empty():
				u.shield_hp += u.max_hp * D.SKILL_EARTH_SHIELD
			for o in helped:
				o.shield_hp += o.max_hp * D.SKILL_SUP_SHIELD
	stats["skills"] = stats.get("skills", 0) + 1
	events.append({"kind": "skill", "role": role, "unit": u.id, "pos": u.pos, "lv": lv, "element": u.element,
		"name": D.skill_name(role, u.element), "targets": hits.map(func(o): return o.pos)})



## 전투 중 이동 명령: 병사를 pos 로 보낸다 (그 자리를 새 제자리로). 마을 담장 앞 ~ 전장 안
func order_move(id: int, pos: Vector2) -> bool:
	for u in units:
		if u.id == id and u.alive and u.team == "ally":
			u.home = Vector2(clampf(pos.x, VILLAGE_X + 12.0, ALLY_MAX_X), clampf(pos.y, 16.0, FIELD.size.y - 16.0))
			u.fixed_home = true
			u.move_t = 240
			u.tgt = null
			u.idle_t = 0
			return true
	return false
