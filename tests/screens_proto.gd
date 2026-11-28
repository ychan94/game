extends SceneTree
## 1분 시험판 장면별 스크린샷 (화면 확인용).
##   godot --path . --rendering-driver opengl3 --script res://tests/screens_proto.gd -- <저장 폴더>

const PD = preload("res://src/proto/data.gd")
var out_dir := ""


func _initialize() -> void:
	var args := OS.get_cmdline_user_args()
	out_dir = args[0] if args.size() > 0 else OS.get_user_data_dir()
	DirAccess.make_dir_recursive_absolute(out_dir)
	create_timer(420.0).timeout.connect(func(): print("시간 초과"); quit(1))
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
	k.save_enabled = false   # 찍는 동안 판 저장 안 함
	k.meta.lord_name = ""
	k._open_naming("title")
	k.name_edit.text = "가마군주"
	await _frames(2)
	await _snap("p00g_naming")
	k.name_edit.visible = false
	k.state = "title"
	k.meta.lord_name = "가마군주"
	k.meta.lord_exp = 8
	await _snap("p00b_kiln_title")
	k.start_ask = true
	await _snap("p00f_title_continue")
	k.start_ask = false
	k.meta.embers = 64
	k.meta.levels = {"core": 1, "wall": 2, "clay": 1, "ticket": 1, "train": 1, "purse": 1, "fire": 1}
	k.state = "meta"
	k.meta_hover = ""
	await _snap("p00c_kiln_meta")
	k.meta.records = {"1": [{"time": 132.4, "date": "2026-11-29", "army": ""}, {"time": 151.0, "date": "2026-11-28", "army": ""}], "2": [{"time": 201.7, "date": "2026-11-29", "army": ""}]}
	k.meta.best = {"reach": 34, "chapter": 3, "night": 4, "kills": 812, "all": false, "date": "2026-11-29"}
	k.state = "records"
	await _snap("p00d_kiln_records")
	k.state = "settings"
	await _snap("p00e_kiln_settings")
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
		k.gfx["taps"] = 2
		await _frames(2)
		await _snap("p03a1_kiln_gacha_tap2")
		k.gfx["phase"] = "burst"
		k.gfx["shards"] = k._make_shards(k.gfx["rays"])
		k.gfx["t"] = 6
		await _frames(1)
		await _snap("p03a15_kiln_gacha_shatter")
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
	# 대기실: 부대 자리를 넘게 구운 병사들
	var D2 = load("res://src/proto/data.gd")
	var roles: Array = D2.KILN_ROLES
	for i in 52:
		run._add_soldier(roles[(i * 7) % roles.size()], D2.ELEMENTS[i % 3], "legend" if i % 11 == 0 else ("fine" if i % 4 == 0 else "normal"), 2 if i % 9 == 0 else 1, true)
	k.state = "barracks"
	k.res_pick = run.reserve[3]["id"]
	await _snap("p05i_kiln_barracks")
	k.res_pick = -1
	k.state = "shop"
	# 합동 기술 고르기
	run.set_combo(run.best_combo() if run.best_combo() != "" else "blaze")
	k.state = "combo"
	await _snap("p05j_kiln_combo")
	# 도감 네 칸
	k.codex_from = "prep"
	k.state = "codex"
	for tb in [["unit", "dragon"], ["skill", "spear"], ["combo", "spear"], ["rule", "spear"]]:
		k.codex_tab = tb[0]
		k.codex_role = tb[1]
		await _snap("p05k_codex_" + tb[0])
	# 스킬 영상 · 합동 기술 영상
	k.codex_tab = "skill"
	k.codex_role = "cannon"
	k._preview_start("skill", "cannon", "fire", "")
	await _frames(40)
	await _snap("p05m_preview_skill")
	k.pv_close_now()
	k._preview_start("combo", "", "", "blaze")
	for i in 120:
		await physics_frame
		if not k.cutin.is_empty() and k.cutin["t"] > 40:
			break
	await _frames(60)
	await _snap("p05n_preview_combo")
	k.pv_close_now()
	k.state = "combo"
	await _snap("p05o_combo_pick")
	# 상점 목록·확률표
	k.state = "shop"
	k.shop_table = true
	await _snap("p05l_shop_table")
	k.shop_table = false
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
	k.battle.combo_id = "blaze"
	k.battle.village_hp = 99999.0
	k.state = "battle"
	var got_wave := false
	var got_draft := false
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
		if k.battle.pending == "draft" and not got_draft:
			# 전술 뽑기 화면 (한 번 찍고 첫 카드)
			got_draft = true
			run.roll_draft()
			k.draft_shown_t = k.t - 60   # 카드가 다 솟아오른 뒤
			await _frames(3)
			await _snap("p06e_tactic_draft")
		_auto_pending(k, run)
		if k.battle.done:
			break
	if not got_draft and not k.battle.done:
		# 이 시드에서 50마리를 못 채웠으면 직접 띄워서 찍는다
		k.battle.pending = "draft"
		run.roll_draft()
		k.draft_shown_t = k.t - 60
		await _frames(3)
		await _snap("p06e_tactic_draft")
		k.draft_shown_t = k.t - 14   # 솟아오르는 중간
		await _frames(1)
		await _snap("p06e2_tactic_draft_rise")
	while not k.battle.done:
		await physics_frame
		_auto_pending(k, run)
	await _frames(140)
	await _snap("p07_kiln_night_end")
	# 챕터 대장들
	for c in [[1, "chief", "p07b_kiln_chief"], [2, "gumiho", "p07d_kiln_gumiho"], [5, "king", "p07e_kiln_king"]]:
		run.chapter = c[0]
		run.night = 6
		run.state = "prep"
		k.fought = Vector2i(run.chapter, run.night)
		k.battle = run.start_night()
		k.battle.village_hp = 99999.0
		k.boss_seen.clear()
		k.state = "battle"
		while not k.battle.units.any(func(u): return u.kind == c[1]):
			await physics_frame
			_auto_pending(k, run)
			if k.battle.done:
				break
		await _frames(90)
		k.cutin = {}
		await _frames(2)
		await _snap(c[2])
	# 일시정지 창 (Esc)
	k.paused = true
	await _frames(2)
	await _snap("p07h_pause")
	k.pause_ask = "title"
	await _frames(2)
	await _snap("p07i_pause_confirm")
	k.pause_ask = ""
	k.paused = false
	# 최종 보스 스킬 예고 (챕터 5: 스킬 3개)
	run.chapter = 5
	run.night = 6
	run.state = "prep"
	k.fought = Vector2i(5, 6)
	k.battle = run.start_night()
	k.battle.village_hp = 99999.0
	k.boss_seen.clear()
	k.state = "battle"
	var guard := 0
	while k.battle.boss_casts.filter(func(c): return c["t"] < c["warn"] / 2).is_empty() and guard < 1500 and not k.battle.done:
		await physics_frame
		_auto_pending(k, run)
		guard += 1
	k.cutin = {}
	await _snap("p07g_boss_skill_warn")
	# 합동 궁극기 (조합마다 다른 연출)
	for cid in ["volley", "quake", "rite", "guardians"]:
		k.battle.waves.clear()
		k.ult_parts.clear()
		k.ult_marks.clear()
		k.cutin = {}
		k.start_ult(cid, PD.COMBOS[cid]["element"])
		k.battle.waves.append({"element": PD.COMBOS[cid]["element"], "x": 120.0, "power": 1.0, "bonus": "", "combo": true, "id": cid})
		for f in 22:
			await physics_frame
			_auto_pending(k, run)
		k.cutin = {}
		await _snap("p06g_ult_" + cid)
	k.battle.waves.clear()
	# 원군 고르기 (챕터 3, 대기실 병사)
	run.clay = 10
	run.chapter = 3
	run.night = 2
	run.state = "prep"
	k.fought = Vector2i(3, 2)
	k.battle = run.start_night()
	k.battle.pending = "reinforce"
	k.cutin = {}
	k.rf_pick = run.best_reserve(2)
	k.state = "battle"
	await _frames(4)
	await _snap("p06f_reinforce")
	k.rf_pick = []
	# 챕터 1 클리어 화면 (최종 보스 밤)
	run.chapter = 1
	run.night = 6
	run.state = "prep"
	k.fought = Vector2i(1, 6)
	var b = run.start_night()
	b.units = b.units.filter(func(u): return u.team == "ally")
	b.spawn_queue = []
	b.step()
	run.end_night(b)
	k.battle = b
	k.cutin = {}
	k.state = "night_end"
	k.end_t = 90
	await _frames(5)
	await _snap("p07c_kiln_chapter_clear")
	# 데모 끝 (챕터 3 최종 보스)
	run.last_chapter = 3
	run.chapter = 3
	run.night = 6
	run.state = "prep"
	k.fought = Vector2i(3, 6)
	var bd = run.start_night()
	bd.units = bd.units.filter(func(u): return u.team == "ally")
	bd.spawn_queue = []
	bd.step()
	run.end_night(bd)
	k.battle = bd
	k.state = "night_end"
	k.end_t = 90
	await _frames(5)
	await _snap("p07j_demo_clear")
	run.last_chapter = 5
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



## 찍는 동안 전투가 멈추지 않게: 전술 뽑기는 첫 카드, 원군은 추천 병사
func _auto_pending(k, run) -> void:
	if k.battle == null:
		return
	if k.battle.pending == "draft":
		if run.draft_offer.is_empty():
			run.roll_draft()
		run.pick_tactic(run.draft_offer[0], k.battle)
	elif k.battle.pending == "reinforce":
		run.reinforce(k.battle, run.best_reserve(run.reinforce_max()))
