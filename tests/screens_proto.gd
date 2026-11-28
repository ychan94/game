extends SceneTree
## 1분 시험판 장면별 스크린샷 (화면 확인용).
##   godot --path . --rendering-driver opengl3 --script res://tests/screens_proto.gd -- <저장 폴더>

var out_dir := ""


func _initialize() -> void:
	var args := OS.get_cmdline_user_args()
	out_dir = args[0] if args.size() > 0 else OS.get_user_data_dir()
	DirAccess.make_dir_recursive_absolute(out_dir)
	create_timer(240.0).timeout.connect(func(): print("시간 초과"); quit(1))
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

	# ---- B 가마의 병사 (밤 5번) ----
	var k = await _open("res://src/game/kiln_scene.tscn")
	if k.get_script() == null:
		print("kiln 불러오기 실패"); quit(1); return
	await _snap("p00b_kiln_title")
	k.meta.embers = 64
	k.meta.levels = {"core": 1, "wall": 2, "clay": 1, "ticket": 1, "train": 1, "purse": 1, "fire": 1}
	k.state = "meta"
	k.meta_hover = ""
	await _snap("p00c_kiln_meta")
	k.meta.records = {"1": [{"time": 132.4, "date": "2026-11-29", "army": ""}, {"time": 151.0, "date": "2026-11-28", "army": ""}], "2": [{"time": 201.7, "date": "2026-11-29", "army": ""}]}
	k.state = "records"
	await _snap("p00d_kiln_records")
	k.state = "prep"
	var run = k.run
	k.tut_seen = {}
	await _snap("p01a_kiln_tutorial_draw")
	# 7종이 다 보이게 정해서 뽑는다 (실제 게임은 무작위)
	for f in [["shield", "earth"], ["spear", "fire"], ["axe", "fire"], ["cavalry", "fire"], ["archer", "water"], ["healer", "water"], ["cannon", "earth"], ["spear", "fire"]]:
		run.draw(f[0], f[1])
	run.since["rare"] = 5
	await _snap("p01_kiln_prep_first")
	k.state = "gacha"
	await _snap("p01b_kiln_gacha")
	k.state = "load"
	k.load_t = 0
	await _frames(28)
	await _snap("p01c_kiln_load")
	k.state = "fire"
	for i in 6:
		k.kiln.heat_up()
	await _frames(70)
	await _snap("p02_kiln_fire")
	for i in 3:
		k.kiln.heat_up()
	await _frames(70)
	k.bet_on = true
	await _snap("p02b_kiln_fire_hot")
	run.kiln.heat = 4
	run.bet_busts = 3   # 대박이 나오는 장면
	k.kiln.results = run.fire(true)
	k.bet_on = false
	k.bet_told = false
	k.kiln.results[1]["tier"] = "legend"
	run.army[1]["tier"] = "legend"
	k.kiln.results[3]["cracked"] = true
	k.state = "reveal"
	k.reveal_t = 0
	k.reveal_shown = 0
	await _frames(40)
	await _snap("p02c_kiln_open")
	await _frames(75)
	await _snap("p03_kiln_reveal_legend")
	k.reveal_t = 400
	await _frames(4)
	if not k.gfx.is_empty():
		k.gfx["taps"] = 1
		k.gfx["need"] = 3
		await _frames(2)
		await _snap("p03a_kiln_gacha_tap")
		k.gfx["phase"] = "burst"
		k.gfx["t"] = 24
		await _frames(1)
		await _snap("p03a2_kiln_gacha_burst")
		k.gfx["phase"] = "show"
		k.gfx["t"] = 30
		await _frames(2)
		await _snap("p03b_kiln_gacha_show")
	for i in k.kiln.results.size():
		k.gfx_done[i] = true
	k.gfx = {}
	await _frames(260)
	await _snap("p04_kiln_reveal_done")
	# 많이 구웠을 때 (가마 30칸): 작은 카드 여러 줄
	var keep: Array = k.kiln.results
	var many: Array = []
	for i in 24:
		var r0: Dictionary = keep[i % keep.size()].duplicate()
		r0["cracked"] = false
		many.append(r0)
	many[5]["cracked"] = true
	k.kiln.results = many
	k.reveal_shown = many.size()
	for i in many.size():
		k.card_at[i] = -100
	await _frames(2)
	await _snap("p04b_kiln_reveal_many")
	k.kiln.results = keep
	k.card_at = {}
	for i in keep.size():
		k.card_at[i] = -100
	# 둘째 밤 준비: 병사가 남아 있고, 진사 창병 3명이면 합치기 버튼
	run.night = 2
	run.clay = 9
	run.draw("spear", "water")
	run.kiln.heat = 0
	run.fire()
	k.selected = run.army[0]["id"]
	k.state = "prep"
	await _snap("p05_kiln_prep_night2")
	# 높은 등급 병사들을 더해 챕터 2 아침 화면 (튜토리얼 끔)
	k.tutorial_enabled = false
	run.chapter = 2
	run.night = 3
	for f in [["general", "earth", "normal"], ["sniper", "water", "legend"], ["haetae", "fire", "fine"], ["cheoyong", "fire", "normal"],
			["dragon", "water", "normal"], ["baekho", "earth", "normal"], ["jujak", "fire", "normal"], ["hyeonmu", "water", "normal"], ["twin", "fire", "normal"], ["slinger", "earth", "normal"]]:
		run._add_soldier(f[0], f[1], f[2])
	run.myth_shards = 3
	run.since["legendary"] = 70
	run.tickets = 4
	k.selected = run.army[-2]["id"]
	await _snap("p05c_kiln_prep_chapter2")
	k.show_help = true
	await _snap("p05d_kiln_help")
	k.show_help = false
	# 챕터 3: 장비 칸
	run.chapter = 3
	for i in 5:
		run.inventory.append(run._roll_equip(i == 0))
	run.equip(run.army[-6]["id"], run.inventory[0]["id"])
	k.selected = run.army[-6]["id"]
	k.state = "equip"
	await _snap("p05e_kiln_equip")
	k.state = "shop"
	run.pearls = 9
	await _snap("p05f_kiln_shop")
	k.state = "prep"
	# 전직: ★3 창병 + 같은 관군 재료
	var sp3: Dictionary = run._add_soldier("spear", "earth", "fine", 3)
	k.selected = sp3["id"]
	k.promo_pick = true
	await _snap("p05g_kiln_promo")
	k.promo_pick = false
	# 배치 화면 (진영 시너지 · 정보창)
	k._open_deploy()
	k.tip_sid = run.army[1]["id"]
	await _frames(3)
	await _snap("p05h_kiln_deploy")
	k.state = "prep"
	k.battle = null
	# 전투: 합동 기술 파도가 지나가는 순간
	k.fought = Vector2i(run.chapter, run.night)
	k.battle = run.start_night()
	k.battle.village_hp = 99999.0
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
			var who: Array = []
			for u in k.battle.units:
				if u.team == "ally" and u.element == "fire" and who.size() < 5:
					who.append(k.soldier_sprite(u.kind, u.element))
			k.cutin = {"element": "fire", "name": "화염 파도", "count": who.size(), "who": who, "t": 0, "life": k.CUTIN_LEN}
			k.hitstop = k.CUTIN_LEN
			await _frames(40)
			await _snap("p06d_kiln_cutin")
		if k.battle.done:
			break
	while not k.battle.done:
		await physics_frame
	await _frames(140)
	await _snap("p07_kiln_night_end")
	# 챕터 대장들
	for c in [[1, "chief", "p07b_kiln_chief"], [2, "gumiho", "p07d_kiln_gumiho"], [5, "king", "p07e_kiln_king"]]:
		run.chapter = c[0]
		run.night = 5
		run.state = "prep"
		k.fought = Vector2i(run.chapter, run.night)
		k.battle = run.start_night()
		k.battle.village_hp = 99999.0
		k.boss_seen.clear()
		k.state = "battle"
		while not k.battle.units.any(func(u): return u.kind == c[1]):
			await physics_frame
			if k.battle.done:
				break
		await _frames(90)
		await _snap(c[2])
	# 챕터 1 클리어 화면
	run.chapter = 1
	run.night = 5
	run.state = "prep"
	k.fought = Vector2i(1, 5)
	var b = run.start_night()
	b.units = b.units.filter(func(u): return u.team == "ally")
	b.spawn_queue = []
	b.step()
	run.end_night(b)
	k.battle = b
	k.state = "night_end"
	k.end_t = 90
	await _frames(5)
	await _snap("p07c_kiln_chapter_clear")
	# 챕터 3 밤 클리어 (전리품에 장비)
	run.chapter = 3
	run.night = 2
	run.state = "prep"
	k.fought = Vector2i(3, 2)
	var b3 = run.start_night()
	b3.units = b3.units.filter(func(u): return u.team == "ally")
	b3.spawn_queue = []
	b3.step()
	run.end_night(b3)
	k.battle = b3
	k.state = "night_end"
	k.end_t = 26
	await _frames(14)
	await _snap("p07e2_kiln_end_anim")
	k.end_t = 90
	await _frames(5)
	await _snap("p07f_kiln_loot")

	quit(0)
