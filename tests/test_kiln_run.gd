extends "res://tests/suite.gd"
## 가마의 병사 한 판(밤 5번): 누적·뽑기(확률·천장)·다시 굽기·합치기·흙·새 병사 7종·균형

const PD = preload("res://src/proto/data.gd")
const KilnRun = preload("res://src/proto/kiln_run.gd")
const Battle = preload("res://src/proto/battle.gd")

## 봇: 자리가 꽉 찼을 때만 합치고, 자리·흙이 있으면 뽑고, 흙이 남으면 다시 굽는다
func bot_merge(run) -> void:
	while run.army.size() + run.queued_new() >= run.cap() and not run.merge_groups().is_empty():
		run.merge(run.merge_groups()[0])


func bot_prep(run, heat: int) -> void:
	bot_merge(run)
	while run.can_draw():
		run.draw()
	for s in run.army.duplicate():
		if s["tier"] == "normal" and run.can_refire(s["id"]):
			run.refire(s["id"])
	run.kiln.heat = heat
	run.fire()
	bot_merge(run)


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
	check(not run.draw("spear", "fire").is_empty() and not run.draw("shield", "earth").is_empty(), "처음 흙으로 뽑기")
	run.fire()
	check(run.army.size() == 2, "가마를 열면 군대에 들어온다")
	var b = run.start_night()
	b.units = b.units.filter(func(u): return u.team == "ally")
	b.spawn_queue = []
	b.step()
	run.end_night(b)
	check(run.state == "prep" and run.night == 2 and run.army.size() == 2, "밤이 지나도 병사가 남는다")
	check(run.clay == PD.CLAY_START - 2 * PD.CLAY_DRAW + PD.CLAY_PER_NIGHT, "밤을 넘기면 흙 보상")
	check(run.cap() == PD.ARMY_CAP_START + PD.ARMY_CAP_PER_NIGHT, "밤마다 자리가 는다")
	return true


func test_cap_and_clay_limit_drawing() -> bool:
	var run = KilnRun.new(1)
	run.clay = 999
	var n := 0
	while not run.draw().is_empty():
		n += 1
	check(n == mini(PD.KILN_SLOTS, run.cap()), "한 번에 가마 자리만큼만 넣는다: %d" % n)
	run.fire()
	while not run.draw().is_empty():
		pass
	run.fire()
	check(run.army.size() <= run.cap(), "병사 자리를 넘지 않는다")
	var r2 = KilnRun.new(1)
	r2.clay = PD.CLAY_DRAW - 1
	check(r2.draw().is_empty(), "흙이 모자라면 못 뽑는다")
	return true


## 뽑기 확률은 합이 1, 실제로 뽑아 봐도 표와 비슷하고, 천장이 지켜진다
func test_draw_odds_and_pity() -> bool:
	var odds: Dictionary = PD.draw_odds()
	var total := 0.0
	for r in odds:
		total += odds[r]
	check(absf(total - 1.0) < 0.001 and odds.size() == PD.KILN_ROLES.size(), "확률표 합 = 100%%: %.3f" % total)
	var counts := {}
	var max_gap := 0
	var gap := 0
	for s in 40:
		var run = KilnRun.new(900 + s)
		run.night = 99   # 자리 넉넉히
		for k in 60:
			run.clay = 99
			if run.queue.size() >= PD.KILN_SLOTS:
				run.queue = []
			var d: Dictionary = run.draw()
			counts[d["role"]] = counts.get(d["role"], 0) + 1
			if d["rarity"] == "epic":
				max_gap = maxi(max_gap, gap)
				gap = 0
			else:
				gap += 1
		gap = 0
	check(max_gap <= PD.DRAW_PITY, "귀함 없이 %d번을 넘기지 않는다 (천장): 최대 %d" % [PD.DRAW_PITY, max_gap])
	for r in PD.KILN_ROLES:
		var got: float = counts.get(r, 0) / 2400.0
		check(got > odds[r] * 0.6, "%s 이(가) 너무 안 나오지 않는다: %.3f (표 %.3f)" % [r, got, odds[r]])
	var run2 = KilnRun.new(5)
	var before: int = run2.clay
	run2.draw()
	run2.unqueue(0)
	check(run2.clay == before - PD.CLAY_DRAW + PD.CLAY_SMASH_BACK, "뽑은 병사를 부수면 흙을 조금만 돌려받는다 (공짜 다시 뽑기 막기)")
	return true


## 새 병사: 무당은 고치고, 도끼는 주변을 함께 베고, 화차는 터진 자리 주변을 맞힌다
func test_new_roles() -> bool:
	var b = Battle.new(1, [])
	var h = b.add_ally("healer", "water", "normal", "무당")
	var sp = b.add_ally("spear", "fire", "normal", "창")
	sp.hp = 10.0
	b.spawn_queue = []
	b.add_enemy("goblin", 50.0).pos = Vector2(600, 10)
	for i in 70:
		b.step()
	check(sp.hp > 10.0, "무당이 다친 병사를 고친다: %.1f" % sp.hp)
	for role in ["axe", "cannon"]:
		var b2 = Battle.new(1, [])
		var a = b2.add_ally(role, "earth", "normal", role)
		b2.spawn_queue = []
		var e1 = b2.add_enemy("goblin", 100.0)
		var e2 = b2.add_enemy("goblin", 100.0)
		e1.hp = 500.0
		e2.hp = 500.0
		for i in 200:
			e1.pos = a.pos + Vector2(30.0 if role == "axe" else 200.0, 0)
			e2.pos = e1.pos + Vector2(14, 10)
			b2.step()
		check(e2.hp < 500.0, "%s 은(는) 옆의 적도 맞힌다" % role)
	return true


func test_refire_never_lowers_tier_and_safe_heat_never_cracks() -> bool:
	for seed_value in 30:
		var run = KilnRun.new(seed_value)
		run.clay = 100
		run.draw("spear", "fire")
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
	for e in ["fire", "water", "earth"]:
		run.draw("spear", e)
	run.kiln.heat = 0
	run.fire()
	run.army[1]["tier"] = "fine"
	var groups: Array = run.merge_groups()
	check(groups.size() == 1, "같은 모양 3명이면 유약이 달라도 합칠 수 있다")
	var m: Dictionary = run.merge(groups[0])
	check(run.army.size() == 1 and m["star"] == 2 and m["tier"] == "fine" and m["element"] == "water",
		"별 +1, 등급은 가장 좋은 것, 유약은 그 병사 것: %s" % [m])
	run.draw("archer", "water")
	run.draw("archer", "water")
	run.fire()
	check(run.merge_groups().is_empty(), "모양이 다르거나 3명이 안 되면 못 합친다")
	return true


func test_waves_grow_and_chief_on_last_night() -> bool:
	var p1: Array = PD.wave_plan(1, true)
	var p5: Array = PD.wave_plan(PD.KILN_NIGHTS, true)
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
