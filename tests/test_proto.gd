extends "res://tests/suite.gd"
## 가마의 병사 기본 규칙 검사 (가마 확률·파편·전투·합동 기술·균형).

const PD = preload("res://src/proto/data.gd")
const Battle = preload("res://src/proto/battle.gd")
const Kiln = preload("res://src/proto/kiln.gd")


func _run(b) -> void:
	while not b.done and b.frame < 60 * 60:
		b.step()


func _army(battle, plan: Array) -> void:
	for a in plan:
		battle.add_ally(a[0], a[1], a[2], "test")


func test_kiln_safe_heat_never_cracks() -> bool:
	for h in range(0, PD.KILN_SAFE_HEAT + 1):
		check(PD.kiln_odds(h)["crack"] == 0.0, "불 %d 은 안 깨져야 한다" % h)
	for seed_value in 20:
		var k = Kiln.new(seed_value)
		for i in PD.KILN_SAFE_HEAT:
			k.heat_up()
		for r in k.open():
			check(not r["cracked"], "안전 구간에서 깨짐")
	return true


func test_kiln_odds_rise_with_heat() -> bool:
	var prev := PD.kiln_odds(0)
	for h in range(1, PD.KILN_MAX_HEAT + 1):
		var o := PD.kiln_odds(h)
		check(o["legend"] >= prev["legend"] and o["crack"] >= prev["crack"], "불을 올리면 요변·깨짐 둘 다 오른다")
		prev = o
	return true


func test_kiln_shards_guarantee_legend() -> bool:
	var k = Kiln.new(1)
	k.shards = PD.SHARDS_FOR_LEGEND
	var res: Array = k.open()
	check(res[0]["tier"] == "legend" and res[0]["lucky"], "파편 3개면 요변 확정")
	check(k.shards == 0, "파편을 쓴다")
	return true


func test_battle_same_seed_same_result() -> bool:
	var h: Array = []
	for k in 2:
		var b = Battle.new(7)
		_army(b, [["shield", "earth", "normal"], ["spear", "fire", "fine"], ["archer", "water", "normal"]])
		for i in 600:
			b.step()
		h.append(b.state_hash())
	check(h[0] == h[1], "같은 시드면 같은 결과")
	return true


## 합동 기술은 병사 조합으로: 고른 하나만, 필요한 병사가 모두 있을 때만 (2026-11-28)
func test_combo_needs_roles() -> bool:
	for case in [[["spear", "shield", "archer"], "tide", true], [["spear", "shield"], "tide", false], [["spear", "shield", "archer"], "", false],
			[["dragon", "jujak"], "guardians", true], [["dragon"], "guardians", false]]:
		var b = Battle.new(1)
		b.combo_id = case[1]
		for r in case[0]:
			b.add_ally(r, "fire", "normal", "t")
		var fired := ""
		for i in PD.SYNERGY_FIRST + 40:
			b.step()
			for e in b.events:
				if e["kind"] == "synergy":
					fired = e["combo"]
		check((fired == case[1]) == case[2] or (not case[2] and fired == ""), "%s + %s: 합동 기술 %s" % [str(case[0]), case[1], "나와야 함" if case[2] else "안 나와야 함"])
	check(PD.COMBOS.size() >= 8, "합동 기술 %d가지" % PD.COMBOS.size())
	return true


## 균형: 안전하게 구운 보통 군대도 대체로 지키고, 운 좋은 군대는 훨씬 시원하게 지킨다
func _avg(plan: Array, seeds := 6, night := 1) -> Dictionary:
	var wins := 0
	var hp := 0.0
	var t := 0.0
	for s in seeds:
		var b = Battle.new(100 + s, PD.wave_plan(night))
		_army(b, plan)
		_run(b)
		if b.result == "win":
			wins += 1
		hp += b.village_hp
		t += b.frame / 60.0
	return {"wins": wins, "hp": hp / seeds, "time": t / seeds}


## 2026-11-28 사용자 승인 ("테스트를 둘째 밤 기준으로"): 전투를 화면 가운데로 옮긴 뒤 첫 밤은 두 군대 모두 마을이 멀쩡해 차이가 안 난다.
## '안전한 군대도 지킨다'는 첫 밤, '운이 좋으면 확실히 낫다'는 둘째 밤(도깨비 +45%)에서 잰다
func test_balance_safe_vs_lucky_kiln() -> bool:
	var safe_army := [["shield", "earth", "normal"], ["spear", "fire", "normal"], ["spear", "water", "fine"],
		["archer", "fire", "normal"], ["archer", "water", "normal"]]
	var lucky_army := [["shield", "fire", "fine"], ["spear", "fire", "legend"], ["spear", "fire", "fine"],
		["archer", "fire", "legend"], ["archer", "water", "fine"]]
	var safe := _avg(safe_army)
	var safe2 := _avg(safe_army, 6, 2)
	var lucky2 := _avg(lucky_army, 6, 2)
	print("RESULT_JSON:" + JSON.stringify({"proto": "kiln", "safe": safe, "safe_n2": safe2, "lucky_n2": lucky2}))
	check(safe["wins"] >= 3, "안전한 군대도 첫 밤은 절반은 지켜야 (억울함 방지): %s" % [safe])
	check(lucky2["wins"] == 6 and lucky2["hp"] > safe2["hp"] + 20.0, "운 좋은 군대는 둘째 밤에 확실히 낫다: %s vs %s" % [lucky2, safe2])
	return true
