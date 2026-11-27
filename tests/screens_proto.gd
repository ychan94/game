extends SceneTree
## 1분 시험판 장면별 스크린샷 (화면 확인용).
##   godot --path . --rendering-driver opengl3 --script res://tests/screens_proto.gd -- <저장 폴더>

var out_dir := ""


func _initialize() -> void:
	var args := OS.get_cmdline_user_args()
	out_dir = args[0] if args.size() > 0 else OS.get_user_data_dir()
	DirAccess.make_dir_recursive_absolute(out_dir)
	create_timer(120.0).timeout.connect(func(): print("시간 초과"); quit(1))
	_all.call_deferred()


func _frames(n: int) -> void:
	for i in n:
		await physics_frame  # 게임 시간 기준 (그리기는 더 빠를 수 있다)


func _snap(name: String) -> void:
	await _frames(2)
	await RenderingServer.frame_post_draw  # 화면이 실제로 다 그려진 뒤에 찍는다
	await RenderingServer.frame_post_draw
	root.get_viewport().get_texture().get_image().save_png(out_dir.path_join(name + ".png"))
	print("saved ", name)


func _open(path: String) -> Node:
	for c in root.get_children():
		c.queue_free()
	await _frames(1)
	var n: Node = load(path).instantiate()
	root.add_child(n)
	await _frames(2)
	return n


func _all() -> void:
	var l = await _open("res://src/game/launcher.tscn")
	if l.get_script() == null:
		print("launcher 불러오기 실패"); quit(1); return
	await _snap("p00_launcher")

	# ---- B 가마의 병사 (밤 5번) ----
	var k = await _open("res://src/game/kiln_scene.tscn")
	if k.get_script() == null:
		print("kiln 불러오기 실패"); quit(1); return
	var run = k.run
	# 7종이 다 보이게 정해서 뽑는다 (실제 게임은 무작위)
	for f in [["shield", "earth"], ["spear", "fire"], ["axe", "fire"], ["cavalry", "fire"], ["archer", "water"], ["healer", "water"], ["cannon", "earth"], ["spear", "fire"]]:
		run.draw(f[0], f[1])
	run.draws_since_epic = 4
	await _snap("p01_kiln_prep_first")
	k.state = "fire"
	for i in 6:
		k.kiln.heat_up()
	await _frames(70)
	await _snap("p02_kiln_fire")
	for i in 3:
		k.kiln.heat_up()
	await _frames(70)
	await _snap("p02b_kiln_fire_hot")
	run.kiln.heat = 4
	k.kiln.results = run.fire()
	k.kiln.results[1]["tier"] = "legend"
	run.army[1]["tier"] = "legend"
	k.state = "reveal"
	k.reveal_t = 0
	k.reveal_shown = 0
	await _frames(115)
	await _snap("p03_kiln_reveal_legend")
	await _frames(100)
	await _snap("p04_kiln_reveal_done")
	# 둘째 밤 준비: 병사가 남아 있고, 진사 창병 3명이면 합치기 버튼
	run.night = 2
	run.clay = 9
	run.draw("spear", "water")
	run.kiln.heat = 0
	run.fire()
	k.selected = run.army[0]["id"]
	k.state = "prep"
	await _snap("p05_kiln_prep_night2")
	# 전투: 합동 기술 파도가 지나가는 순간
	k.battle = run.start_night()
	k.state = "battle"
	var got_wave := false
	for i in 1500:
		await physics_frame
		if i == 240:
			await _snap("p06_kiln_battle_mid")
		if not got_wave and not k.battle.waves.is_empty() and k.battle.waves[0]["x"] > 250.0:
			got_wave = true
			await _snap("p06b_kiln_synergy_wave")
		if i == 700:
			await _snap("p06c_kiln_battle_busy")
		if k.battle.done:
			break
	while not k.battle.done:
		await physics_frame
	await _frames(10)
	await _snap("p07_kiln_night_end")
	# 다섯째 밤: 도깨비 대장
	run.night = 5
	run.state = "prep"
	k.battle = run.start_night()
	k.state = "battle"
	while k.battle._count("enemy") == 0 or not k.battle.units.any(func(u): return u.kind == "chief"):
		await physics_frame
		if k.battle.done:
			break
	await _frames(60)
	await _snap("p07b_kiln_chief")

	# ---- A 알을 품는 성 ----
	var n = await _open("res://src/game/nest_scene.tscn")
	n.nest.feed("fire")
	for i in 4:
		n.nest.eggs[0]["warmth"] += 1
	await _snap("p08_nest_egg")
	n.nest.eggs[0]["warmth"] = 6
	var c: Dictionary = n.nest.hatch()
	n.last = {"kind": "hatch", "creature": c}
	n.show_banner("전설!", c["name"], n.C["accent"], 80)
	n._start_hatch()
	await _frames(40)
	await _snap("p09_nest_hatch")
	n.nest.hatch()
	n.nest.eggs[2]["warmth"] = 9
	while n.nest.warm() != "burst":
		pass
	n.last = {"kind": "burst", "creature": n.nest.hostiles[-1]}
	n._start_hatch()
	await _frames(40)
	await _snap("p10_nest_burst")
	n.state = "night"
	await _snap("p11_nest_night")
	n.battle = n.nest.make_battle(3)
	n.state = "battle"
	await _frames(500)
	await _snap("p12_nest_battle")
	quit(0)
