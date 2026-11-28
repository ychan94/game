extends "res://tests/suite.gd"
## P0: 깨지면 게임이 안 되는 것. 빨리 끝나야 한다.


func test_world_starts_with_every_unit() -> bool:
	var w = World.new(1)
	w.spawn_player("sword", [])
	for kind in Data.ENEMIES.keys():
		w.spawn_enemy(kind, Vector2(100, 100))
	w.spawn_echo(Echo.tutorial_profile())
	for i in 120:
		w.step(IDLE)
	check(w.frame == 120, "120프레임이 돌아야 한다")
	return true


func test_player_moves_and_stays_in_room() -> bool:
	var w = World.new(1)
	var p = w.spawn_player("sword", [])
	var x0: float = p.pos.x
	for i in 10:
		w.step({"move": Vector2.RIGHT})
	check(p.pos.x > x0, "오른쪽으로 움직여야 한다")
	for i in 1000:
		w.step({"move": Vector2(1, 1)})
	check(World.ROOM.has_point(p.pos), "방 밖으로 나가면 안 된다")
	return true


func test_sword_hits_enemy_in_front() -> bool:
	var w = World.new(1)
	var p = w.spawn_player("sword", [])
	var e = w.spawn_enemy("charger", p.pos + Vector2(0, -30))
	e.state = "idle"
	var hp: float = e.hp
	w.step({"aim": Vector2.UP, "attack": true})
	check(e.hp < hp, "앞의 적이 맞아야 한다")
	return true


func test_bow_shot_hits_enemy() -> bool:
	var w = World.new(1)
	var p = w.spawn_player("bow", [])
	var e = w.spawn_enemy("charger", p.pos + Vector2(0, -120))
	var hp: float = e.hp
	w.step({"aim": Vector2.UP, "attack": true})
	for i in 40:
		w.step(IDLE)
	check(e.hp < hp, "화살이 적을 맞혀야 한다")
	return true


func test_dodge_gives_invulnerability() -> bool:
	var w = World.new(1)
	var p = w.spawn_player("sword", [])
	w.step({"move": Vector2.RIGHT, "dodge": true})
	check(p.invuln > 0 and p.dodge_t > 0, "구르는 동안 무적이어야 한다")
	return true


func test_death_ends_run_and_leaves_echo() -> bool:
	var save = Save.new()
	var run = Run.new(3, save)
	run.start("bow")
	run.world.player.hp = 1.0
	for i in 3000:
		if run.state == "end":
			break
		run.step(IDLE)
	check(run.state == "end" and run.result == "dead", "죽으면 판이 끝나야 한다")
	check(save.echo().get("weapon", "") == "bow", "죽은 내가 메아리로 남아야 한다")
	return true


func test_same_seed_same_result() -> bool:
	var hashes := []
	for k in 2:
		var w = World.new(9)
		w.spawn_player("bow", ["spin"])
		for kind in ["slime", "archer", "charger"]:
			w.spawn_enemy(kind, Vector2(200 + hashes.size() * 0, 100))
		w.spawn_echo(Echo.tutorial_profile())
		for i in 600:
			w.step({"move": Vector2(cos(i * 0.05), sin(i * 0.05)), "aim": Vector2.UP, "attack": i % 15 == 0, "dodge": i % 90 == 0})
		hashes.append(w.state_hash())
	check(hashes[0] == hashes[1], "같은 시드, 같은 입력이면 결과가 같아야 한다")
	return true


func test_every_screen_script_loads() -> bool:
	for path in ["res://src/game/launcher.gd", "res://src/game/kiln_scene.gd", 
			"res://src/game/proto_base.gd", "res://src/game/main.gd"]:
		var s = load(path)
		check(s != null and s.can_instantiate(), "화면 스크립트를 읽지 못함 (문법 오류?): " + path)
	for scene in ["res://src/game/launcher.tscn", "res://src/game/kiln_scene.tscn", "res://src/game/main.tscn"]:
		check(load(scene) != null, "장면을 읽지 못함: " + scene)
	return true
