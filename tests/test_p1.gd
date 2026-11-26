extends "res://tests/suite.gd"
## P1: 게임 전반 (능력·적 패턴·판 흐름·메아리 약점).


func _duel(weapon: String, abilities: Array, enemy_offset := Vector2(0, -30)) -> Array:
	var w = World.new(1)
	var p = w.spawn_player(weapon, abilities)
	var e = w.spawn_enemy("charger", p.pos + enemy_offset)
	e.state = "idle"
	e.hp = 1000.0
	e.max_hp = 1000.0
	return [w, p, e]


func test_spin_sword_hits_behind() -> bool:
	var r := _duel("sword", ["spin"], Vector2(0, 30))
	r[0].step({"aim": Vector2.UP, "attack": true})
	check(r[2].hp < 1000.0, "회전 베기는 뒤의 적도 맞아야 한다")
	var r2 := _duel("sword", [], Vector2(0, 30))
	r2[0].step({"aim": Vector2.UP, "attack": true})
	check(r2[2].hp == 1000.0, "회전 베기가 없으면 뒤는 안 맞아야 한다")
	return true


func test_spin_bow_fires_three() -> bool:
	var r := _duel("bow", ["spin"], Vector2(0, -200))
	r[0].step({"aim": Vector2.UP, "attack": true})
	check(r[0].shots.size() == 3, "회전 베기 활은 세 발")
	return true


func test_pierce_arrow_hits_two() -> bool:
	var w = World.new(1)
	var p = w.spawn_player("bow", ["pierce"])
	var a = w.spawn_enemy("charger", p.pos + Vector2(0, -60))
	var b = w.spawn_enemy("charger", p.pos + Vector2(0, -110))
	w.step({"aim": Vector2.UP, "attack": true})
	for i in 30:
		w.step(IDLE)
	check(a.hp < a.max_hp and b.hp < b.max_hp, "꿰뚫기 화살은 둘 다 맞혀야 한다")
	return true


func test_heavy_hits_harder() -> bool:
	var r := _duel("sword", ["heavy"])
	r[0].step({"aim": Vector2.UP, "attack": true})
	check(is_equal_approx(1000.0 - r[2].hp, 12.0 * 1.3), "강타는 피해 +30%")
	return true


func test_double_roll_and_sprint() -> bool:
	var w = World.new(1)
	var p = w.spawn_player("sword", ["double_roll", "sprint"])
	check(p.dodge_max == 2, "연속 구르기는 2번")
	check(is_equal_approx(p.speed, Data.PLAYER_SPEED * 1.25), "질주는 속도 +25%")
	return true


func _blast_test(abilities: Array) -> float:
	var w = World.new(1)
	var p = w.spawn_player("sword", abilities, Vector2(200, 200))
	var landing: float = Data.PLAYER_SPEED * Data.DODGE_SPEED_MUL * Data.DODGE_FRAMES
	var e = w.spawn_enemy("charger", Vector2(200 + landing + 20.0, 200))
	e.state = "recover"
	e.timer = 99999
	e.hp = 1000.0
	w.step({"move": Vector2.RIGHT, "dodge": true})
	for i in Data.DODGE_FRAMES:
		w.step(IDLE)
	return 1000.0 - e.hp


func test_blast_roll_damages_on_landing() -> bool:
	check(_blast_test(["blast_roll"]) >= 10.0, "폭발 구르기는 내려선 자리 근처 적에게 피해")
	check(_blast_test([]) == 0.0, "폭발 구르기가 없으면 피해 없음")
	return true


func test_bloodthirst_heals_on_kill() -> bool:
	var w = World.new(1)
	var p = w.spawn_player("sword", ["bloodthirst"], Vector2(320, 300), 50.0)
	var e = w.spawn_enemy("slime", p.pos + Vector2(0, -25))
	e.hp = 1.0
	e.state = "idle"
	w.step({"aim": Vector2.UP, "attack": true})
	check(p.hp > 50.0, "처치하면 체력 회복")
	return true


func test_thorns_reflects() -> bool:
	var w = World.new(1)
	var p = w.spawn_player("sword", ["thorns"])
	var e = w.spawn_enemy("slime", p.pos)
	e.state = "idle"
	var hp: float = e.hp
	w.step(IDLE)
	check(e.hp < hp, "가시 갑옷은 때린 적에게 피해")
	return true


func test_archer_aims_then_shoots() -> bool:
	var w = World.new(1)
	w.spawn_player("sword", [])
	var a = w.spawn_enemy("archer", Vector2(320, 100))
	var saw_aim := false
	for i in 200:
		w.step(IDLE)
		if a.state == "aim":
			saw_aim = true
		if not w.shots.is_empty():
			break
	check(saw_aim and not w.shots.is_empty(), "궁수는 조준을 보여 준 뒤 쏴야 한다")
	return true


func test_charger_telegraphs_before_dash() -> bool:
	var w = World.new(1)
	w.spawn_player("sword", [])
	var c = w.spawn_enemy("charger", Vector2(320, 200))
	var seen: Array = []
	for i in 200:
		w.step(IDLE)
		if seen.is_empty() or seen[-1] != c.state:
			seen.append(c.state)
	check(seen.has("telegraph") and seen.has("dash") and seen.find("telegraph") < seen.find("dash"), "돌진 전에 예고해야 한다: %s" % [seen])
	return true


func test_echo_is_exposed_after_dodge() -> bool:
	var w = World.new(1)
	w.spawn_player("sword", [], Vector2(100, 300))
	var e = w.spawn_echo(Echo.tutorial_profile(), Vector2(500, 80))
	e.dodge_t = 1
	w.step(IDLE)
	check(e.exposed > 0, "메아리는 구르기 끝에 멈춘다")
	var hp: float = e.hp
	w._damage(e, 10.0, null)
	check(is_equal_approx(hp - e.hp, 10.0 * Data.ECHO_EXPOSED_DMG_MUL), "멈춘 순간엔 1.5배 피해")
	return true


func test_echo_attack_cooldown_is_longer() -> bool:
	var w = World.new(1)
	var p = w.spawn_player("sword", [])
	var e = w.spawn_echo(Echo.tutorial_profile())
	w._attack(p)
	w._attack(e)
	check(e.attack_cd > p.attack_cd, "메아리의 공격 뒤 빈틈이 더 길다")
	return true


func test_reward_offers_three_new_abilities() -> bool:
	var run = Run.new(5, Save.new())
	run.start("sword", "spin")
	run.world.units = [run.world.player]
	run.step(IDLE)
	check(run.state == "reward", "방을 비우면 보상")
	check(run.choices.size() == 3 and not run.choices.has("spin"), "새 능력 3개")
	var seen := {}
	for c in run.choices:
		seen[c] = true
	check(seen.size() == 3, "겹치지 않아야 한다")
	return true


func test_analysis_has_four_habits() -> bool:
	var run = Run.new(5, Save.new())
	var rows: Array = run.analysis_rows()
	check(rows.size() == 4, "분석표는 습관 4가지")
	for r in rows:
		check(r["hint"] != "", "모든 줄에 공략 힌트")
	return true


func test_bot_run_reaches_the_end() -> bool:
	var save = Save.new()
	var run = Run.new(21, save)
	play_run(run, "normal", "sword", 21)
	check(run.state == "end", "봇 한 판이 끝까지 가야 한다 (상태: %s, %d층)" % [run.state, run.floor_no])
	check(not save.echo().is_empty(), "판이 끝나면 메아리가 남는다")
	return true
