extends "res://tests/suite.gd"
## 가마의 병사 한 판(밤 5번): 누적·뽑기(확률·천장)·다시 굽기·합치기·흙·새 병사 7종·균형

const PD = preload("res://src/proto/data.gd")
const KilnRun = preload("res://src/proto/kiln_run.gd")
const Battle = preload("res://src/proto/battle.gd")

## 봇: 자리가 꽉 찼을 때만 합치고, 자리·흙이 있으면 뽑고, 흙이 남으면 다시 굽는다
func bot_merge(run) -> void:
	while run.army.size() + run.queued_new() >= run.cap() and not run.merge_groups().is_empty():
		run.merge(run.merge_groups()[0])
	# 장비: 힘이 센 병사부터 빈 손에 끼운다
	if run.equip_unlocked():
		var order: Array = run.army.duplicate()
		order.sort_custom(func(a, b): return PD.STAR_MUL[a["star"]] * PD.TIER_MUL[a["tier"]] > PD.STAR_MUL[b["star"]] * PD.TIER_MUL[b["tier"]])
		for s in order:
			if run.inventory.is_empty():
				break
			if s["equip"].is_empty():
				run.equip(s["id"], run.inventory[0]["id"])


func bot_prep(run, heat: int) -> void:
	bot_merge(run)
	run.set_combo(run.best_combo())
	while run.can_draw() and run.army.size() + run.queued_new() < run.cap():
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
	run.clay = 9999
	var n := 0
	while not run.draw().is_empty():
		n += 1
	check(n == PD.KILN_SLOTS and PD.KILN_SLOTS == 100, "한 번에 가마 자리(100)만큼 넣는다: %d" % n)
	check(run.draws_left() == 0, "가마가 차면 더 못 뽑는다")
	run.fire()
	var alive: int = run.results.filter(func(r): return not r["cracked"]).size()
	check(run.army.size() == mini(run.cap(), alive), "부대는 자리만큼만 (%d)" % run.army.size())
	check(run.reserve.size() == alive - run.army.size(), "나머지는 대기실로 (%d)" % run.reserve.size())
	check(run.can_start_night(), "부대가 자리 안이면 밤을 맞는다")
	# 대기실 ↔ 부대
	var a_id: int = run.army[0]["id"]
	var b_id: int = run.reserve[0]["id"]
	check(not run.to_army(b_id), "부대가 꽉 차면 그냥은 못 옮긴다")
	check(run.swap(a_id, b_id) and run.in_army(b_id) and not run.in_army(a_id), "맞바꾸기")
	check(run.to_reserve(b_id) and run.army.size() == run.cap() - 1, "대기실로")
	check(run.to_army(a_id) and run.army.size() == run.cap(), "부대로")
	# 대기실 병사도 합칠 수 있다
	var groups: Array = run.merge_groups()
	check(not groups.is_empty(), "대기실까지 합쳐 같은 병사 3명")
	var total0: int = run.army.size() + run.reserve.size()
	check(not run.merge(groups[0]).is_empty() and run.army.size() + run.reserve.size() == total0 - 2, "합치기 (3 → 1)")
	check(run.army.size() <= run.cap(), "병사 자리를 넘지 않는다")
	# 대기실 칸 한도
	var r3 = KilnRun.new(2)
	r3.clay = 999999
	var guard := 0
	while r3.draws_left() > 0 and guard < 20:
		while not r3.draw().is_empty():
			pass
		r3.kiln.heat = 0
		r3.fire()
		guard += 1
	check(r3.reserve.size() + r3.army.size() <= r3.cap() + PD.RESERVE_MAX, "대기실은 %d칸까지" % PD.RESERVE_MAX)
	check(r3.reserve.size() == PD.RESERVE_MAX, "대기실이 차면 더 못 뽑는다 (%d)" % r3.reserve.size())
	# 돌려보내기
	var clay0: int = r3.clay
	check(r3.release(r3.reserve[0]["id"]) and r3.clay == clay0 + PD.CLAY_SMASH_BACK, "돌려보내면 흙 %d" % PD.CLAY_SMASH_BACK)
	var r2 = KilnRun.new(1)
	r2.clay = PD.CLAY_DRAW - 1
	check(r2.draw().is_empty(), "흙이 모자라면 못 뽑는다")
	return true


## 밤 보상: 마을 체력 % 로 별과 보상 (★3 뽑기권·흙·진주 / ★2·★1 흙·진주 / ★0 진주만)
func test_night_reward_by_village() -> bool:
	check(PD.night_stars(1.0) == 3 and PD.night_stars(0.9) == 3 and PD.night_stars(0.89) == 2 and PD.night_stars(0.6) == 2, "90%·60% 경계")
	check(PD.night_stars(0.59) == 1 and PD.night_stars(0.3) == 1 and PD.night_stars(0.29) == 0, "30% 경계")
	for case in [[1.0, true, true], [0.7, false, true], [0.45, false, true], [0.2, false, false]]:
		var run = KilnRun.new(3)
		run.draw("spear", "fire")
		run.fire()
		var b = run.start_night()
		b.spawn_queue = []
		b.step()
		b.village_hp = PD.VILLAGE_HP * case[0]
		var t0: int = run.tickets
		var c0: int = run.clay
		run.end_night(b)
		check((run.tickets > t0) == case[1], "마을 %d%%: 뽑기권 %s" % [int(case[0] * 100), "있음" if case[1] else "없음"])
		check((run.clay > c0) == case[2], "마을 %d%%: 흙 %s" % [int(case[0] * 100), "있음" if case[2] else "없음"])
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
	# 2026-11-28 '완승 아니면 완패' 고치기: 챕터를 넘기면 마을을 다 고치지 않고 최대의 35% 만큼 고친다
	check(absf(run.village_hp - minf(PD.VILLAGE_HP, 50.0 + PD.VILLAGE_HP * PD.CHAPTER_REPAIR)) < 0.01, "새 챕터는 마을을 %d%% 고친다 (%.0f)" % [roundi(PD.CHAPTER_REPAIR * 100.0), run.village_hp])
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
	# 현무: 받는 피해가 줄고, 적을 끌어당긴다
	var b4 = Battle.new(1, [])
	var hm = b4.add_ally("hyeonmu", "earth", "normal", "현무")
	b4.spawn_queue = []
	var hh0: float = hm.hp
	b4._hurt(hm, 100.0, null, false)
	check(hh0 - hm.hp < 100.0, "현무는 피해를 덜 받는다")
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


## 별 올리기: 같은 병사·같은 별 3명 → 별 +1, ★5 까지. 요변은 요변끼리만
func test_merge_stars_up_to_five() -> bool:
	var run = KilnRun.new(2)
	run.chapter = 9
	check(PD.MAX_STAR == 5, "별은 5개까지")
	for st in range(1, 5):
		check(PD.merge_need(st) == 3, "★%d → ★%d 은 3명" % [st, st + 1])
	# ★ 3명 (유약 달라도) → ★★
	run._add_soldier("spear", "fire", "normal")
	run._add_soldier("spear", "water", "fine")
	check(run.merge_groups().is_empty(), "★ 2명으로는 못 합친다")
	run._add_soldier("spear", "earth", "normal")
	var g: Array = run.merge_groups()
	check(g.size() == 1 and g[0].size() == 3, "★ 3명이면 합칠 수 있다")
	var m: Dictionary = run.merge(g[0])
	check(m["star"] == 2 and m["tier"] == "fine" and m["element"] == "water", "별 +1, 품질은 좋은 것, 유약은 그 병사 것: %s" % [m])
	# ★★ 는 3명 필요
	run._add_soldier("spear", "earth", "normal", 2)
	check(run.merge_groups().is_empty(), "★★ 2명으로는 못 합친다")
	run._add_soldier("spear", "earth", "normal", 2)
	g = run.merge_groups()
	check(g.size() == 1 and g[0].size() == 3, "★★ 3명이면 합칠 수 있다")
	check(run.merge(g[0])["star"] == 3, "★★★")
	# 요변은 요변끼리만
	var r2 = KilnRun.new(3)
	r2.chapter = 9
	r2._add_soldier("archer", "fire", "legend")
	r2._add_soldier("archer", "fire", "normal")
	check(r2.merge_groups().is_empty(), "요변과 보통은 못 합친다")
	check(r2.merge([r2.army[0]["id"], r2.army[1]["id"]]).is_empty(), "억지로 합쳐도 안 된다")
	r2._add_soldier("archer", "water", "legend")
	check(r2.merge_groups().is_empty(), "요변 2명 + 보통 1명은 못 합친다")
	r2._add_soldier("archer", "earth", "legend")
	var g2: Array = r2.merge_groups()
	check(g2.size() == 1 and r2.merge(g2[0])["tier"] == "legend", "요변 3명은 요변 ★★ 로")
	# ★★★★★ 는 더 못 올린다
	var r3 = KilnRun.new(4)
	r3.chapter = 9
	for i in 6:
		r3._add_soldier("shield", "earth", "normal", 5)
	check(r3.merge_groups().is_empty(), "★★★★★ 는 끝")
	return true


## 전리품: 밤마다 뽑기권 (흙 없이 뽑기), 챕터 3부터 장비. 장비는 끼우고 빼고, 합치면 가방으로
func test_loot_tickets_and_equipment() -> bool:
	var run = KilnRun.new(8)
	var b = run.start_night()
	b.units = b.units.filter(func(u): return u.team == "ally")
	b.spawn_queue = []
	b.step()
	run.end_night(b)
	check(run.tickets == PD.TICKETS_PER_NIGHT and run.last_loot["tickets"] == PD.TICKETS_PER_NIGHT, "밤을 넘기면 뽑기권 %d장" % PD.TICKETS_PER_NIGHT)
	check(run.last_loot["equip"].is_empty(), "챕터 1·2 에는 장비가 없다")
	var clay0: int = run.clay
	run.draw()
	check(run.tickets == PD.TICKETS_PER_NIGHT - 1 and run.clay == clay0, "뽑기권을 먼저 쓴다 (흙은 그대로)")
	var r2 = KilnRun.new(9)
	r2.chapter = PD.EQUIP_FROM_CHAPTER
	r2.night = PD.KILN_NIGHTS
	r2._add_soldier("spear", "fire", "normal")
	r2._add_soldier("spear", "water", "normal")
	r2._add_soldier("spear", "earth", "normal")
	var b2 = r2.start_night()
	b2.units = b2.units.filter(func(u): return u.team == "ally")
	b2.spawn_queue = []
	b2.step()
	r2.end_night(b2)
	check(r2.inventory.size() == PD.EQUIP_BOSS, "챕터 3 대장 밤: 장비 %d개" % PD.EQUIP_BOSS)
	check(r2.inventory.any(func(it): return it["level"] >= 2), "대장 전리품 하나는 2단계 이상")
	var it: Dictionary = r2.inventory[0]
	var sid: int = r2.army[0]["id"]
	check(r2.equip(sid, it["id"]) and r2.soldier(sid)["equip"]["id"] == it["id"] and r2.inventory.size() == PD.EQUIP_BOSS - 1, "장비를 끼운다")
	var bb = r2.start_night()
	var u0 = bb.units.filter(func(u): return u.team == "ally")[0]
	var u1 = bb.units.filter(func(u): return u.team == "ally")[1]
	var mods: Dictionary = PD.equip_mods(it)
	if mods.has("atk"):
		check(u0.atk > u1.atk, "칼날을 끼면 공격력이 오른다")
	elif mods.has("hp"):
		check(u0.max_hp > u1.max_hp, "갑옷을 끼면 체력이 오른다")
	elif mods.has("haste"):
		check(u0.cd_max < u1.cd_max, "부적을 끼면 더 빨리 친다")
	else:
		check(u0.regen > 0.0, "호리병을 끼면 회복한다")
	r2.state = "prep"
	var g: Array = r2.merge_groups()
	r2.merge(g[0])
	check(r2.inventory.size() == PD.EQUIP_BOSS, "합치면 끼던 장비는 가방으로 돌아온다")
	check(r2.unequip(sid) == false, "없어진 병사는 뺄 것도 없다")
	return true


func test_waves_grow_and_chief_on_last_night() -> bool:
	var p1: Array = PD.wave_plan(1, true)
	var p5: Array = PD.wave_plan(PD.KILN_NIGHTS, true)
	check(p5.size() > p1.size(), "밤이 깊을수록 적이 많다: %d → %d" % [p1.size(), p5.size()])
	check(p5.any(func(e): return e[1] == "chief") and not p1.any(func(e): return e[1] == "chief"), "마지막 밤에만 도깨비 대장")
	return true


func test_synergy_wave_sweeps_left_to_right() -> bool:
	var b = Battle.new(1, [])
	b.spawn_queue = []
	b.combo_id = "blaze"
	for r in ["slinger", "cannon", "archer"]:
		var u = b.add_ally(r, "fire", "normal", "t")
		u.max_hp = 1000000.0
		u.hp = u.max_hp
	var near = b.add_enemy("goblin", 100.0)
	var far = b.add_enemy("goblin", 100.0)
	near.hp = 100000.0
	far.hp = 100000.0
	var order: Array = []
	for i in PD.SYNERGY_FIRST + 120:
		near.pos = Vector2(120, 100)
		far.pos = Vector2(560, 100)
		b.step()
		for w in b.waves:
			for id in w.get("hit", []):
				if not order.has(id):
					order.append(id)
	check(order.size() == 2 and order[0] == near.id and order[1] == far.id, "파도가 가까운 적부터 차례로 맞힌다: %s" % str(order))
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
	# 완승 아니면 완패가 아니게 (2026-11-28): 한 밤에 잃는 마을 체력은 상한까지, 무너지기 전에 마을이 줄어드는 밤이 있다
	var partial := 0
	for r in runs:
		var hp: Array = r["hp"]
		var prev: float = PD.VILLAGE_HP
		for v in hp:
			check(prev - v <= PD.VILLAGE_HP * PD.ROUT_CAP + 0.5, "한 밤에 마을이 %.0f 넘게 줄지 않는다 (%s)" % [PD.VILLAGE_HP * PD.ROUT_CAP, str(hp)])
			if v > 0 and v < PD.VILLAGE_HP * 0.9:
				partial += 1
			prev = v
		if r["state"] == "lost" and hp.size() >= 2:
			check(hp[-2] < PD.VILLAGE_HP, "무너진 판은 그 전 밤에 이미 마을이 줄어 있었다 (%s)" % str(hp))
	check(partial >= runs.size(), "마을이 줄어든 채로 끝난 밤이 있다 (%d번)" % partial)
	return true


## 고유 스킬: 17종 모두 스킬이 있고 실제로 쓰며, ★3·★4·★5 에서 세진다
func test_skills_all_roles_and_star_levels() -> bool:
	check(PD.KILN_ROLES.size() == 17 and not PD.KILN_ROLES.has("bulgasari"), "병사 17종, 불가사리 없음")
	check(PD.grade_roles("mythic") == ["dragon", "baekho", "jujak", "hyeonmu"], "신화 = 청룡·백호·주작·현무")
	for r in PD.KILN_ROLES:
		check(PD.SKILLS.has(r) and PD.skill_info(r, "water", 0)["up"].size() == 3, "%s 스킬과 ★3·★4·★5 강화" % r)
		check(PD.faction_of(r) != "", "%s 은(는) 진영이 있다" % r)
	check([1, 2, 3, 4, 5].map(func(st): return PD.skill_level(st)) == [0, 0, 1, 2, 3], "스킬 단계: ★1·2 기본, ★3·4·5 강화")
	for r in PD.KILN_ROLES:
		var b = Battle.new(3, [])
		var u = b.add_ally(r, "fire", "normal", r, 1.0, {"star": 1})
		b.spawn_queue = []
		for i in 4:
			var e = b.add_enemy("goblin", u.pos.y + i * 6.0)
			e.hp = 9999.0
			e.pos = u.pos + Vector2(30 + i * 8, i * 4)
		u.max_hp = 1000000.0   # 스킬을 쓰기 전에 쓰러지지 않게
		u.hp = u.max_hp * 0.5
		var used := false
		for f in PD.SKILLS[r]["cd"] + 30:
			for e in b.units.filter(func(o): return o.team == "enemy"):
				e.pos.x = maxf(e.pos.x, u.pos.x + 20.0)
			b.step()
			if b.events.any(func(ev): return ev["kind"] == "skill" and ev["unit"] == u.id):
				used = true
				break
		check(used, "%s 이(가) 스킬을 쓴다" % r)
	# 별이 오르면 더 세다 (도끼 회오리 피해 비교)
	var dmg := []
	for st in [1, 3, 5]:
		var b2 = Battle.new(5, [])
		var a2 = b2.add_ally("axe", "earth", "normal", "도끼", 1.0, {"star": st})
		b2.spawn_queue = []
		var e2 = b2.add_enemy("goblin", a2.pos.y)
		e2.hp = 99999.0
		e2.pos = a2.pos + Vector2(20, 0)
		b2._skill(a2, "axe")
		dmg.append(99999.0 - e2.hp)
	check(dmg[1] > dmg[0] and dmg[2] > dmg[1], "★3·★5 스킬이 더 세다: %s" % [dmg])
	return true


## 진영 시너지: 같은 진영 '서로 다른' 병사 수로 단계가 켜지고, 전투 능력치에 들어간다
func test_factions() -> bool:
	var run = KilnRun.new(11)
	run.chapter = 9
	run._add_soldier("archer", "fire", "normal")
	run._add_soldier("archer", "water", "normal")
	check(run.faction_levels()["sasu"] == -1, "같은 병사 둘은 1종 → 시너지 없음")
	run._add_soldier("sniper", "fire", "normal")
	check(run.faction_counts()["sasu"] == 2 and run.faction_levels()["sasu"] == 0, "명사수 2종 → 1단계")
	var b = run.start_night()
	var ar = b.units.filter(func(u): return u.kind == "archer")[0]
	check(absf(ar.atk / (PD.ROLE_STATS["archer"]["atk"]) - (1.0 + PD.FACTIONS["sasu"]["vals"][0])) < 0.01, "명사수 공격력 +15%%: %.2f" % ar.atk)
	run.state = "prep"
	run._add_soldier("spear", "fire", "normal")
	run._add_soldier("shield", "fire", "normal")
	var b2 = run.start_night()
	var sp = b2.units.filter(func(u): return u.kind == "spear")[0]
	check(sp.shield_hp > 0.0, "관군 2종 → 보호막")
	return true


## 전직: ★3 이상 + 같은 진영의 다른 병사 → 그 병사의 스킬을 흡수 (스킬 2개)
func test_promotion() -> bool:
	var run = KilnRun.new(12)
	run.chapter = 9
	var a: Dictionary = run._add_soldier("spear", "fire", "normal", 2)
	var c: Dictionary = run._add_soldier("cavalry", "water", "normal")
	var x: Dictionary = run._add_soldier("archer", "water", "normal")
	check(not run.can_promote(a["id"], c["id"]), "★2 는 아직 전직 못 한다")
	a["star"] = 3
	check(not run.can_promote(a["id"], x["id"]), "다른 진영(명사수)과는 전직 못 한다")
	check(run.promo_partners(a["id"]) == [c["id"]], "같은 진영 기마병과 전직할 수 있다")
	var m: Dictionary = run.promote(a["id"], c["id"])
	check(m["promo"] == "cavalry" and run.soldier(c["id"]).is_empty(), "기마병을 흡수했다")
	check(m["name"].contains("질풍"), "이름이 바뀐다: %s" % m["name"])
	var b = run.start_night()
	var u = b.units.filter(func(o): return o.kind == "spear")[0]
	check(u.skills == ["spear", "cavalry"], "스킬 2개: %s" % [u.skills])
	return true


## 진주 상점: 사냥으로 진주, 진열 4개, 병사 강화는 실제 능력치로, 다시 굴리기
func test_pearl_shop() -> bool:
	var run = KilnRun.new(13)
	check(run.shop.size() == PD.SHOP_SLOTS, "진열 %d개" % PD.SHOP_SLOTS)
	var s: Dictionary = run._add_soldier("spear", "fire", "normal")
	run.pearls = 0
	run.shop[0] = "whetstone"
	check(not run.buy(0, s["id"]), "진주가 없으면 못 산다")
	run.pearls = 10
	check(run.buy(0, s["id"]) and run.pearls == 10 - PD.SHOP_ITEMS["whetstone"]["price"], "숫돌을 산다")
	check(run.shop[0] == "", "산 칸은 빈다")
	var b = run.start_night()
	var u = b.units[0]
	check(u.atk > PD.ROLE_STATS["spear"]["atk"] * 1.1, "숫돌 → 공격력 ↑")
	run.state = "prep"
	var p0: int = run.pearls
	check(run.reroll_shop() and run.pearls == p0 - PD.SHOP_REROLL and not run.shop.has(""), "다시 굴리기")
	# 밤을 넘기면 진주
	var r2 = KilnRun.new(14)
	var b2 = r2.start_night()
	b2.units = []
	b2.spawn_queue = []
	b2.stats["kills"] = PD.PEARL_PER_KILLS * 2
	b2.step()
	r2.end_night(b2)
	check(r2.pearls == 2 and r2.last_loot["pearls"] == 2, "처치 %d마리 → 진주 2" % (PD.PEARL_PER_KILLS * 2))
	return true


## 가마신과 내기: 확률 합 1, 결과가 실제로 반영, 꽝 3번이면 대박 확정
func test_kiln_bet() -> bool:
	var tot := 0.0
	for o in PD.BET_ODDS:
		tot += o[2]
	check(absf(tot - 1.0) < 0.001, "내기 확률 합 100%%: %.2f" % tot)
	var seen := {}
	for sd in 60:
		var run = KilnRun.new(700 + sd)
		run.chapter = 9
		run.draw("spear", "fire")
		run.draw("archer", "fire")
		run.kiln.heat = 0
		run.bet_busts = 0
		run.fire(true)
		seen[run.last_bet["key"]] = true
	check(seen.size() == PD.BET_ODDS.size(), "다섯 결과가 다 나온다: %s" % [seen.keys()])
	var r2 = KilnRun.new(5)
	r2.chapter = 9
	r2.draw("spear", "fire")
	r2.bet_busts = PD.BET_PITY
	r2.kiln.heat = 0
	r2.fire(true)
	check(r2.last_bet["key"] == "jackpot" and r2.army[0]["star"] == 2, "꽝 %d번 뒤에는 대박 확정 (별 +1)" % PD.BET_PITY)
	return true


## 자유 배치: 둔 자리에서 시작하고, 둘 수 있는 곳 밖은 안으로 당긴다
func test_free_placement() -> bool:
	var run = KilnRun.new(15)
	var s: Dictionary = run._add_soldier("archer", "fire", "normal")
	run.set_home(s["id"], Vector2(200, 40))
	var b = run.start_night()
	check(b.units[0].pos == Vector2(200, 40), "둔 자리에서 시작")
	run.state = "prep"
	run.set_home(s["id"], Vector2(9999, -50))
	check(Battle.DEPLOY.has_point(run.soldier(s["id"])["home"]) or Battle.DEPLOY.grow(0.5).has_point(run.soldier(s["id"])["home"]), "밖은 안으로 당긴다")
	return true


## 앞뒤로 오가지 않기: 싸우는 동안 창병이 제자리로 갔다 왔다 하지 않는다
func test_no_back_and_forth() -> bool:
	var b = Battle.new(21, PD.wave_plan(2, true, 1))
	for i in 3:
		b.add_ally("spear", "fire", "normal", "창")
	var sp = b.units[0]
	var flips := 0
	var last_dir := 0
	var prev: Vector2 = sp.pos
	for f in 900:
		b.step()
		if not sp.alive:
			break
		var dx: float = sp.pos.x - prev.x
		prev = sp.pos
		var d := 0 if absf(dx) < 0.3 else (1 if dx > 0 else -1)
		if d != 0 and last_dir != 0 and d != last_dir:
			flips += 1
		if d != 0:
			last_dir = d
	check(flips <= 12, "방향을 자꾸 바꾸지 않는다: %d번" % flips)
	return true


## 전술 강화: 앞 칸이 있어야 사고, 불씨가 들고, 효과가 다음 판에 들어간다. 저장·불러오기
func test_meta_tree() -> bool:
	var Meta = load("res://src/proto/meta.gd")
	var m = Meta.new("user://test_meta.cfg")
	m.embers = 100
	check(not m.can_buy("repair"), "앞 칸(성벽) 없이 마을 수리는 못 산다")
	check(m.buy("wall") and m.embers == 100 - Meta.NODES["wall"]["cost"][0], "성벽 1단계")
	check(not m.can_buy("recruit"), "지휘 한도 없이 신병 모집은 못 산다")
	check(m.buy("command"), "지휘 한도 (부대 가지 첫 칸)")
	check(m.buy("clay") and m.buy("train"), "흙 창고·단련")
	var e: Dictionary = m.effects()
	var run = KilnRun.new(3, e)
	check(run.clay == PD.CLAY_START + 6, "시작 흙 +6")
	check(run.cap() == PD.ARMY_CAP_START + 1, "병사 자리 +1")
	var s: Dictionary = run._add_soldier("spear", "fire", "normal")
	var b = run.start_night()
	check(b.units[0].atk > PD.ROLE_STATS["spear"]["atk"] * 1.04 and b.village_guard > 0.0, "단련 공격력·성벽 피해 감소")
	m.save()
	var m2 = Meta.new("user://test_meta.cfg")
	m2.load_saved()
	check(m2.level("command") == 1 and m2.embers == m.embers, "저장·불러오기")
	check(Meta.NODES.size() >= 30 and Meta.BRANCH_NAME.size() == 7, "전술 강화 %d칸 · 가지 7개" % Meta.NODES.size())
	check(Meta.NODES["command"]["max"] >= 3 and Meta.NODES["command"]["key"] == "cap", "부대 자리 +3 까지")
	for id in Meta.NODES:
		var n: Dictionary = Meta.NODES[id]
		check(n["cost"].size() == n["max"] and n["cost"].all(func(c): return c <= 6), "%s 값은 불씨 6 이하 (★3 밤마다 1개)" % id)
		check(n["need"] == "" or Meta.NODES.has(n["need"]), "%s 앞 칸이 있다" % id)
	return true


## 불씨: 아침·밤을 ★3(마을 90%↑)으로 넘길 때마다 1개
func test_embers_from_three_stars() -> bool:
	for case in [[1.0, 1], [0.8, 0]]:
		var run = KilnRun.new(9)
		run.draw("spear", "fire")
		run.fire()
		var b = run.start_night()
		b.spawn_queue = []
		b.step()
		b.village_hp = PD.VILLAGE_HP * case[0]
		run.end_night(b)
		check(run.embers_earned == case[1], "마을 %d%% → 불씨 %d" % [int(case[0] * 100), case[1]])
	return true


## 시간 기록: 챕터를 넘긴 전투 시간, 빠른 순 다섯 개, 순위를 돌려준다
func test_time_records() -> bool:
	var Meta = load("res://src/proto/meta.gd")
	var m = Meta.new("user://test_meta2.cfg")
	check(m.add_record(1, 120.0) == 1, "첫 기록 1위")
	check(m.add_record(1, 90.0) == 1 and m.records["1"][1]["time"] == 120.0, "더 빠르면 1위, 앞 기록은 2위")
	for i in 5:
		m.add_record(1, 200.0 + i)
	check(m.records["1"].size() == Meta.RECORDS_KEEP, "다섯 개만 남긴다")
	check(m.add_record(1, 999.0) == -1, "느린 기록은 순위 밖")
	var run = KilnRun.new(4)
	run.night = PD.KILN_NIGHTS
	var b = run.start_night()
	b.units = []
	b.spawn_queue = []
	b.frame = 600
	b.result = "win"
	b.done = true
	run.end_night(b)
	check(run.chapter == 2 and absf(run.last_chapter_time - 10.0) < 0.01, "챕터 시간 = 밤 전투 시간 합: %.1f" % run.last_chapter_time)
	return true



## 전투 중 자유 이동: 명령한 곳으로 걸어가고 (궁수처럼 서 있는 병사도), 도착하면 그 자리를 지킨다
func test_order_move_in_battle() -> bool:
	var b = Battle.new(2, [])
	var ar = b.add_ally("archer", "fire", "normal", "궁수", 1.0, {"star": 1})
	b.spawn_queue = []
	var e = b.add_enemy("goblin", 30.0)
	e.pos = Vector2(600, 30)
	e.speed = 0.0
	var dest := Vector2(300, 200)
	check(b.order_move(ar.id, dest), "명령 받음")
	for i in 400:
		b.step()
	check(ar.pos.distance_to(dest) < 4.0, "궁수가 명령한 곳까지 걸어갔다: %s" % [ar.pos])
	check(ar.home == dest, "그 자리가 새 제자리")
	check(not b.order_move(99999, dest), "없는 병사는 명령 못 받음")
	return true


## 가마 확률표: 요변·상품·보통·깨짐을 더하면 불 세기와 상관없이 꼭 100% (2026-11-28 사용자 요청)
func test_kiln_percent_sums_to_100() -> bool:
	for heat in PD.KILN_MAX_HEAT + 1:
		var sh: Dictionary = PD.kiln_shares(PD.kiln_odds(heat))
		var tot := 0.0
		for k in sh:
			tot += sh[k]
		check(absf(tot - 1.0) < 1e-6, "불 %d: 몫의 합 1" % heat)
		var pc: Dictionary = PD.percent_100(sh)
		var ps := 0
		for k in pc:
			ps += pc[k]
		check(ps == 100, "불 %d: 화면 %% 합 100 (%d)" % [heat, ps])
	# 실제로 굴려 봐도 표와 비슷하다
	var Kiln = load("res://src/proto/kiln.gd")
	var kl = Kiln.new(5)
	kl.heat = 8
	var o: Dictionary = kl.odds()
	var sh2: Dictionary = PD.kiln_shares(o)
	var got := {"legend": 0, "fine": 0, "normal": 0, "crack": 0}
	for i in 20000:
		var r: Dictionary = kl.roll(o)
		got["crack" if r["cracked"] else r["tier"]] += 1
	for k in got:
		check(absf(got[k] / 20000.0 - sh2[k]) < 0.02, "불 8 %s: 굴린 값 %.3f ≈ 표 %.3f" % [k, got[k] / 20000.0, sh2[k]])
	return true


## 화면 밖(아군이 못 닿는 곳)에서는 적이 공격하지 못한다. 멀리서 맞으면 아군이 그 적에게 간다
func test_enemy_cannot_hit_from_off_field() -> bool:
	var b = Battle.new(3)
	b.spawn_queue = []
	var a = b.add_ally("spear", "fire", "normal", "창병", 1.0, {}, Vector2(Battle.ALLY_MAX_X, 130))
	var e = b.add_enemy("imp", 130.0)
	e.range = 200.0
	var hp0: float = a.hp
	e.pos = Vector2(Battle.FIELD.size.x + 8.0, 130)
	e.speed = 0.0
	for i in 60:
		b.step()
	check(a.hp == hp0, "화면 밖의 적은 못 때린다")
	# 안으로 들어와 멀리서 쏘면, 맞는 아군은 그 적에게 다가간다
	var b2 = Battle.new(4)
	b2.spawn_queue = []
	var a2 = b2.add_ally("spear", "fire", "normal", "창병", 1.0, {}, Vector2(300, 130))
	var e2 = b2.add_enemy("imp", 130.0)
	e2.pos = Vector2(470, 130)
	e2.range = 180.0
	e2.speed = 0.0
	var x0: float = a2.pos.x
	for i in 90:
		b2.step()
	check(a2.pos.x > x0 + 20.0 or not e2.alive, "멀리서 쏘는 적에게 다가간다 (%.0f → %.0f)" % [x0, a2.pos.x])
	return true



## 유약마다 스킬이 다르다: 이름 51개가 모두 다르고, 설명의 숫자가 실제 피해와 같다
func test_skills_differ_by_glaze() -> bool:
	var names := {}
	for r in PD.KILN_ROLES:
		for e in PD.ELEMENTS:
			names[PD.skill_name(r, e)] = true
			var info: Dictionary = PD.skill_info(r, e, 0)
			check(info["desc"] != "" and info["elem"] != "", "%s %s 설명" % [r, e])
	check(names.size() == PD.KILN_ROLES.size() * 3, "스킬 이름 %d개가 모두 다르다 (%d)" % [PD.KILN_ROLES.size() * 3, names.size()])
	# 창병: 설명의 % = 실제 피해 (진사는 +25%)
	for e in PD.ELEMENTS:
		var b = Battle.new(5, [])
		b.spawn_queue = []
		var u = b.add_ally("spear", e, "normal", "창병", 1.0, {"star": 3})
		var t = b.add_enemy("goblin", u.pos.y)
		t.hp = 100000.0
		t.max_hp = 100000.0
		t.pos = u.pos + Vector2(40, 0)
		var hp0: float = t.hp
		b._skill(u, "spear")
		var pct: float = (hp0 - t.hp) / u.atk * 100.0
		var want: int = roundi(PD.SKILLS["spear"]["pct"] * 100.0 * 1.5 * (PD.SKILL_FIRE_POW if e == "fire" else 1.0))
		check(PD.skill_info("spear", e, 1)["desc"].find("%d%%" % want) >= 0, "창병 %s 설명에 %d%%" % [e, want])
		check(absf(pct - want) <= 1.0 + t.armor * 100.0 / u.atk, "창병 %s ★3 피해 공격력의 %d%% (실제 %.0f%%)" % [e, want, pct])
		match e:
			"water": check(t.slow_t > 0, "청자: 맞은 적 느리게")
			"fire": check(t.burn_t > 0, "진사: 맞은 적 화상")
			"earth": check(t.stun_t > 0 and u.shield_hp > 0.0, "흑유: 기절 + 보호막")
	# 돕는 스킬: 무당 유약별
	for e in PD.ELEMENTS:
		var b2 = Battle.new(6, [])
		b2.spawn_queue = []
		var h = b2.add_ally("healer", e, "normal", "무당", 1.0, {"star": 1})
		var a = b2.add_ally("spear", "water", "normal", "창병", 1.0, {"star": 1})
		a.pos = h.pos + Vector2(10, 0)
		a.hp = a.max_hp * 0.3
		b2._skill(h, "healer")
		match e:
			"water": check(a.hp > a.max_hp * 0.3, "청자 굿: 회복")
			"fire": check(a.buff_t > 0, "진사 굿: 공격력 오름")
			"earth": check(a.shield_hp > 0.0, "흑유 굿: 보호막")
	return true


## 스킬 균형: 공격 스킬마다 '한 번에 주는 피해 ÷ 재사용 초' (공격력 10, ★3, 적 6명 무리)를 재서
## 가장 센 것이 가운데 값의 3배를 넘지 않게. 표는 출력으로 남긴다
func test_skill_balance() -> bool:
	var rows: Array = []
	for r in PD.KILN_ROLES:
		if PD.SKILLS[r]["kind"] != "hit":
			continue
		for e in PD.ELEMENTS:
			var cl: float = _skill_damage(r, e, 6)
			var one: float = _skill_damage(r, e, 1)
			var sec: float = PD.SKILLS[r]["cd"] / float(PD.FPS)
			rows.append([r, e, roundi(cl), roundi(one), (cl + one) / 2.0 / sec])
	var vals: Array = rows.map(func(x): return x[4])
	vals.sort()
	var med: float = vals[vals.size() / 2]
	print("  스킬 균형 (공격력 10, ★3): 역할 유약 / 무리6 한번 / 대장1 한번 / 평균 초당")
	for x in rows:
		print("    %-9s %-6s %5d %5d  %5.1f%s" % [x[0], x[1], x[2], x[3], x[4], "  ← 셈" if x[4] > med * 2.0 else ("  ← 약함" if x[4] < med / 2.0 else "")])
	print("    가운데 값 %.1f / 가장 큼 %.1f / 가장 작음 %.1f" % [med, vals[-1], vals[0]])
	check(vals[-1] <= med * 3.0, "가장 센 스킬이 가운데 값의 3배 이하 (%.1f vs %.1f)" % [vals[-1], med])
	check(vals[0] >= med / 3.0, "가장 약한 스킬이 가운데 값의 1/3 이상 (%.1f vs %.1f)" % [vals[0], med])
	return true


## 스킬 한 번의 피해 (공격력 10, ★3). n 명이 앞에 모여 있을 때
func _skill_damage(r: String, e: String, n: int) -> float:
	var b = Battle.new(7, [])
	b.spawn_queue = []
	var u = b.add_ally(r, e, "normal", r, 1.0, {"star": 3})
	u.atk = 10.0
	u.pos = Vector2(200, 130)
	var es: Array = []
	for i in n:
		var t = b.add_enemy("goblin", 130.0)
		t.hp = 100000.0
		t.max_hp = 100000.0
		t.armor = 0.0
		t.pos = Vector2(240 + (i % 3) * 14, 118 + (i / 3) * 20) if n > 1 else Vector2(240, 130)
		es.append(t)
	b._skill(u, r)
	var lost: float = 0.0
	for t in es:
		lost += 100000.0 - t.hp
	return lost



## 합동 기술 고르기: 하나만, 부대에 필요한 병사가 있어야 쓸 수 있다
func test_combo_select_one() -> bool:
	var run = KilnRun.new(4)
	for r in ["spear", "shield", "archer"]:
		run.draw(r, "water")
	run.fire()
	check(run.combo_ready("tide") and not run.combo_ready("blaze"), "부대에 창병·방패병·궁수 → 해일 진격만")
	check(run.best_combo() == "tide", "쓸 수 있는 것 중 고르기")
	check(run.set_combo("tide") and run.combo == "tide", "고르기")
	check(run.set_combo("quake") and run.combo == "quake", "다시 고르면 바뀐다 (하나만)")
	var b = run.start_night()
	check(b.combo_id == "quake", "전투에 고른 것 하나만 넘어간다")
	return true


## 진주 상점 확률표: 합 100%, 뽑기권은 하루 한 칸(1장, 드물게 5장), 장비는 챕터 3부터, 사면 가방으로
func test_shop_table_tickets_equip() -> bool:
	for ch in [1, 3]:
		var tot := 0.0
		for r in PD.shop_table(ch):
			tot += r[1]
		check(absf(tot - 1.0) < 1e-6, "챕터 %d 확률 합 100%%" % ch)
	check(not PD.shop_table(1).any(func(r): return PD.SHOP_ITEMS[r[0]]["stat"] == "equip"), "챕터 1·2 에는 장비 없음")
	check(PD.shop_table(3).any(func(r): return PD.SHOP_ITEMS[r[0]]["stat"] == "equip"), "챕터 3부터 장비")
	var run = KilnRun.new(11)
	var t5 := 0
	var days := 2000
	for d in days:
		run.restock()
		var nt: int = run.shop.filter(func(k): return PD.SHOP_ITEMS[k]["stat"] == "ticket").size()
		check(nt <= 1, "뽑기권은 하루 한 칸만")
		if run.shop.has("ticket5"):
			t5 += 1
	check(t5 > 0 and t5 < days * 0.15, "5장 꾸러미는 드물게 (%d/%d일)" % [t5, days])
	run.chapter = 3
	run.shop = ["eq_blade", "ticket5", "", ""]
	run.pearls = 99
	var inv0: int = run.inventory.size()
	check(run.buy(0) and run.inventory.size() == inv0 + 1 and run.inventory[-1]["type"] == "blade", "장비를 사면 가방으로")
	var tk0: int = run.tickets
	check(run.buy(1) and run.tickets == tk0 + 5, "꾸러미는 뽑기권 5장")
	return true


## 전직 점검 (대기실·합치기와 함께): 재료가 대기실에 있어도 되고, 전직한 병사를 합쳐도 전직이 남는다
func test_promotion_with_reserve_and_merge() -> bool:
	var run = KilnRun.new(21)
	var a: Dictionary = run._add_soldier("spear", "fire", "normal", 3)
	var ing: Dictionary = run._add_soldier("shield", "earth", "normal", 1, true)   # 대기실
	ing["equip"] = {"id": 999, "type": "blade", "level": 1}
	check(not run.in_army(ing["id"]) and run.promo_partners(a["id"]).has(ing["id"]), "대기실 병사도 전직 재료")
	var inv0: int = run.inventory.size()
	var m: Dictionary = run.promote(a["id"], ing["id"])
	check(not m.is_empty() and m["promo"] == "shield" and run.soldier(ing["id"]).is_empty(), "전직: 방패병 스킬을 얻고 재료는 사라진다")
	check(run.inventory.size() == inv0 + 1, "재료의 장비는 가방으로")
	check(not run.can_promote(a["id"], run._add_soldier("cavalry", "fire", "normal")["id"]), "한 번만 전직")
	# 전직한 ★3 + ★3 둘 → 합치면 ★4, 전직은 남는다
	run._add_soldier("spear", "water", "normal", 3)
	run._add_soldier("spear", "earth", "normal", 3, true)
	var g: Array = run.merge_groups().filter(func(x): return x.has(a["id"]))
	check(not g.is_empty(), "전직한 병사도 같은 병사·같은 별이면 합칠 수 있다")
	var mm: Dictionary = run.merge(g[0])
	check(mm["star"] == 4 and mm["promo"] == "shield", "합쳐도 전직(방패병 스킬)은 남는다")
	var b = run.start_night()
	var u = b.units.filter(func(o): return o.kind == "spear" and o.skills.size() == 2)
	check(not u.is_empty() and u[0].skills == ["spear", "shield"], "전투에서 스킬 2개")
	return true


## 장비 점검: 챕터 3 전에는 못 끼고, 끼면 능력치가 오르고, 빼기·바꾸기·대기실로 보내기·돌려보내기에서 장비가 사라지지 않는다
func test_equipment_flow() -> bool:
	var run = KilnRun.new(22)
	var s: Dictionary = run._add_soldier("spear", "fire", "normal")
	var it := {"id": 501, "type": "blade", "level": 2}
	run.inventory.append(it)
	check(not run.equip(s["id"], 501), "챕터 1 에는 장비를 못 낀다")
	run.chapter = 3
	check(run.equip(s["id"], 501) and run.inventory.is_empty(), "챕터 3: 끼운다")
	var st: Dictionary = run.soldier_stats(s)
	var plain: Dictionary = run._add_soldier("spear", "fire", "normal")
	check(st["atk"] > run.soldier_stats(plain)["atk"], "칼날++ 공격력이 정보창 수치에 보인다 (%d > %d)" % [st["atk"], run.soldier_stats(plain)["atk"]])
	run.inventory.append({"id": 502, "type": "armor", "level": 1})
	check(run.equip(s["id"], 502) and run.inventory.size() == 1 and run.inventory[0]["id"] == 501, "바꿔 끼우면 전 장비는 가방으로")
	check(run.unequip(s["id"]) and run.inventory.size() == 2 and s["equip"].is_empty(), "빼기")
	run.equip(s["id"], 501)
	check(run.to_reserve(s["id"]) and run.soldier(s["id"])["equip"]["id"] == 501, "대기실로 가도 장비는 그대로")
	check(run.release(s["id"]) and run.inventory.any(func(x): return x["id"] == 501), "돌려보내면 장비는 가방으로")
	# 모든 장비 종류가 전투 능력치에 들어간다
	for t in PD.EQUIPS:
		var r2 = KilnRun.new(23)
		r2.chapter = 3
		var a: Dictionary = r2._add_soldier("spear", "fire", "normal")
		var c: Dictionary = r2._add_soldier("spear", "fire", "normal")
		r2.inventory.append({"id": 600, "type": t, "level": 1})
		r2.equip(a["id"], 600)
		var b = r2.start_night()
		var ua = b.units.filter(func(o): return o.team == "ally")[0]
		var uc = b.units.filter(func(o): return o.team == "ally")[1]
		check(ua.atk > uc.atk or ua.max_hp > uc.max_hp or ua.cd_max < uc.cd_max or ua.regen > uc.regen, "%s 장비가 전투에 들어간다" % t)
	return true


## 합동 기술 피해 = 조합에 드는 병사들의 공격력 합 × pct (2026-11-28)
func test_combo_damage_from_atk_sum() -> bool:
	var b = Battle.new(31, [])
	b.spawn_queue = []
	b.combo_id = "blaze"
	var sum := 0.0
	for r in ["slinger", "cannon", "archer", "archer"]:
		var u = b.add_ally(r, "fire", "normal", r, 2.5)
		u.max_hp = 1000000.0
		u.hp = u.max_hp
		sum += u.atk
	var spear = b.add_ally("spear", "fire", "normal", "창병", 1.0)   # 조합에 없는 병사는 안 센다
	spear.max_hp = 1000000.0
	spear.hp = spear.max_hp
	var t = b.add_enemy("goblin", 130.0)
	t.hp = 1000000.0
	t.max_hp = 1000000.0
	t.armor = 0.0
	t.speed = 0.0
	var ev := {}
	for i in PD.SYNERGY_FIRST + 120:
		t.pos = Vector2(400, 130)
		var hp0: float = t.hp
		b.step()
		for e in b.events:
			if e["kind"] == "synergy":
				ev = e
	check(not ev.is_empty() and absf(ev["atk_sum"] - sum) < 0.01, "참여 병사 공격력 합 %.1f (창병 제외)" % sum)
	check(absf(ev["dmg"] - sum * PD.COMBOS["blaze"]["pct"]) < 0.01, "피해 = 합 × %d%%" % roundi(PD.COMBOS["blaze"]["pct"] * 100.0))
	check(PD.combo_dmg_text("blaze").find("%d%%" % roundi(PD.COMBOS["blaze"]["pct"] * 100.0)) >= 0, "설명에 같은 %")
	var run = KilnRun.new(32)
	for r in ["slinger", "cannon", "archer"]:
		run.draw(r, "fire")
	run.fire()
	var cp: Dictionary = run.combo_power("blaze")
	check(cp["n"] == 3 and cp["dmg"] > 0.0, "로비에서 지금 피해를 미리 본다 (%d)" % roundi(cp["dmg"]))
	return true



## 새 전술 강화 효과가 실제로 들어간다
func test_meta_new_effects() -> bool:
	var e := {"start_soldier": 2.0, "skill": 0.2, "regen": 0.004, "shield": 0.08, "boss_dmg": 0.15, "night_clay": 2.0, "pearl_rate": 2.0, "legend_bonus": 0.04, "combo_heal": 0.1, "cap": 3.0}
	var run = KilnRun.new(41, e)
	check(run.army.size() == 2 and run.army.all(func(s): return PD.ROLE_GRADE[s["role"]] == "common"), "신병 모집: 일반 병사 2명으로 시작")
	check(run.cap() == PD.ARMY_CAP_START + 3, "지휘 한도 +3")
	check(run.kiln.odds()["legend"] >= PD.kiln_odds(0)["legend"] + 0.04 - 1e-6, "요변 기운 +4%p")
	var b = run.start_night()
	var u = b.units.filter(func(o): return o.team == "ally")[0]
	check(u.regen > 0.0 and u.shield_hp > 0.0 and u.boss_dmg > 0.0 and u.skill_pow > 1.0, "회복·보호막·대장 피해·스킬 위력")
	check(b.combo_heal > 0.0, "합동 기술 회복")
	b.spawn_queue = []
	b.units = b.units.filter(func(o): return o.team == "ally")
	b.stats["kills"] = 8
	b.step()
	var c0: int = run.clay
	var p0: int = run.pearls
	run.end_night(b)
	check(run.clay >= c0 + PD.CLAY_PER_NIGHT + 2, "흙 수레 +2")
	check(run.pearls >= p0 + 8 / (PD.PEARL_PER_KILLS - 2), "진주 사냥꾼: %d마리마다 진주" % (PD.PEARL_PER_KILLS - 2))
	return true
