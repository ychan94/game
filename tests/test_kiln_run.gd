extends "res://tests/suite.gd"
## 가마의 병사 한 판(밤 5번): 누적·빚기·다시 굽기·합치기·흙·균형

const PD = preload("res://src/proto/data.gd")
const KilnRun = preload("res://src/proto/kiln_run.gd")
const Battle = preload("res://src/proto/battle.gd")

const PLAN_ROLES := ["shield", "spear", "archer", "spear", "archer", "shield", "spear", "archer"]


## 봇: 합칠 수 있으면 합치고, 빚을 수 있으면 빚고(처음 셋은 같은 유약), 흙이 남으면 다시 굽는다
func bot_prep(run, heat: int) -> void:
	while not run.merge_groups().is_empty():
		run.merge(run.merge_groups()[0])
	var i: int = run.army.size()
	while run.can_craft():
		var el: String = "fire" if i < 4 else ["water", "earth", "fire"][i % 3]
		run.craft(PLAN_ROLES[i % PLAN_ROLES.size()], el)
		i += 1
	for s in run.army.duplicate():
		if s["tier"] == "normal" and run.can_refire(s["id"]):
			run.refire(s["id"])
	run.kiln.heat = heat
	run.fire()
	while not run.merge_groups().is_empty():
		run.merge(run.merge_groups()[0])


func play(seed_value: int, heat: int) -> Dictionary:
	var run = KilnRun.new(seed_value)
	var hp_log: Array = []
	while run.state == "prep":
		bot_prep(run, heat)
		var b = run.start_night()
		while not b.done and b.frame < 60 * 90:
			b.step()
		run.end_night(b)
		hp_log.append(roundi(run.village_hp))
	return {"state": run.state, "night": mini(run.night, PD.KILN_NIGHTS), "army": run.army.size(), "hp": hp_log,
		"stars": run.army.map(func(s): return s["star"]).reduce(func(a, x): return a + x, 0)}


func test_army_carries_over_nights() -> bool:
	var run = KilnRun.new(3)
	check(run.craft("spear", "fire") and run.craft("shield", "earth"), "흙 15로 빚기")
	run.fire()
	check(run.army.size() == 2, "가마를 열면 군대에 들어온다")
	var b = run.start_night()
	b.units = b.units.filter(func(u): return u.team == "ally")
	b.spawn_queue = []
	b.step()
	run.end_night(b)
	check(run.state == "prep" and run.night == 2 and run.army.size() == 2, "밤이 지나도 병사가 남는다")
	check(run.clay == PD.CLAY_START - 2 * PD.CLAY_CRAFT + PD.CLAY_PER_NIGHT, "밤을 넘기면 흙 보상")
	check(run.cap() == PD.ARMY_CAP_START + PD.ARMY_CAP_PER_NIGHT, "밤마다 자리 +1")
	return true


func test_cap_and_clay_limit_crafting() -> bool:
	var run = KilnRun.new(1)
	run.clay = 999
	var n := 0
	while run.craft("spear", "fire"):
		n += 1
	check(n == PD.KILN_SLOTS, "한 번에 가마 자리만큼만 넣는다: %d" % n)
	run.fire()
	while run.craft("spear", "fire"):
		pass
	run.fire()
	check(run.army.size() <= run.cap(), "병사 자리를 넘지 않는다")
	var r2 = KilnRun.new(1)
	r2.clay = PD.CLAY_CRAFT - 1
	check(not r2.craft("spear", "fire"), "흙이 모자라면 못 빚는다")
	return true


func test_refire_never_lowers_tier_and_safe_heat_never_cracks() -> bool:
	for seed_value in 30:
		var run = KilnRun.new(seed_value)
		run.clay = 100
		run.craft("spear", "fire")
		run.fire()
		var s: Dictionary = run.army[0]
		s["tier"] = "fine"
		run.refire(s["id"])
		run.kiln.heat = PD.KILN_SAFE_HEAT
		run.fire()
		check(run.army.size() == 1, "안전 구간에서는 다시 구워도 안 깨진다")
		check(PD.TIERS.find(run.army[0]["tier"]) >= PD.TIERS.find("fine"), "다시 구워도 등급은 안 내려간다")
	return true


func test_merge_three_raises_star() -> bool:
	var run = KilnRun.new(2)
	run.clay = 100
	for i in 3:
		run.craft("spear", "fire")
	run.kiln.heat = 0
	run.fire()
	run.army[1]["tier"] = "fine"
	var groups: Array = run.merge_groups()
	check(groups.size() == 1, "같은 병사 3명이면 합칠 수 있다")
	var m: Dictionary = run.merge(groups[0])
	check(run.army.size() == 1 and m["star"] == 2 and m["tier"] == "fine", "별 +1, 등급은 가장 좋은 것: %s" % [m])
	run.craft("spear", "water")
	run.fire()
	check(run.merge_groups().is_empty(), "유약이 다르면 못 합친다")
	return true


func test_waves_grow_and_chief_on_last_night() -> bool:
	var p1: Array = PD.wave_plan(1)
	var p5: Array = PD.wave_plan(PD.KILN_NIGHTS)
	check(p5.size() > p1.size(), "밤이 깊을수록 적이 많다: %d → %d" % [p1.size(), p5.size()])
	check(p5.any(func(e): return e[1] == "chief") and not p1.any(func(e): return e[1] == "chief"), "마지막 밤에만 도깨비 대장")
	return true


func test_synergy_wave_sweeps_left_to_right() -> bool:
	var b = Battle.new(1, [])
	for i in 3:
		b.add_ally("archer", "fire", "normal", "t")
	var near = b.add_enemy("goblin", 100.0)
	var far = b.add_enemy("goblin", 100.0)
	near.pos = Vector2(120, 100)
	far.pos = Vector2(560, 100)
	near.hp = 1000.0
	far.hp = 1000.0
	var hit_near := -1
	var hit_far := -1
	for i in PD.SYNERGY_FIRST + 120:
		near.pos = Vector2(120, 100)
		far.pos = Vector2(560, 100)
		b.step()
		if hit_near < 0 and near.burn_t > 0:
			hit_near = b.frame
		if hit_far < 0 and far.burn_t > 0:
			hit_far = b.frame
	check(hit_near > 0 and hit_far > hit_near, "파도가 가까운 적부터 차례로 맞힌다: %d, %d" % [hit_near, hit_far])
	return true


## 균형: 안전파(불 4)도 대체로 다섯 밤을 버티고, 끝까지 아슬아슬해야 한다
func test_balance_five_nights() -> bool:
	var safe := []
	var gamble := []
	for s in 6:
		safe.append(play(500 + s, PD.KILN_SAFE_HEAT))
		gamble.append(play(500 + s, 7))
	var sw := safe.filter(func(r): return r["state"] == "won").size()
	var gw := gamble.filter(func(r): return r["state"] == "won").size()
	print("RESULT_JSON:" + JSON.stringify({"proto": "kiln_run", "safe_wins": sw, "gamble_wins": gw, "safe": safe, "gamble": gamble}))
	check(sw >= 3, "안전하게 해도 절반 이상은 끝까지 가야 (억울함 방지): %d/6" % sw)
	check(sw <= 5, "안전하게만 해도 늘 이기면 긴장이 없다: %d/6" % sw)
	return true
