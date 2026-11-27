extends "res://tests/suite.gd"
## 1분 시험판 (B 가마의 병사, A 알을 품는 성) 규칙 검사.

const PD = preload("res://src/proto/data.gd")
const Battle = preload("res://src/proto/battle.gd")
const Kiln = preload("res://src/proto/kiln.gd")
const Nest = preload("res://src/proto/nest.gd")


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


func test_nest_first_warms_never_burst() -> bool:
	for seed_value in 30:
		var n = Nest.new(seed_value)
		check(n.warm() == "ok" and n.warm() == "ok", "처음 두 번은 안 터진다")
	return true


func test_nest_tier_follows_warmth_and_food_tilts() -> bool:
	var n = Nest.new(3)
	check(n.tier_for(0) == "normal" and n.tier_for(PD.NEST_FINE_AT) == "fine" and n.tier_for(PD.NEST_LEGEND_AT) == "legend", "온기 → 등급")
	var hits := 0
	for seed_value in 100:
		var m = Nest.new(seed_value)
		m.feed("fire")
		if m.hatch()["element"] == "fire":
			hits += 1
	check(hits >= 75, "먹이 속성이 대부분 나와야 한다: %d/100" % hits)
	return true


func test_nest_shells_make_safe_egg() -> bool:
	var n = Nest.new(5)
	n.shells = PD.SHARDS_FOR_LEGEND
	n.new_clutch()
	check(n.safe_egg, "껍질 3개면 안전한 알")
	for i in PD.NEST_LEGEND_AT:
		check(n.burst_chance() == 0.0, "안전한 알은 전설까지 안 터진다")
		n.warm()
	return true


func test_nest_burst_adds_hostile() -> bool:
	var n = Nest.new(1)
	n.eggs[0]["warmth"] = 20
	var r := ""
	for i in 50:
		r = n.warm()
		if r == "burst":
			break
	check(r == "burst" and n.hostiles.size() == 1, "터지면 폭주 괴수가 생긴다")
	var b = n.make_battle(1)
	var has := false
	for q in b.spawn_queue:
		if q[1] == "hostile":
			has = true
	check(has, "폭주 괴수가 밤에 적으로 나온다")
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


func test_synergy_needs_three_same_element() -> bool:
	for n_fire in [2, 3]:
		var b = Battle.new(1)
		for i in n_fire:
			b.add_ally("archer", "fire", "normal", "t")
		b.add_ally("shield", "earth", "normal", "t")
		var fired := false
		for i in 400:
			b.step()
			for e in b.events:
				if e["kind"] == "synergy":
					fired = true
		check(fired == (n_fire >= 3), "불 %d개: 합동 기술 %s" % [n_fire, "나와야 함" if n_fire >= 3 else "안 나와야 함"])
	return true


## 균형: 안전하게 구운 보통 군대도 대체로 지키고, 운 좋은 군대는 훨씬 시원하게 지킨다
func _avg(plan: Array, seeds := 6) -> Dictionary:
	var wins := 0
	var hp := 0.0
	var t := 0.0
	for s in seeds:
		var b = Battle.new(100 + s)
		_army(b, plan)
		_run(b)
		if b.result == "win":
			wins += 1
		hp += b.village_hp
		t += b.frame / 60.0
	return {"wins": wins, "hp": hp / seeds, "time": t / seeds}


func test_balance_safe_vs_lucky_kiln() -> bool:
	var safe := _avg([["shield", "earth", "normal"], ["spear", "fire", "normal"], ["spear", "water", "fine"],
		["archer", "fire", "normal"], ["archer", "water", "normal"]])
	var lucky := _avg([["shield", "fire", "fine"], ["spear", "fire", "legend"], ["spear", "fire", "fine"],
		["archer", "fire", "legend"], ["archer", "water", "fine"]])
	print("RESULT_JSON:" + JSON.stringify({"proto": "kiln", "safe": safe, "lucky": lucky}))
	check(safe["wins"] >= 3, "안전한 군대도 절반은 지켜야 (억울함 방지): %s" % [safe])
	check(lucky["wins"] == 6 and lucky["hp"] > safe["hp"] + 20.0, "운 좋은 군대는 확실히 더 시원해야: %s vs %s" % [lucky, safe])
	return true


func test_balance_safe_vs_lucky_nest() -> bool:
	var M := PD.NEST_STAT_MUL
	var safe := {"wins": 0, "hp": 0.0}
	var lucky := {"wins": 0, "hp": 0.0}
	for s in 6:
		for kind in ["safe", "lucky"]:
			var b = Battle.new(200 + s)
			if kind == "safe":
				b.add_ally("shield", "earth", "normal", "t", M)
				b.add_ally("spear", "fire", "fine", "t", M)
				b.add_ally("archer", "water", "normal", "t", M)
			else:
				b.add_ally("shield", "fire", "fine", "t", M)
				b.add_ally("spear", "fire", "legend", "t", M)
				b.add_ally("archer", "fire", "fine", "t", M)
			_run(b)
			var d: Dictionary = safe if kind == "safe" else lucky
			d["wins"] += 1 if b.result == "win" else 0
			d["hp"] += b.village_hp / 6.0
	print("RESULT_JSON:" + JSON.stringify({"proto": "nest", "safe": safe, "lucky": lucky}))
	check(safe["wins"] >= 3, "안전한 괴수들도 절반은 지켜야: %s" % [safe])
	check(lucky["wins"] == 6 and lucky["hp"] > safe["hp"] + 20.0, "운 좋은 괴수들은 확실히 더 시원해야: %s vs %s" % [lucky, safe])
	return true
