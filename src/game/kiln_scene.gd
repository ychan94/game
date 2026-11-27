extends "res://src/game/proto_base.gd"
## B 가마의 병사 — 한 판 = 챕터 5개 × (아침 5번 · 밤 5번). 병사는 밤·챕터가 지나도 남는다.
##   아침(뽑기·다시 굽기·합치기) → 가마(불 올리기·열기) → 아침 → 밤 → 밤 결과 → … → 다섯째 밤 대장 → 다음 챕터

const KilnRun = preload("res://src/proto/kiln_run.gd")

var run
var kiln                 # run.kiln (불 세기·확률·파편)
var state := "prep"      # prep → fire → reveal → prep → battle → night_end → prep … / final
var reveal_t := 0
var reveal_shown := 0
var selected := -1       # 고른 병사 id
var draw_flash := 0      # 방금 뽑은 칸 반짝임
var fought := Vector2i(1, 1)   # 방금 싸운 (챕터, 밤) — 밤 결과 화면용
var show_help := false   # 별·등급 안내 창
var right_tab := "draw"  # 오른쪽 칸: draw 뽑기 / equip 장비 (챕터 3부터)
# 튜토리얼 (처음 한 번씩만): draw 뽑기 → fire 가마 → star 별 올리기 → full 자리 꽉 참
const TUT_FILE := "user://kiln_tutorial.cfg"
var tut_seen := {}
var tut_now := ""
var tutorial_enabled := true


func _ready() -> void:
	super._ready()
	view_style = "kiln"
	var cf := ConfigFile.new()
	if cf.load(TUT_FILE) == OK:
		for k in cf.get_section_keys("seen") if cf.has_section("seen") else []:
			tut_seen[k] = true
	_new_run()


func _tut_done(step: String) -> void:
	tut_seen[step] = true
	if tut_now == step:
		tut_now = ""
	var cf := ConfigFile.new()
	for k in tut_seen:
		cf.set_value("seen", k, true)
	cf.save(TUT_FILE)


## 지금 보여 줄 튜토리얼 단계 (아침 화면에서만)
func _tut_pick() -> String:
	if not tutorial_enabled or state != "prep":
		return ""
	if not tut_seen.has("draw") and run.army.is_empty() and run.queue.is_empty():
		return "draw"
	if not tut_seen.has("fire") and not run.queue.is_empty():
		return "fire"
	if not tut_seen.has("star") and not run.merge_groups().is_empty() and run.queue.is_empty():
		return "star"
	if not tut_seen.has("full") and run.army.size() >= run.cap() and run.queue.is_empty():
		return "full"
	if not tut_seen.has("equip") and run.equip_unlocked() and not run.inventory.is_empty() and right_tab != "equip":
		return "equip"
	return ""


func _new_run() -> void:
	run = KilnRun.new(int(Time.get_unix_time_from_system()))
	kiln = run.kiln
	state = "prep"
	selected = -1
	battle = null


func _physics_process(_d: float) -> void:
	back_to_menu_if_esc()
	match state:
		"prep":
			_prep_input()
		"fire":
			_tick_fire()
			if (pressed(KEY_SPACE) or clicked("heat")) and kiln.heat < PD.KILN_MAX_HEAT:
				kiln.heat_up()
				shake = maxf(shake, 1.0 + kiln.heat * 0.4)
				var bx := _door_screen_box(FIRE_O)
				for i in 8 + kiln.heat * 2:
					flames.append({"pos": Vector2(bx.position.x + bx.size.x * randf_range(0.1, 0.9), bx.end.y - randf_range(2.0, 14.0)),
						"vel": Vector2(randf_range(-0.6, 0.6), -randf_range(1.4, 2.6)), "t": 0, "life": randi_range(18, 30), "size": randf_range(10.0, 16.0)})
			if pressed(KEY_ENTER) or pressed(KEY_KP_ENTER) or clicked("open"):
				kiln.results = run.fire()
				state = "reveal"
				reveal_t = 0
				reveal_shown = 0
		"reveal":
			reveal_t += 1
			var due := (reveal_t - 50) / 32 + 1
			while reveal_shown < mini(due, kiln.results.size()):
				_reveal_one(reveal_shown)
				reveal_shown += 1
			if reveal_shown >= kiln.results.size() and (pressed(KEY_ENTER) or pressed(KEY_KP_ENTER) or clicked("fight")):
				state = "prep"
				banner = {}
		"battle":
			step_battle()
			if battle.done:
				run.end_night(battle)
				state = "night_end"
				banner = {}
				floats.clear()
		"night_end":
			if pressed(KEY_ENTER) or pressed(KEY_KP_ENTER) or clicked("next"):
				if run.state == "prep":
					state = "prep"
					battle = null
					selected = -1
				else:
					_new_run()
			elif pressed(KEY_R) and run.state != "prep":
				_new_run()
	draw_flash = maxi(0, draw_flash - 1)
	tick_fx()
	queue_redraw()
	end_input()


func _prep_input() -> void:
	tut_now = _tut_pick()
	if clicked("help"):
		show_help = not show_help
	if show_help:
		if clicked("help_close") or pressed(KEY_ESCAPE):
			show_help = false
		return
	if tut_now != "" and clicked("tut_ok"):
		_tut_done(tut_now)
		return
	if clicked("tab_draw"):
		right_tab = "draw"
	if clicked("tab_equip"):
		right_tab = "equip"
		_tut_done("equip")
	if right_tab == "equip" and selected >= 0:
		if clicked("uneq"):
			run.unequip(selected)
		for i in run.inventory.size():
			if clicked("eq%d" % i):
				run.equip(selected, run.inventory[i]["id"])
				shake = 2.0
				break
	for s in run.army:
		if clicked("card%d" % s["id"]):
			selected = s["id"] if selected != s["id"] else -1
	if selected >= 0 and clicked("refire"):
		run.refire(selected)
	var groups: Array = run.merge_groups()
	for i in groups.size():
		if clicked("merge%d" % i):
			var m: Dictionary = run.merge(groups[i])
			if not m.is_empty():
				_tut_done("star")
				selected = m["id"]
				float_text(Vector2(150, 150), "합치기! %s %s" % [m["name"], "★".repeat(m["star"])], C["accent"], 24)
				shake = 4.0
			break
	if clicked("draw1"):
		_do_draws(1)
		_tut_done("draw")
	if clicked("draw5"):
		_do_draws(5)
		_tut_done("draw")
	for i in run.queue.size():
		if clicked("uq%d" % i):
			run.unqueue(i)
			break
	if not run.queue.is_empty() and (clicked("fire_go") or pressed(KEY_SPACE)):
		state = "fire"
		_tut_done("fire")
	elif run.queue.is_empty() and not run.army.is_empty() and (clicked("night_go") or pressed(KEY_ENTER) or pressed(KEY_KP_ENTER)):
		_tut_done("full")
		fought = Vector2i(run.chapter, run.night)
		battle = run.start_night()
		boss_seen.clear()
		uv.clear()
		state = "battle"
		var ci: Dictionary = run.chapter_info()
		if run.night == 1:
			var nw: String = ci["new"]
			show_banner("챕터 %d · %s" % [run.chapter, ci["name"]], ("새 적: %s · " % PD.ENEMIES[nw]["name"] if nw != "" else "") + "다섯째 밤에 %s" % PD.ENEMIES[ci["boss"]]["name"], C["accent"], 110)


## 뽑기: 한 번씩 가마에 들어가고, 등급이 높을수록 크게 알린다 (신화는 화면이 터진다)
func _do_draws(n: int) -> void:
	for k in n:
		var d: Dictionary = run.draw()
		if d.is_empty():
			break
		draw_flash = 30
		var g: String = d["grade"]
		var gc: Color = GRADE_COL[g]
		var gi: int = PD.GRADES.find(g)
		var p := Vector2(520, 220 + (run.queue.size() - 1) * 13)
		var sub: String = ("천장 확정 — " if d["pity"] else "") + PD.ROLE_DESC[d["role"]]
		match g:
			"mythic":
				show_banner("신화!! %s" % d["name"], sub, gc, 150)
				do_flash(gc, 30)
				burst(Vector2(320, 200), gc, 80, 6.0, 4.0)
				burst(Vector2(320, 200), C["accent"], 50, 5.0, 3.0)
				shake = maxf(shake, 14.0)
			"legendary":
				show_banner("전설! %s" % d["name"], sub + " · 신화 조각 +1", gc, 110)
				do_flash(gc, 22)
				burst(Vector2(320, 200), gc, 50, 5.0, 3.0)
				shake = maxf(shake, 10.0)
			"hero":
				show_banner("영웅! %s" % d["name"], sub, gc, 80)
				do_flash(gc, 12)
				burst(p, gc, 30, 4.0, 3.0)
				shake = maxf(shake, 6.0)
			_:
				if gi >= 1:
					float_text(p + Vector2(-70, -6), "%s! %s" % [PD.GRADE_NAME[g], d["name"]], gc, 12)
					burst(p, gc, 10 + gi * 6, 2.5, 2.0)
					shake = maxf(shake, 1.5 + gi)
				else:
					burst(p, C[d["element"]].lightened(0.3), 6, 1.5)


func _slot_pos(i: int) -> Vector2:
	var n: int = kiln.results.size()
	if n <= 5:
		return Vector2(320 + (i - (n - 1) / 2.0) * 110, 225)
	var per := 4
	var row := i / per
	var in_row: int = mini(per, n - row * per)
	return Vector2(320 + (i % per - (in_row - 1) / 2.0) * 130, 130 + row * 128)


func _reveal_one(i: int) -> void:
	var r: Dictionary = kiln.results[i]
	var p := _slot_pos(i)
	if r["cracked"]:
		burst(p, C["clay"], 22, 3.5, 3.0)
		float_text(p + Vector2(-24, -40), "깨짐… 파편 +1", C["dim"])
		shake = maxf(shake, 3.0)
	elif r["tier"] == "legend" and r.get("before", "") != "legend":
		burst(p, C["accent"], 40, 4.5, 3.0)
		do_flash(C["accent"], 18)
		shake = maxf(shake, 9.0)
		show_banner("요변!", "%s — 불이 우연히 만든 귀한 빛깔 · 힘 2.6배" % r["name"], C["accent"], 90)
	elif r["tier"] == "fine" and r.get("before", "") != "fine":
		burst(p, C[r["element"]].lightened(0.4), 14, 2.5)
		float_text(p + Vector2(-12, -40), "상품", C["accent"])
	else:
		burst(p, C["dim"], 6, 1.5)


# ---------------- 그리기 ----------------
func _draw() -> void:
	buttons.clear()
	draw_screen_bg()
	match state:
		"prep":
			_draw_prep()
		"fire":
			_draw_fire()
		"reveal":
			_draw_reveal()
		"battle", "night_end":
			draw_battle()
			draw_battle_hud("챕터 %d %s — 밤 %d / %d" % [fought.x, PD.CHAPTERS[fought.x - 1]["name"], fought.y, PD.KILN_NIGHTS])
			if state == "night_end":
				_draw_night_end()
	draw_fx()


func _power(s: Dictionary) -> float:
	return PD.TIER_MUL[s["tier"]] * PD.STAR_MUL[s["star"]]


func _draw_prep() -> void:
	var ci: Dictionary = run.chapter_info()
	text(Vector2(10, 13), "챕터 %d · %s" % [run.chapter, ci["name"]], C["dim"])
	text(Vector2(10, 38), "아침 %d / %d" % [run.night, PD.KILN_NIGHTS], C["accent"], 24)
	text(Vector2(190, 16), "마을", C["dim"])
	draw_rect(Rect2(222, 8, 110, 8), Color("3a2430"))
	draw_rect(Rect2(222, 8, 110 * run.village_hp / PD.VILLAGE_HP, 8), C["good"])
	var boss_night: bool = run.night >= PD.KILN_NIGHTS
	text(Vector2(344, 16), "오늘 밤: 도깨비 ×%.1f%s" % [ci["hp"] * (1.0 + PD.NIGHT_HP_GROWTH * (run.night - 1)), " · %s 출현!" % PD.ENEMIES[ci["boss"]]["name"] if boss_night else ""], C["danger"] if boss_night else C["dim"])
	# 자원 줄: 병사 · 뽑기권 · 흙 · 파편
	text(Vector2(190, 38), "병사 %d/%d" % [run.army.size(), run.cap()], C["text"])
	draw_icon("ticket", Vector2(264, 32), 1.0)
	text(Vector2(278, 38), "×%d" % run.tickets, C["accent"])
	draw_icon("clay", Vector2(318, 32), 1.0)
	text(Vector2(330, 38), "%d" % run.clay, C["clay"].lightened(0.35))
	text(Vector2(362, 38), "파편 %d/%d" % [kiln.shards, PD.SHARDS_FOR_LEGEND], C["dim"])
	button(Rect2(604, 24, 28, 18), "?", "help", C["accent"])
	# 군대 (6칸 × 3줄)
	var cw := 64.0
	var ch := 76.0
	for i in run.cap():
		var x: float = 10.0 + (i % 6) * (cw + 2.0)
		var y: float = 46.0 + (i / 6) * (ch + 3.0)
		var r := Rect2(x, y, cw, ch)
		if i >= run.army.size():
			draw_rect(r, C["card"].darkened(0.4))
			draw_rect(r, C["dim"].darkened(0.4), false, 1.0)
			continue
		var s: Dictionary = run.army[i]
		var queued: bool = run.is_queued(s["id"])
		buttons.append({"rect": r, "id": "card%d" % s["id"]})
		var rc: Color = GRADE_COL[PD.ROLE_GRADE[s["role"]]]
		draw_rect(r, C["card"].lightened(0.06 if r.has_point(get_local_mouse_position()) else 0.0))
		draw_rect(Rect2(x, y, cw, 3), rc.darkened(0.2))
		if s["tier"] == "legend":
			glow(self, Vector2(x + cw / 2.0, y + 32), 30.0, Color(1.0, 0.95, 0.8, 0.12))
		draw_rect(r, C["accent"] if selected == s["id"] else C["dim"], false, 2.0 if selected == s["id"] else 1.0)
		var stx := tex(soldier_sprite(s["role"], s["element"]))
		var sk: float = 1.25 if stx == null else minf(1.25, 42.0 / stx.get_height())
		draw_ally_shape(Vector2(x + cw / 2.0, y + 50 - 12.8 * sk), s["role"], s["element"], s["tier"], sk)
		if s["tier"] != "normal":
			text(Vector2(x + 3, y + 15), PD.TIER_NAME_KILN[s["tier"]], C["accent"] if s["tier"] == "legend" else C["text"])
		var mp: Vector2i = run.merge_progress(s)
		if s["star"] < PD.MAX_STAR and mp.x >= 2:
			text(Vector2(x + cw - 30, y + 15), "%d/%d" % [mini(mp.x, mp.y), mp.y], C["good"] if mp.x >= mp.y else C["dim"])
		if not s.get("equip", {}).is_empty():
			draw_icon(s["equip"]["type"], Vector2(x + 4, y + 48), 1.0)
		text(Vector2(x, y + ch - 15), PD.ROLE_NAME_KILN[s["role"]], rc, 12, cw, HORIZONTAL_ALIGNMENT_CENTER)
		_draw_stars(Vector2(x + cw / 2.0, y + ch - 6), s["star"])
		if queued:
			draw_rect(r, Color(0.05, 0.03, 0.02, 0.6))
			text(Vector2(x, y + 44), "가마 안", C["fire"].lightened(0.3), 12, cw, HORIZONTAL_ALIGNMENT_CENTER)
	# 고른 병사·합치기
	var info_y := 306.0
	var sel: Dictionary = run.soldier(selected) if selected >= 0 else {}
	if not sel.is_empty():
		text(Vector2(12, info_y - 15), fit("%s [%s] ★%d · %s · 힘 ×%.1f — %s" % [sel["name"], PD.GRADE_NAME[PD.ROLE_GRADE[sel["role"]]], sel["star"], PD.TIER_NAME_KILN[sel["tier"]], _power(sel), PD.ROLE_DESC[sel["role"]]], 388.0), GRADE_COL[PD.ROLE_GRADE[sel["role"]]])
		if sel["star"] < PD.MAX_STAR:
			var mp2: Vector2i = run.merge_progress(sel)
			text(Vector2(12, info_y), fit("별 올리기: 같은 %s ★%d%s %d명 → ★%d (힘 ×%.1f) · 지금 %d/%d" % [PD.ROLE_NAME_KILN[sel["role"]], sel["star"], " 요변" if sel["tier"] == "legend" else "", mp2.y, sel["star"] + 1, PD.STAR_MUL[sel["star"] + 1], mini(mp2.x, mp2.y), mp2.y], 388.0), C["dim"])
		else:
			text(Vector2(12, info_y), "별 최고 (★5)", C["accent"])
		var why := "" if run.can_refire(selected) else ("요변은 더 오를 데가 없음" if sel["tier"] == "legend" else ("이미 가마 안" if run.is_queued(selected) else ("흙 부족" if run.clay < PD.CLAY_REFIRE else "가마가 가득 참")))
		button(Rect2(10, info_y + 8, 190, 24), "다시 굽기 · 흙 %d" % PD.CLAY_REFIRE if why == "" else why, "refire", C["fire"].lightened(0.3), why == "")
	else:
		text(Vector2(12, info_y), "병사를 누르면: 별 올리기 안내 · 다시 굽기 · 장비", C["dim"])
	var groups: Array = run.merge_groups()
	for i in mini(groups.size(), 2):
		var g: Dictionary = run.soldier(groups[i][0])
		button(Rect2(206 + i * 98, info_y + 8, 96, 24), "%s ★%d" % [PD.ROLE_NAME_KILN[g["role"]], g["star"] + 1], "merge%d" % i, C["accent"])
	# 오른쪽: 뽑기 / 장비
	panel(Rect2(406, 46, 226, 290))
	var y0 := 50.0
	if run.equip_unlocked():
		button(Rect2(410, 50, 108, 18), "병사 뽑기", "tab_draw", C["accent"] if right_tab == "draw" else C["dim"])
		button(Rect2(520, 50, 108, 18), "장비 (%d)" % run.inventory.size(), "tab_equip", C["accent"] if right_tab == "equip" else C["dim"])
		y0 = 72.0
	if right_tab == "equip" and run.equip_unlocked():
		_draw_equip_panel(sel, y0)
	else:
		_draw_draw_panel(y0)
	# 진행
	button(Rect2(10, 344, 300, 30), "가마에 불 지피기  (스페이스)", "fire_go", C["fire"].lightened(0.3), not run.queue.is_empty())
	button(Rect2(330, 344, 300, 30), "밤 맞이하기  (Enter)" if run.queue.is_empty() else "가마를 먼저 여세요", "night_go", C["accent"], run.queue.is_empty() and not run.army.is_empty())
	text(Vector2(0, 392), "× = 부수기(흙 %d) · 같은 병사·같은 별 3명 → 별 +1 (요변은 요변끼리) · ? = 안내" % PD.CLAY_SMASH_BACK, C["dim"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	if show_help:
		_draw_help()
	elif tut_now != "":
		_draw_tutorial(tut_now)


func _draw_stars(c: Vector2, n: int) -> void:
	var w := 7.0
	for i in n:
		var p := c + Vector2((i - (n - 1) / 2.0) * w, 0)
		draw_colored_polygon(PackedVector2Array([p + Vector2(0, -3.5), p + Vector2(1, -1), p + Vector2(3.5, -1), p + Vector2(1.5, 0.8),
			p + Vector2(2.2, 3.5), p + Vector2(0, 2), p + Vector2(-2.2, 3.5), p + Vector2(-1.5, 0.8), p + Vector2(-3.5, -1), p + Vector2(-1, -1)]), C["accent"])


func _draw_draw_panel(y0: float) -> void:
	var y := y0 + 12.0
	text(Vector2(416, y), "병사 뽑기", C["accent"])
	text(Vector2(416, y), "뽑기권 1장 또는 흙 %d" % PD.CLAY_DRAW, C["dim"], 12, 208.0, HORIZONTAL_ALIGNMENT_RIGHT)
	y += 16.0
	for g in PD.GRADES:
		var names: Array = PD.grade_roles(g).map(func(r2): return PD.ROLE_NAME_KILN[r2])
		var pct: float = PD.GRADE_ODDS[g] * 100.0
		text(Vector2(416, y), PD.GRADE_NAME[g], GRADE_COL[g])
		text(Vector2(448, y), ("%.1f%%" % pct) if pct < 10.0 else ("%d%%" % roundi(pct)), GRADE_COL[g])
		text(Vector2(490, y), "·".join(names), C["text"] if g != "common" else C["dim"])
		y += 14.0
	y += 2.0
	var pg: String = run.pity_grade()
	if pg != "":
		text(Vector2(416, y), "다음 뽑기 %s 확정!" % PD.GRADE_NAME[pg], GRADE_COL[pg])
	else:
		text(Vector2(416, y), "확정까지 희귀 %d·영웅 %d·전설 %d" % [run.pity_left("rare"), run.pity_left("hero"), run.pity_left("legendary")], C["dim"])
	y += 15.0
	text(Vector2(416, y), "신화 조각", GRADE_COL["mythic"])
	for i in PD.MYTH_SHARDS:
		var dp := Vector2(474 + i * 10, y - 4)
		var on: bool = i < run.myth_shards
		draw_colored_polygon(PackedVector2Array([dp + Vector2(0, -4), dp + Vector2(4, 0), dp + Vector2(0, 4), dp + Vector2(-4, 0)]), GRADE_COL["mythic"] if on else Color("3a2a36"))
	text(Vector2(416, y), "전설 %d번 → 신화" % PD.MYTH_SHARDS, C["dim"], 12, 208.0, HORIZONTAL_ALIGNMENT_RIGHT)
	y += 8.0
	var dwhy := "" if run.can_draw() else ("흙·뽑기권 부족" if run.clay < PD.CLAY_DRAW and run.tickets == 0 else ("자리 없음 — 합치기!" if run.army.size() + run.queued_new() >= run.cap() else "가마가 가득 참"))
	var l1 := "뽑기 (뽑기권)" if run.tickets > 0 else "뽑기 (흙 %d)" % PD.CLAY_DRAW
	button(Rect2(414, y, 104, 24), l1 if dwhy == "" else dwhy, "draw1", C["accent"], dwhy == "")
	button(Rect2(522, y, 102, 24), "5번 뽑기", "draw5", C["accent"], dwhy == "")
	y += 40.0
	# 가마: 2줄 × 4칸
	text(Vector2(416, y), "가마 (%d / %d)" % [run.queue.size(), PD.KILN_SLOTS], C["fire"].lightened(0.3))
	y += 4.0
	for i in PD.KILN_SLOTS:
		var qx: float = 414.0 + (i % 2) * 106.0
		var qy: float = y + (i / 2) * 15.0
		var r := Rect2(qx, qy, 104, 14)
		if i >= run.queue.size():
			draw_rect(r, C["card"].darkened(0.3))
			continue
		var q: Dictionary = run.queue[i]
		var fresh: bool = draw_flash > 0 and i == run.queue.size() - 1 and q["kind"] == "new"
		draw_rect(r, C["card"].lightened(0.25 * draw_flash / 30.0) if fresh else C["card"])
		draw_rect(Rect2(qx + 3, qy + 3, 8, 8), C[q["element"]])
		var qc: Color = GRADE_COL[PD.ROLE_GRADE[q["role"]]] if q["kind"] == "new" else C["text"]
		text(Vector2(qx + 14, qy + 12), PD.ROLE_NAME_KILN[q["role"]] + ("" if q["kind"] == "new" else " 재"), qc)
		button(Rect2(qx + 88, qy + 1, 14, 12), "×", "uq%d" % i, C["dim"])


func _draw_equip_panel(sel: Dictionary, y0: float) -> void:
	var y := y0 + 12.0
	text(Vector2(416, y), "장비 (병사 한 명에 하나)", C["accent"])
	y += 16.0
	if sel.is_empty():
		text(Vector2(416, y), "왼쪽에서 병사를 먼저 고르세요", C["dim"])
	else:
		var it: Dictionary = sel.get("equip", {})
		text(Vector2(416, y), fit(sel["name"], 160.0), GRADE_COL[PD.ROLE_GRADE[sel["role"]]])
		if not it.is_empty():
			button(Rect2(584, y - 11, 40, 15), "빼기", "uneq", C["dim"])
		y += 16.0
		if it.is_empty():
			text(Vector2(416, y), "끼운 장비 없음", C["dim"])
		else:
			draw_icon(it["type"], Vector2(416, y - 11), 1.0)
			text(Vector2(432, y), fit("%s · %s" % [KilnRun.equip_name(it), _equip_effect(it)], 190.0), C["text"])
	y += 18.0
	text(Vector2(416, y), "가방 — 눌러서 끼우기", C["dim"])
	y += 4.0
	for i in mini(run.inventory.size(), 12):
		var it2: Dictionary = run.inventory[i]
		var r := Rect2(414, y + i * 16, 210, 15)
		draw_rect(r, C["card"])
		draw_icon(it2["type"], r.position + Vector2(3, 2), 1.0)
		text(r.position + Vector2(20, 12), fit("%s  %s" % [KilnRun.equip_name(it2), _equip_effect(it2)], 186.0), C["text"] if not sel.is_empty() else C["dim"])
		buttons.append({"rect": r, "id": "eq%d" % i})
	if run.inventory.is_empty():
		text(Vector2(416, y + 14), "밤을 넘기면 전리품으로 얻습니다", C["dim"])


func _equip_effect(it: Dictionary) -> String:
	var m: Dictionary = PD.equip_mods(it)
	var e: Dictionary = PD.EQUIPS[it["type"]]
	var v: float = m.values()[0]
	if e.has("regen"):
		return "%s %.1f%%" % [e["desc"], v * 100.0]
	return "%s +%d%%" % [e["desc"], roundi(v * 100.0)]


## 작은 도트 아이콘: 뽑기권·흙·장비 4종. pos = 왼쪽 위, k = 배율 (1 = 12px 안팎)
func draw_icon(kind: String, pos: Vector2, k: float) -> void:
	var o := Color("282322")
	match kind:
		"ticket":
			draw_rect(Rect2(pos + Vector2(0, 1) * k, Vector2(13, 9) * k), o)
			draw_rect(Rect2(pos + Vector2(1, 2) * k, Vector2(11, 7) * k), Color("e8c35a"))
			draw_rect(Rect2(pos + Vector2(4, 2) * k, Vector2(1, 7) * k), Color("a8862e"))
			draw_rect(Rect2(pos + Vector2(6, 4) * k, Vector2(5, 3) * k), Color("b8463a"))
			draw_rect(Rect2(pos + Vector2(0, 5) * k, Vector2(1, 1) * k), Color(0, 0, 0, 0))
			draw_rect(Rect2(pos + Vector2(2, 3) * k, Vector2(1, 1) * k), Color("fff3c4"))
		"clay":
			draw_circle(pos + Vector2(6, 7) * k, 5.5 * k, o)
			draw_circle(pos + Vector2(6, 7) * k, 4.5 * k, C["clay"])
			draw_rect(Rect2(pos + Vector2(4, 4) * k, Vector2(2, 2) * k), C["clay"].lightened(0.35))
		"blade":
			draw_line(pos + Vector2(2, 11) * k, pos + Vector2(11, 2) * k, o, 3.0 * k)
			draw_line(pos + Vector2(3, 10) * k, pos + Vector2(11, 2) * k, Color("dcdad2"), 1.5 * k)
			draw_line(pos + Vector2(2, 7) * k, pos + Vector2(6, 11) * k, Color("e8c35a"), 1.5 * k)
		"armor":
			draw_rect(Rect2(pos + Vector2(1, 1) * k, Vector2(11, 11) * k), o)
			draw_rect(Rect2(pos + Vector2(2, 2) * k, Vector2(9, 9) * k), Color("8f8a80"))
			for i in 3:
				draw_rect(Rect2(pos + Vector2(3, 3 + i * 3) * k, Vector2(7, 1) * k), Color("c9c4b8"))
		"charm":
			draw_rect(Rect2(pos + Vector2(3, 0) * k, Vector2(7, 13) * k), o)
			draw_rect(Rect2(pos + Vector2(4, 1) * k, Vector2(5, 11) * k), Color("f0d36a"))
			draw_rect(Rect2(pos + Vector2(5, 3) * k, Vector2(3, 1) * k), Color("b8463a"))
			draw_rect(Rect2(pos + Vector2(6, 4) * k, Vector2(1, 6) * k), Color("b8463a"))
		"gourd":
			draw_circle(pos + Vector2(6, 9) * k, 4.5 * k, o)
			draw_circle(pos + Vector2(6, 4) * k, 3.0 * k, o)
			draw_circle(pos + Vector2(6, 9) * k, 3.5 * k, Color("c98a3a"))
			draw_circle(pos + Vector2(6, 4) * k, 2.0 * k, Color("c98a3a"))
			draw_rect(Rect2(pos + Vector2(5, 0) * k, Vector2(2, 2) * k), Color("6b4a32"))
			draw_rect(Rect2(pos + Vector2(4, 7) * k, Vector2(1, 2) * k), Color("f2d49a"))


func _same_count(s: Dictionary) -> int:
	return run.army.filter(func(o): return o["role"] == s["role"] and o["star"] == s["star"] and not run.is_queued(o["id"])).size()


## 튜토리얼: 화면을 어둡게 하고, 눌러야 할 곳을 밝게 둘러 화살표로 가리킨다
const TUT := {
	"draw": ["병사 뽑기", "아침에는 흙으로 병사를 뽑습니다.\n등급은 6단계 — 일반부터 신화까지, 오른쪽 확률 그대로.\n천장이 있어서 운이 나빠도 정해진 횟수 안에 반드시 나옵니다.", Rect2(410, 168, 218, 32)],
	"fire": ["가마에 굽기", "뽑은 병사는 가마에서 구워야 군대에 들어옵니다.\n불을 세게 올릴수록 상품·요변(힘 ×1.5·×2.6)이 잘 나오고,\n불 4까지는 절대 깨지지 않습니다.", Rect2(6, 340, 308, 38)],
	"star": ["별 올리기", "같은 병사·같은 별 3명을 합치면 별이 오릅니다 (확정).\n★1 → ★2 → … → ★5 까지, 단계마다 3명씩.\n유약은 달라도 되지만, 요변은 요변끼리만 합칩니다.", Rect2(202, 310, 200, 32)],
	"full": ["자리가 꽉 찼습니다", "이제부터는 숫자보다 '키우기'입니다.\n· 같은 병사 3명 합치기 → 별 +1   · 다시 굽기 → 요변을 노림\n카드 오른쪽 위 2/3 표시가 합치기까지 모인 수입니다.", Rect2(6, 42, 400, 240)],
	"equip": ["장비", "챕터 3부터 밤을 넘기면 장비를 얻습니다.\n병사를 고르고 '장비' 칸에서 눌러 끼우세요.\n칼날 공격력 · 갑옷 체력 · 부적 공격 속도 · 호리병 회복", Rect2(518, 48, 112, 22)],
}


func _draw_tutorial(step: String) -> void:
	var info: Array = TUT[step]
	var hl: Rect2 = info[2]
	var dim := Color(0, 0, 0, 0.55)
	draw_rect(Rect2(0, 0, 640, hl.position.y), dim)
	draw_rect(Rect2(0, hl.end.y, 640, 400 - hl.end.y), dim)
	draw_rect(Rect2(0, hl.position.y, hl.position.x, hl.size.y), dim)
	draw_rect(Rect2(hl.end.x, hl.position.y, 640 - hl.end.x, hl.size.y), dim)
	var pulse := 0.6 + 0.4 * sin(t * 0.15)
	draw_rect(hl.grow(2), Color(1.0, 0.85, 0.35, pulse), false, 2.0)
	var box := Rect2(150, 120, 340, 100) if hl.position.y > 200 or hl.size.y > 200 else Rect2(70, 230, 340, 100)
	if step == "full":
		box = Rect2(150, 286, 340, 100)
	panel(box)
	draw_rect(box, C["accent"], false, 1.0)
	text(box.position + Vector2(10, 18), "도움말 · " + info[0], C["accent"])
	text(box.position + Vector2(10, 34), info[1], C["text"], 12, box.size.x - 20)
	button(Rect2(box.end.x - 86, box.end.y - 24, 80, 20), "알겠어요", "tut_ok", C["accent"])
	# 화살표: 상자에서 밝힌 곳으로
	var from := box.get_center()
	var to := hl.get_center()
	if hl.size.y < 100:
		var dir := (to - from).normalized()
		var tip := to - dir * (hl.size.length() * 0.3)
		var bob := dir * sin(t * 0.2) * 4.0
		draw_line(tip - dir * 30.0 + bob, tip + bob, C["accent"], 3.0)
		draw_colored_polygon(PackedVector2Array([tip + bob + dir * 6.0, tip + bob - dir * 4.0 + dir.orthogonal() * 6.0, tip + bob - dir * 4.0 - dir.orthogonal() * 6.0]), C["accent"])


## 안내 창: 별 올리기와 등급
func _draw_help() -> void:
	draw_rect(Rect2(0, 0, 640, 400), Color(0, 0, 0, 0.6))
	var r := Rect2(70, 14, 500, 372)
	panel(r)
	draw_rect(r, C["accent"], false, 1.0)
	text(Vector2(84, 32), "별 올리기 (운 없이 확정)", C["accent"])
	var y := 48.0
	for st in range(1, PD.MAX_STAR + 1):
		_draw_stars(Vector2(110, y - 4), st)
		text(Vector2(150, y), "뽑으면 ★1" if st == 1 else "같은 병사 ★%d %d명" % [st - 1, PD.merge_need(st - 1)], C["text"])
		text(Vector2(360, y), "힘 ×%.1f" % PD.STAR_MUL[st], C["good"])
		y += 15.0
	text(Vector2(90, y), "유약은 달라도 됩니다. 요변은 요변끼리만 합칩니다.", C["dim"])
	y += 18.0
	text(Vector2(84, y), "등급 (뽑기 확률 · 병사)", C["accent"])
	y += 16.0
	for g in PD.GRADES:
		text(Vector2(90, y), PD.GRADE_NAME[g], GRADE_COL[g])
		text(Vector2(130, y), "%.1f%%" % (PD.GRADE_ODDS[g] * 100.0), GRADE_COL[g])
		for r2 in PD.grade_roles(g):
			text(Vector2(180, y), PD.ROLE_NAME_KILN[r2], C["text"])
			text(Vector2(250, y), PD.ROLE_DESC[r2], C["dim"])
			y += 2.0
	text(Vector2(84, 378), "천장: 희귀↑ %d번 · 영웅↑ %d번 · 전설↑ %d번 안에 반드시 · 전설 %d번 → 신화" % [PD.PITY["rare"], PD.PITY["hero"], PD.PITY["legendary"], PD.MYTH_SHARDS], C["dim"])
	button(Rect2(r.end.x - 82, r.position.y + 6, 76, 20), "닫기", "help_close", C["accent"])


## 밤 결과: 제목(챕터·밤 클리어)과 전리품 아이콘만 (사용자: "어떤 적을 잡았는지는 안 중요")
func _draw_night_end() -> void:
	panel(Rect2(130, 90, 380, 220))
	draw_rect(Rect2(130, 90, 380, 220), C["accent"] if run.state != "lost" else C["danger"], false, 1.0)
	var title := ""
	var sub := ""
	var tc: Color = C["accent"]
	if run.state == "won":
		title = "모든 챕터를 지켰다!"
	elif run.state == "lost":
		title = "마을이 무너졌다"
		sub = "챕터 %d · 밤 %d 에서" % [fought.x, fought.y]
		tc = C["danger"]
	elif run.chapter_cleared:
		title = "챕터 %d 클리어!" % fought.x
		sub = "다음: 챕터 %d · %s" % [run.chapter, run.chapter_info()["name"]]
	else:
		title = "챕터 %d · 밤 %d 클리어" % [fought.x, fought.y]
	text(Vector2(130, 130), title, tc, 24, 380.0, HORIZONTAL_ALIGNMENT_CENTER)
	if sub != "":
		text(Vector2(130, 150), sub, C["dim"], 12, 380.0, HORIZONTAL_ALIGNMENT_CENTER)
	if run.state != "lost" and not run.last_loot.is_empty():
		text(Vector2(130, 178), "전리품", C["dim"], 12, 380.0, HORIZONTAL_ALIGNMENT_CENTER)
		var items: Array = [["ticket", "뽑기권", run.last_loot["tickets"]], ["clay", "흙", run.last_loot["clay"] + run.last_loot.get("chapter_clay", 0)]]
		for it in run.last_loot["equip"]:
			items.append([it["type"], KilnRun.equip_name(it), 1])
		var w := 74.0
		var x0: float = 320.0 - items.size() * w / 2.0
		for i in items.size():
			var cx: float = x0 + i * w + w / 2.0
			var pop: float = clampf((t % 100000) * 0.0 + 1.0, 0.0, 1.0)
			draw_rect(Rect2(cx - 22, 188, 44, 44), C["card"])
			draw_rect(Rect2(cx - 22, 188, 44, 44), C["accent"].darkened(0.3), false, 1.0)
			draw_icon(items[i][0], Vector2(cx - 13, 197), 2.0 * pop)
			text(Vector2(cx - 37, 248), items[i][1], C["text"], 12, 74.0, HORIZONTAL_ALIGNMENT_CENTER)
			if items[i][2] > 1:
				text(Vector2(cx + 6, 230), "×%d" % items[i][2], C["accent"])
	button(Rect2(220, 272, 200, 28), ("다음 챕터로  (Enter)" if run.chapter_cleared else "다음 아침  (Enter)") if run.state == "prep" else "처음부터  (Enter)", "next")


func _kiln_glow() -> Color:
	var k: float = float(kiln.heat) / PD.KILN_MAX_HEAT
	return Color("401010").lerp(Color("ff7a20"), minf(1.0, k * 1.4)).lerp(Color("fff2c0"), maxf(0.0, k - 0.6) * 2.0)


func _draw_kiln_body(offset: Vector2, _door_open: float) -> void:
	var o := offset + _shake_now
	# 몸체: 그림(kiln/kiln_body)이 있으면 그림, 없으면 벽돌 도형. 문 안·불·빛은 위에 그린다 (불과 빛은 빛 층)
	var body := tex("kiln/kiln_body")
	if body != null:
		draw_texture_rect(body, Rect2(o + KILN_BODY_RECT.position, KILN_BODY_RECT.size), false)
	else:
		_draw_brick_body(o)
	_draw_door_base(o)
	_draw_smoke()


func _draw_brick_body(o: Vector2) -> void:
	draw_rect(Rect2(o + Vector2(40, 120), Vector2(260, 150)), Color("5a3a2a"))
	draw_circle(o + Vector2(170, 120), 130.0, Color("5a3a2a"))
	for row in 6:
		for col in 7:
			var bx := 48.0 + col * 36.0 + (18.0 if row % 2 == 1 else 0.0)
			if bx < 290.0:
				draw_rect(Rect2(o + Vector2(bx, 128 + row * 22), Vector2(32, 18)), Color("634232"), false, 1.0)


# ---- 가마 그림의 문 모양 읽기 ----
# 그림 가운데의 어두운 영역(문 자리)을 찾아 같은 모양의 마스크를 만든다. 그림을 다시 그리지 않아도 문 모양이 맞는다.
const KILN_BODY_RECT := Rect2(20, 0, 300, 300)   # 가마 그림을 그리는 자리 (o 기준)
var door_mask: Texture2D = null
var door_box := Rect2()                           # 문 영역 (그림 픽셀 기준)
var _mask_tried := false


func _ensure_door_mask() -> void:
	if _mask_tried:
		return
	_mask_tried = true
	var body := tex("kiln/kiln_body")
	if body == null:
		return
	var img: Image = body.get_image()
	if img == null:
		return
	if img.is_compressed():
		img.decompress()
	img.convert(Image.FORMAT_RGBA8)
	var w := img.get_width()
	var h := img.get_height()
	var dark := func(x: int, y: int) -> bool:
		var c := img.get_pixel(x, y)
		return c.a > 0.5 and c.get_luminance() < 0.2
	# 가운데 근처에서 어두운 점을 찾아 거기서부터 이어진 어두운 영역을 칠한다
	var seed := Vector2i(-1, -1)
	for dy in range(0, h / 3):
		for dx in [0, -3, 3, -6, 6]:
			var p := Vector2i(w / 2 + dx, h / 2 + dy - h / 8)
			if p.x >= 0 and p.y >= 0 and p.x < w and p.y < h and dark.call(p.x, p.y):
				seed = p
				break
		if seed.x >= 0:
			break
	if seed.x < 0:
		return
	var mask := Image.create(w, h, false, Image.FORMAT_RGBA8)
	var seen := {}
	var stack := [seed]
	var minp := seed
	var maxp := seed
	while not stack.is_empty():
		var q: Vector2i = stack.pop_back()
		if seen.has(q) or q.x < 0 or q.y < 0 or q.x >= w or q.y >= h or not dark.call(q.x, q.y):
			continue
		seen[q] = true
		mask.set_pixel(q.x, q.y, Color.WHITE)
		minp = Vector2i(mini(minp.x, q.x), mini(minp.y, q.y))
		maxp = Vector2i(maxi(maxp.x, q.x), maxi(maxp.y, q.y))
		stack.append_array([q + Vector2i.RIGHT, q + Vector2i.LEFT, q + Vector2i.UP, q + Vector2i.DOWN])
	var share := float(seen.size()) / (w * h)
	if share < 0.03 or share > 0.6:
		return  # 문으로 보기 어려우면 마스크를 쓰지 않는다 (예전 네모 문으로)
	door_mask = ImageTexture.create_from_image(mask)
	door_box = Rect2(minp, maxp - minp + Vector2i.ONE)


func _sprite_to_screen(o: Vector2, p: Vector2) -> Vector2:
	var body := tex("kiln/kiln_body")
	var s: Vector2 = KILN_BODY_RECT.size / body.get_size()
	return o + KILN_BODY_RECT.position + p * s


## 문 영역 (화면 좌표). 그림에서 문을 찾았으면 그 영역, 아니면 정해 둔 네모
func _door_screen_box(o: Vector2) -> Rect2:
	_ensure_door_mask()
	if door_mask != null:
		var tl := _sprite_to_screen(o, door_box.position)
		var br := _sprite_to_screen(o, door_box.end)
		return Rect2(tl, br - tl)
	return Rect2(o + Vector2(95, 120), Vector2(150, 140))


## 문 안 바탕: 깊은 숯불빛 (밝은 빛은 빛 층의 불 입자가 더한다)
func _draw_door_base(o: Vector2) -> void:
	var k: float = float(kiln.heat) / PD.KILN_MAX_HEAT
	var ember := Color(0.04, 0.025, 0.02).lerp(Color(0.20, 0.05, 0.02), minf(1.0, k * 1.2))
	var box := _door_screen_box(o)
	if door_mask != null:
		draw_texture_rect(door_mask, Rect2(o + KILN_BODY_RECT.position, KILN_BODY_RECT.size), false, ember)
	else:
		draw_rect(box, ember)
		draw_rect(box, Color("7a5a44"), false, 2.0)


# ---- 불 입자 (가산 혼합으로 겹칠수록 밝다) ----
var flames: Array = []
var embers: Array = []
var smokes: Array = []
const FIRE_O := Vector2(0, 70)


func _tick_fire() -> void:
	var k: float = float(kiln.heat) / PD.KILN_MAX_HEAT
	var box := _door_screen_box(FIRE_O)
	var n := 2 + int(kiln.heat * 2.2) if kiln.heat > 0 else (1 if t % 3 == 0 else 0)
	for i in n:
		# 가운데가 더 높이 타오르게: 가운데에서 생긴 불일수록 빠르고 오래 간다
		var u := randf_range(0.1, 0.9)
		var center_k := 1.0 - absf(u - 0.5) * 1.6
		flames.append({"pos": Vector2(box.position.x + box.size.x * u, box.end.y - randf_range(2.0, 12.0)),
			"vel": Vector2(randf_range(-0.2, 0.2), -randf_range(0.9, 1.8) * (0.5 + k) * (0.7 + center_k * 0.6)),
			"t": 0, "life": int(randf_range(28.0, 52.0) * (0.55 + k * 0.7) * (0.7 + center_k * 0.5)), "size": randf_range(7.0, 13.0) * (0.75 + k * 0.6)})
	if randf() < 0.1 + k * 0.7:
		embers.append({"pos": Vector2(box.get_center().x + randf_range(-box.size.x * 0.3, box.size.x * 0.3), box.position.y + box.size.y * 0.5),
			"vel": Vector2(randf_range(-0.7, 0.7), -randf_range(1.0, 2.2)), "t": 0, "life": randi_range(40, 90)})
	if randf() < 0.12 + k * 0.3:
		var chim := _sprite_to_screen(FIRE_O, Vector2(80, 4)) if tex("kiln/kiln_body") != null else FIRE_O + Vector2(170, 0)
		smokes.append({"pos": chim + Vector2(randf_range(-4, 4), 0), "vel": Vector2(randf_range(0.1, 0.35), -randf_range(0.35, 0.6)), "t": 0, "life": randi_range(70, 120), "size": 5.0})
	for f in flames:
		f["pos"] += f["vel"]
		f["vel"].x += sin(t * 0.2 + f["pos"].y * 0.15) * 0.03
		f["t"] += 1
	flames = flames.filter(func(f): return f["t"] < f["life"] and f["pos"].y > box.position.y + 4.0)
	for e in embers:
		e["pos"] += e["vel"]
		e["vel"].x += sin(t * 0.13 + e["life"]) * 0.05
		e["t"] += 1
	embers = embers.filter(func(e): return e["t"] < e["life"])
	for m in smokes:
		m["pos"] += m["vel"]
		m["size"] += 0.12
		m["t"] += 1
	smokes = smokes.filter(func(m): return m["t"] < m["life"])


func _draw_smoke() -> void:
	for m in smokes:
		var a: float = 0.28 * (1.0 - float(m["t"]) / m["life"])
		glow(self, m["pos"] + _shake_now, m["size"] * 2.2, Color(0.42, 0.4, 0.42, a))


## 불 색: 갓 생긴 불은 하얀 노랑 → 주황 → 식으며 붉게
func _flame_color(age: float) -> Color:
	if age < 0.3:
		return Color(1.0, 0.95, 0.75).lerp(Color(1.0, 0.62, 0.2), age / 0.3)
	return Color(1.0, 0.62, 0.2).lerp(Color(0.75, 0.16, 0.05), (age - 0.3) / 0.7)


func draw_glow(ci: CanvasItem) -> void:
	super.draw_glow(ci)
	if state != "fire":
		return
	var k: float = float(kiln.heat) / PD.KILN_MAX_HEAT
	var o := FIRE_O + _shake_now
	var box := _door_screen_box(o)
	var c := box.get_center()
	var flick := 0.85 + 0.1 * sin(t * 0.27) + 0.08 * sin(t * 0.71 + 1.3)
	# 문에서 새어 나온 불빛이 가마 겉면과 바닥에 번진다
	glow(ci, c + Vector2(0, box.size.y * 0.15), 80.0 + 130.0 * k, Color(1.0, 0.42, 0.12, (0.06 + 0.30 * k) * flick))
	glow(ci, Vector2(c.x, box.end.y + 26.0), 90.0 + 90.0 * k, Color(1.0, 0.5, 0.2, (0.05 + 0.22 * k) * flick), 0.22)
	# 화구 안: 바닥이 가장 밝고 위로 갈수록 어둡다 (문 밖으로 새지 않게 문 안 마스크로 살짝만)
	if door_mask != null:
		var inner := Color(0.6, 0.18, 0.05, (0.05 + 0.18 * k) * flick)
		ci.draw_texture_rect(door_mask, Rect2(o + KILN_BODY_RECT.position, KILN_BODY_RECT.size), false, inner)
	glow(ci, Vector2(c.x, box.end.y - 6.0), box.size.x * (0.40 + 0.25 * k), Color(1.0, 0.72, 0.32, (0.18 + 0.55 * k) * flick), 0.55)
	glow(ci, Vector2(c.x, box.end.y - box.size.y * 0.35), box.size.x * (0.25 + 0.2 * k), Color(1.0, 0.5, 0.18, (0.05 + 0.25 * k) * flick))
	# 불 입자
	for f in flames:
		var age: float = float(f["t"]) / f["life"]
		var col := _flame_color(age)
		col.a = (1.0 - age) * 0.75
		glow(ci, f["pos"] + _shake_now, f["size"] * (1.0 - age * 0.45), col)
	# 불티
	for e in embers:
		var a: float = 1.0 - float(e["t"]) / e["life"]
		var p: Vector2 = e["pos"] + _shake_now
		ci.draw_rect(Rect2(p, Vector2(2, 2)), Color(1.0, 0.75, 0.35, a))
		glow(ci, p + Vector2.ONE, 4.0, Color(1.0, 0.5, 0.2, a * 0.6))


func _draw_fire() -> void:
	_draw_kiln_body(Vector2(0, 70), 0.0)
	text(Vector2(0, 30), "불 올리기", C["accent"], 24, 340.0, HORIZONTAL_ALIGNMENT_CENTER)
	text(Vector2(0, 390), "불을 올릴수록 요변이 나올 확률도, 깨질 확률도 오른다", C["dim"], 12, 340.0, HORIZONTAL_ALIGNMENT_CENTER)
	panel(Rect2(350, 20, 276, 340))
	text(Vector2(366, 50), "불 세기  %d / %d" % [kiln.heat, PD.KILN_MAX_HEAT], C["text"], 12)
	for i in PD.KILN_MAX_HEAT:
		var zc: Color = C["good"] if i < PD.KILN_SAFE_HEAT else C["accent"] if i < 7 else C["danger"]
		draw_rect(Rect2(366 + i * 24, 60, 20, 14), zc if i < kiln.heat else zc.darkened(0.7))
	var zone := "안전 — 절대 안 깨짐" if kiln.heat <= PD.KILN_SAFE_HEAT else "위험" if kiln.heat < 8 else "도박!"
	text(Vector2(366, 94), zone, C["good"] if kiln.heat <= PD.KILN_SAFE_HEAT else C["accent"] if kiln.heat < 8 else C["danger"], 12)
	var o: Dictionary = kiln.odds()
	text(Vector2(366, 118), "병사 한 명마다", C["dim"])
	text(Vector2(366, 138), "요변 ★  %d%%" % roundi(o["legend"] * 100.0), C["accent"], 12)
	text(Vector2(446, 138), "불이 우연히 만든 귀한 빛깔", C["dim"], 12)
	text(Vector2(446, 152), "힘 2.6배 · 혼자 특수기", C["dim"], 12)
	text(Vector2(366, 172), "상품    %d%%" % roundi(o["fine"] * 100.0), C["text"], 12)
	text(Vector2(446, 172), "잘 구워짐 · 힘 1.5배", C["dim"], 12)
	text(Vector2(366, 192), "깨짐    %d%%" % roundi(o["crack"] * 100.0), C["danger"] if o["crack"] > 0.0 else C["dim"], 12)
	text(Vector2(366, 220), "파편  %d / %d" % [kiln.shards, PD.SHARDS_FOR_LEGEND], C["text"])
	text(Vector2(366, 238), "3개면 다음 가마에서 요변 확정" if not kiln.guaranteed_legend() else "이번 가마: 요변 1개 확정!", C["dim"] if not kiln.guaranteed_legend() else C["accent"])
	button(Rect2(366, 270, 244, 30), "불 올리기  (스페이스)", "heat", C["fire"].lightened(0.3), kiln.heat < PD.KILN_MAX_HEAT)
	button(Rect2(366, 310, 244, 30), "가마 열기  (Enter)", "open")


func _draw_reveal() -> void:
	var open_k := clampf(reveal_t / 40.0, 0.0, 1.0)
	draw_rect(Rect2(Vector2.ZERO, VIEW), C["bg"])
	text(Vector2(0, 34), "가마 열기", C["accent"], 24, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	# 연기
	if reveal_t < 90:
		for i in 12:
			var sp := Vector2(80 + i * 45, 240 - fmod(reveal_t * 1.5 + i * 13.0, 160.0))
			draw_circle(sp, 18.0, Color(0.8, 0.8, 0.8, 0.25 * (1.0 - reveal_t / 90.0)))
	for i in kiln.results.size():
		var r: Dictionary = kiln.results[i]
		var p := _slot_pos(i)
		draw_rect(Rect2(p + Vector2(-40, 30), Vector2(80, 6)), Color("3a261c"))
		if i >= reveal_shown:
			draw_rect(Rect2(p + Vector2(-16, -30), Vector2(32, 56)), Color(0.25, 0.2, 0.18, 0.6 + 0.4 * (1.0 - open_k)))
			text(p + Vector2(-6, 0), "?", C["dim"], 24)
			continue
		if r["cracked"]:
			for k in 5:
				draw_rect(Rect2(p + Vector2(-18 + k * 8, 20 - (k % 2) * 4), Vector2(6, 4)), C["clay"].darkened(0.3))
			text(p + Vector2(-40, 60), "깨짐", C["dim"], 12, 80.0, HORIZONTAL_ALIGNMENT_CENTER)
			continue
		draw_ally_shape(p, r["role"], r["element"], r["tier"], 2.0)
		var tc: Color = C["accent"] if r["tier"] == "legend" else C["text"] if r["tier"] == "fine" else C["dim"]
		text(p + Vector2(-50, 60), r["name"], C["text"], 12, 100.0, HORIZONTAL_ALIGNMENT_CENTER)
		var tier_label: String = PD.TIER_NAME_KILN[r["tier"]] + (" (파편 확정)" if r["lucky"] else "")
		if r.get("refire", false):
			tier_label = ("%s → %s" % [PD.TIER_NAME_KILN[r["before"]], PD.TIER_NAME_KILN[r["tier"]]]) if r["before"] != r["tier"] else ("%s 그대로" % PD.TIER_NAME_KILN[r["tier"]])
		text(p + Vector2(-50, 78), tier_label, tc, 12, 100.0, HORIZONTAL_ALIGNMENT_CENTER)
	if reveal_shown >= kiln.results.size():
		var counts := {}
		for r2 in kiln.results:
			if not r2["cracked"]:
				counts[r2["element"]] = counts.get(r2["element"], 0) + 1
		var syn := []
		for e in counts:
			if counts[e] >= PD.SYNERGY_COUNT:
				syn.append(PD.SYNERGY_NAME[e])
		text(Vector2(0, 340), ("합동 기술: " + ", ".join(syn)) if not syn.is_empty() else "합동 기술 없음", C["accent"] if not syn.is_empty() else C["dim"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
		button(Rect2(230, 352, 180, 30), "준비로  (Enter)", "fight")
