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

	# ---- B 가마의 병사 ----
	var k = await _open("res://src/game/kiln_scene.tscn")
	if k.get_script() == null:
		print("kiln 불러오기 실패"); quit(1); return
	k.kiln.slots[0] = {"role": "shield", "element": "fire"}
	k.kiln.slots[1] = {"role": "spear", "element": "fire"}
	k.kiln.slots[3] = {"role": "archer", "element": "fire"}
	await _snap("p01_kiln_shape")
	k.state = "fire"
	for i in 6:
		k.kiln.heat_up()
	await _frames(70)  # 불길이 쌓여 오를 시간
	await _snap("p02_kiln_fire")
	for i in 3:
		k.kiln.heat_up()
	await _frames(70)
	await _snap("p02b_kiln_fire_hot")
	k.kiln.open()
	k.kiln.results[1]["tier"] = "legend"
	k.kiln.results[1]["cracked"] = false
	k.kiln.results[2]["cracked"] = true
	k.state = "reveal"
	k.reveal_t = 0
	k.reveal_shown = 0
	await _frames(115)
	await _snap("p03_kiln_reveal_legend")
	await _frames(80)
	await _snap("p04_kiln_reveal_done")
	k.battle = k.kiln.make_battle(5)
	k.state = "battle"
	await _frames(240)
	await _snap("p06a_kiln_battle_mid")
	var got_syn := false
	for i in 900:
		await physics_frame
		if not k.banner.is_empty() and not got_syn and k.battle.stats["synergies"] > 0:
			got_syn = true
			await _snap("p05_kiln_synergy")
		if k.battle.done:
			break
	await _snap("p06_kiln_battle")
	while not k.battle.done:
		await physics_frame
	await _frames(10)
	await _snap("p07_kiln_result")

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
