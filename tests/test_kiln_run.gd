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


## 봇 한 판. max_chapter 챕터를 넘기면 멈춘다 (넘겼으면 state = "cleared")
func play(seed_value: int, heat: int, max_chapter := 1) -> Dictionary:
	var run = KilnRun.new(seed_value)
	var hp_log: Array = []
	while run.state == "prep":
		if run.chapter > max_chapter:
			break
		bot_prep(run, heat)
		var b = run.start_night()
		while not b.done and b.frame < 60 * 90:
			b.step()
		run.end_night(b)
		hp_log.append(roundi(run.village_hp))
	var st: String = "cleared" if run.state == "prep" or run.state == "won" else run.state
	return {"state": st, "chapter": run.chapter, "night": mini(run.night, PD.KILN_NIGHTS), "army": run.army.size(), "hp": hp_log,
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
	run.night = PD.KILN_NIGHTS
	run.chapter = 3
	check(run.cap() == PD.ARMY_CAP_MAX, "자리는 최대 %d" % PD.ARMY_CAP_MAX)
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


## 뽑기: 등급 6단계 확률 합이 1, 실제로 뽑아 봐도 표와 비슷하고, 등급별 천장·신화 조각이 지켜진다
func test_draw_odds_and_pity() -> bool:
	check(PD.GRADES.size() == 6, "등급 6단계")
	var odds: Dictionary = PD.draw_odds()
	var total := 0.0
	for r in odds:
		total += odds[r]
	check(absf(total - 1.0) < 0.001 and odds.size() == PD.KILN_ROLES.size(), "확률표 합 = 100%%: %.3f" % total)
	for g in PD.GRADES:
		check(PD.grade_roles(g).size() >= 2, "%s 등급에 병사가 2종 이상" % PD.GRADE_NAME[g])
		if g != "common":
			check(PD.GRADE_ODDS[g] < PD.GRADE_ODDS[PD.GRADES[PD.GRADES.find(g) - 1]], "%s 이(가) 아래 등급보다 드물다" % PD.GRADE_NAME[g])
	var counts := {}
	var gaps := {"rare": 0, "hero": 0, "legendary": 0}
	var max_gap := {"rare": 0, "hero": 0, "legendary": 0}
	var n := 0
	var myth_by_shards := 0
	for sd in 40:
		var run = KilnRun.new(900 + sd)
		run.chapter = 9   # 자리 넉넉히
		for k in gaps:
			gaps[k] = 0
		for k2 in 200:
			run.clay = 99
			if run.queue.size() >= PD.KILN_SLOTS:
				run.queue = []
			var shards_full: bool = run.myth_shards >= PD.MYTH_SHARDS
			var d: Dictionary = run.draw()
			n += 1
			counts[d["grade"]] = counts.get(d["grade"], 0) + 1
			if shards_full:
				check(d["grade"] == "mythic", "신화 조각 %d개면 신화 확정" % PD.MYTH_SHARDS)
				myth_by_shards += 1
			var gi: int = PD.GRADES.find(d["grade"])
			for k in gaps:
				if gi >= PD.GRADES.find(k):
					max_gap[k] = maxi(max_gap[k], gaps[k] + 1)
					gaps[k] = 0
				else:
					gaps[k] += 1
	for k in max_gap:
		check(max_gap[k] <= PD.PITY[k], "%s 이상은 %d번 안에 반드시 나온다 (천장): 최대 %d" % [PD.GRADE_NAME[k], PD.PITY[k], max_gap[k]])
	check(myth_by_shards > 0, "신화 조각으로 신화가 실제로 나온다: %d" % myth_by_shards)
	var common: float = counts.get("common", 0) / float(n)
	check(common > PD.GRADE_ODDS["common"] * 0.8, "일반은 표 확률만큼 나온다: %.3f" % common)
	var run2 = KilnRun.new(5)
	var before: int = run2.clay
	run2.draw()
	run2.unqueue(0)
	check(run2.clay == before - PD.CLAY_DRAW + PD.CLAY_SMASH_BACK, "뽑은 병사를 부수면 흙을 조금만 돌려받는다 (공짜 다시 뽑기 막기)")
	return true


## 챕터: 다섯째 밤을 넘기면 다음 챕터 (날 1로, 마을 회복, 흙 보너스), 챕터마다 적이 강하고 새 적·새 대장
func test_chapters_advance() -> bool:
	var run = KilnRun.new(4)
	run.night = PD.KILN_NIGHTS
	run.village_hp = 50.0
	var clay0: int = run.clay
	var b = run.start_night()
	b.units = b.units.filter(func(u): return u.team == "ally")
	b.spawn_queue = []
	b.step()
	run.end_night(b)
	check(run.chapter == 2 and run.night == 1 and run.state == "prep" and run.chapter_cleared, "다섯째 밤 뒤 챕터 2, 아침 1")
	check(run.village_hp == PD.VILLAGE_HP, "새 챕터는 마을이 다시 멀쩡")
	check(run.clay == clay0 + PD.CLAY_PER_NIGHT + PD.CLAY_PER_CHAPTER, "챕터 보너스 흙")
	for c in range(1, PD.CHAPTERS.size()):
		var a: Array = PD.wave_plan(1, true, c)
		var z: Array = PD.wave_plan(1, true, c + 1)
		var hp_a: float = a.filter(func(e): return e[1] == "goblin").map(func(e): return e[2].get("hp", PD.ENEMIES["goblin"]["hp"]))[0]
		var hp_z: float = z.filter(func(e): return e[1] == "goblin").map(func(e): return e[2].get("hp", PD.ENEMIES["goblin"]["hp"]))[0]
		check(hp_z > hp_a, "챕터 %d → %d 도깨비가 더 강하다" % [c, c + 1])
		var ch: Dictionary = PD.CHAPTERS[c]
		check(z.any(func(e): return e[1] == ch["new"]), "챕터 %d 에 새 적 %s" % [c + 1, ch["new"]])
		var last: Array = PD.wave_plan(PD.KILN_NIGHTS, true, c + 1)
		check(last.any(func(e): return e[1] == ch["boss"]), "챕터 %d 다섯째 밤 대장 %s" % [c + 1, ch["boss"]])
	run.chapter = PD.CHAPTERS.size()
	run.night = PD.KILN_NIGHTS
	var b2 = run.start_night()
	b2.units = b2.units.filter(func(u): return u.team == "ally")
	b2.spawn_queue = []
	b2.step()
	run.end_night(b2)
	check(run.state == "won", "마지막 챕터를 넘기면 끝까지 지켰다")
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
	# 청룡: 한 줄 꿰뚫기
	var b3 = Battle.new(1, [])
	var dr = b3.add_ally("dragon", "water", "normal", "청룡")
	b3.spawn_queue = []
	var row: Array = []
	for i in 3:
		var e = b3.add_enemy("goblin", 100.0)
		e.hp = 500.0
		row.append(e)
	for i in 120:
		for j in 3:
			row[j].pos = Vector2(dr.pos.x + 100.0 + j * 60.0, dr.pos.y)
		b3.step()
	check(row.all(func(e): return e.hp < 500.0), "청룡은 한 줄의 적을 모두 맞힌다")
	# 불가사리: 처치하면 커진다
	var b4 = Battle.new(1, [])
	var bg = b4.add_ally("bulgasari", "earth", "normal", "불가사리")
	b4.spawn_queue = []
	var atk0: float = bg.atk
	for i in 3:
		var e = b4.add_enemy("goblin", 100.0)
		e.hp = 1.0
		e.pos = bg.pos + Vector2(20, 0)
	for i in 200:
		b4.step()
	check(bg.atk > atk0, "불가사리는 처치할수록 강해진다: %.1f → %.1f" % [atk0, bg.atk])
	# 장수: 곁의 병사 공격력 +30%
	var b5 = Battle.new(1, [])
	var sp5 = b5.add_ally("spear", "fire", "normal", "창")
	check(b5._general_buff(sp5) == 1.0, "장수가 없으면 그대로")
	var gn = b5.add_ally("general", "fire", "normal", "장수")
	gn.pos = sp5.pos + Vector2(20, 0)
	check(b5._general_buff(sp5) > 1.0, "장수 곁이면 공격력이 오른다")
	# 갑옷 도깨비: 약한 공격은 덜 들어간다 / 대장은 부하를 부른다
	var b6 = Battle.new(1, [])
	b6.spawn_queue = []
	var ar = b6.add_enemy("armored", 100.0)
	var h0: float = ar.hp
	b6._hurt(ar, 5.0, null, false)
	check(h0 - ar.hp < 5.0, "갑옷이 피해를 깎는다: %.1f" % (h0 - ar.hp))
	var gm = b6.add_enemy("gumiho", 100.0)
	for i in 130:
		gm.pos.x = 600.0
		b6.step()
	check(b6.units.any(func(u): return u.kind == "fox"), "구미호는 여우를 부른다")
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


## 균형 (챕터 5개 한 판): 안전파(불 4) 봇이
##   - 챕터 1(입문)은 대체로 넘긴다 (억울함 방지)
##   - 챕터 5까지 다 깨지는 못한다 (긴장이 남는다)
##   - 평균 챕터 2~4 사이까지 간다 (챕터마다 점점 어려워진다)
func test_balance_chapters() -> bool:
	var runs := []
	for s in 6:
		runs.append(play(500 + s, PD.KILN_SAFE_HEAT, PD.CHAPTERS.size()))
	var ch1: int = runs.filter(func(r): return r["chapter"] >= 2 or r["state"] == "cleared").size()
	var all_clear: int = runs.filter(func(r): return r["state"] == "cleared").size()
	var avg: float = runs.map(func(r): return float(r["chapter"])).reduce(func(a, x): return a + x, 0.0) / runs.size()
	print("RESULT_JSON:" + JSON.stringify({"proto": "kiln_chapters", "ch1_clear": ch1, "all_clear": all_clear, "avg_chapter": avg,
		"runs": runs.map(func(r): return "%s ch%d.%d" % [r["state"], r["chapter"], r["night"]])}))
	check(ch1 >= 4, "챕터 1은 대체로 넘긴다 (억울함 방지): %d/6" % ch1)
	check(all_clear == 0, "안전하게만 해서 끝까지 다 깨면 긴장이 없다: %d/6" % all_clear)
	check(avg >= 2.0 and avg <= 4.0, "평균 챕터 2~4 (챕터마다 어려워진다): %.2f" % avg)
	return true
