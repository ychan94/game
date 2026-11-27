extends "res://src/game/proto_base.gd"
## B 가마의 병사 — 한 판 = 밤 5번. 병사는 밤이 지나도 남는다.
##   준비(빚기·다시 굽기·합치기) → 가마(불 올리기·열기) → 준비 → 밤 → 밤 결과 → 준비 … → 다섯 밤

const KilnRun = preload("res://src/proto/kiln_run.gd")

var run
var kiln                 # run.kiln (불 세기·확률·파편)
var state := "prep"      # prep → fire → reveal → prep → battle → night_end → prep … / final
var reveal_t := 0
var reveal_shown := 0
var selected := -1       # 고른 병사 id
var craft_role := "spear"
var craft_element := "fire"


func _ready() -> void:
	super._ready()
	view_style = "kiln"
	_new_run()


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
	tick_fx()
	queue_redraw()
	end_input()


func _prep_input() -> void:
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
				selected = m["id"]
				float_text(Vector2(150, 150), "합치기! %s %s" % [m["name"], "★".repeat(m["star"])], C["accent"], 24)
				shake = 4.0
			break
	for r in PD.ROLES:
		if clicked("role_" + r):
			craft_role = r
	for e in PD.ELEMENTS:
		if clicked("el_" + e):
			craft_element = e
	if clicked("craft"):
		run.craft(craft_role, craft_element)
	for i in run.queue.size():
		if clicked("uq%d" % i):
			run.unqueue(i)
			break
	if not run.queue.is_empty() and (clicked("fire_go") or pressed(KEY_SPACE)):
		state = "fire"
	elif run.queue.is_empty() and not run.army.is_empty() and (clicked("night_go") or pressed(KEY_ENTER) or pressed(KEY_KP_ENTER)):
		battle = run.start_night()
		uv.clear()
		state = "battle"


func _slot_pos(i: int) -> Vector2:
	return Vector2(110 + i * 105, 225)


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
			draw_battle_hud("가마의 병사 — 밤 %d / %d" % [mini(run.night, PD.KILN_NIGHTS) if state == "battle" else run.night - (0 if run.state == "lost" else 1), PD.KILN_NIGHTS])
			if state == "night_end":
				_draw_night_end()
	draw_fx()


func _power(s: Dictionary) -> float:
	return PD.TIER_MUL[s["tier"]] * PD.STAR_MUL[s["star"]]


func _draw_prep() -> void:
	text(Vector2(10, 26), "밤 %d/%d 준비" % [run.night, PD.KILN_NIGHTS], C["accent"], 24)
	text(Vector2(10, 40), "병사 %d / %d 자리" % [run.army.size(), run.cap()], C["text"])
	text(Vector2(300, 16), "마을", C["dim"])
	draw_rect(Rect2(332, 8, 110, 8), Color("3a2430"))
	draw_rect(Rect2(332, 8, 110 * run.village_hp / PD.VILLAGE_HP, 8), C["good"])
	text(Vector2(300, 36), "흙 %d" % run.clay, C["clay"].lightened(0.35), 12)
	text(Vector2(460, 16), "파편 %d / %d" % [kiln.shards, PD.SHARDS_FOR_LEGEND], C["dim"])
	text(Vector2(460, 34), "이번 밤: 도깨비 +%d%%%s" % [roundi(PD.NIGHT_HP_GROWTH * 100.0 * (run.night - 1)), " · 대장 출현!" if run.night >= PD.KILN_NIGHTS else ""], C["danger"] if run.night >= PD.KILN_NIGHTS else C["dim"])
	# 군대
	var cw := 76.0
	var ch := 96.0
	for i in run.cap():
		var x: float = 10.0 + (i % 5) * (cw + 2.0)
		var y: float = 46.0 + (i / 5) * (ch + 4.0)
		var r := Rect2(x, y, cw, ch)
		if i >= run.army.size():
			draw_rect(r, C["card"].darkened(0.4))
			draw_rect(r, C["dim"].darkened(0.4), false, 1.0)
			continue
		var s: Dictionary = run.army[i]
		var queued: bool = run.is_queued(s["id"])
		buttons.append({"rect": r, "id": "card%d" % s["id"]})
		draw_rect(r, C["card"].lightened(0.06 if r.has_point(get_local_mouse_position()) else 0.0))
		draw_rect(r, C["accent"] if selected == s["id"] else C["dim"], false, 2.0 if selected == s["id"] else 1.0)
		draw_ally_shape(Vector2(x + cw / 2.0, y + 52), s["role"], s["element"], s["tier"], 2.0)
		if s["tier"] != "normal":
			text(Vector2(x + 4, y + 13), PD.TIER_NAME_KILN[s["tier"]], C["accent"] if s["tier"] == "legend" else C["text"])
		text(Vector2(x, y + ch - 6), "★".repeat(s["star"]), C["accent"], 12, cw, HORIZONTAL_ALIGNMENT_CENTER)
		if queued:
			draw_rect(r, Color(0.05, 0.03, 0.02, 0.6))
			text(Vector2(x, y + 54), "가마 안", C["fire"].lightened(0.3), 12, cw, HORIZONTAL_ALIGNMENT_CENTER)
	# 고른 병사·합치기
	var info_y := 256.0
	var sel: Dictionary = run.soldier(selected) if selected >= 0 else {}
	if not sel.is_empty():
		text(Vector2(12, info_y), "%s %s · %s · 힘 ×%.1f" % [sel["name"], "★".repeat(sel["star"]), PD.TIER_NAME_KILN[sel["tier"]], _power(sel)], C["text"])
		var why := "" if run.can_refire(selected) else ("요변은 더 오를 데가 없음" if sel["tier"] == "legend" else ("이미 가마 안" if run.is_queued(selected) else ("흙 부족" if run.clay < PD.CLAY_REFIRE else "가마가 가득 참")))
		button(Rect2(10, info_y + 8, 190, 24), "다시 굽기 · 흙 %d" % PD.CLAY_REFIRE if why == "" else why, "refire", C["fire"].lightened(0.3), why == "")
	else:
		text(Vector2(12, info_y), "병사를 누르면 다시 굽기 (요변을 노린다 · 등급은 안 내려감)", C["dim"])
	var groups: Array = run.merge_groups()
	for i in mini(groups.size(), 2):
		var g: Dictionary = run.soldier(groups[i][0])
		button(Rect2(206 + i * 98, info_y + 8, 96, 24), "합치기 %s" % "★".repeat(g["star"] + 1), "merge%d" % i, C["accent"])
	if groups.is_empty():
		text(Vector2(206, info_y + 24), "같은 병사 3명 → 별 +1 (확정)", C["dim"])
	# 가마에 넣을 것
	panel(Rect2(406, 46, 226, 284))
	text(Vector2(416, 64), "가마 (%d / %d)" % [run.queue.size(), PD.KILN_SLOTS], C["accent"])
	for i in PD.KILN_SLOTS:
		var ry: float = 72.0 + i * 24.0
		if i >= run.queue.size():
			draw_rect(Rect2(414, ry, 210, 20), C["card"].darkened(0.3))
			continue
		var q: Dictionary = run.queue[i]
		draw_rect(Rect2(414, ry, 210, 20), C["card"])
		draw_rect(Rect2(418, ry + 4, 12, 12), C[q["element"]])
		text(Vector2(436, ry + 15), "%s · %s" % [KilnRun.soldier_name(q["role"], q["element"]), "새로" if q["kind"] == "new" else "다시 굽기"], C["text"])
		button(Rect2(602, ry + 2, 18, 16), "×", "uq%d" % i, C["dim"])
	text(Vector2(416, 210), "새 병사 빚기 · 흙 %d" % PD.CLAY_CRAFT, C["text"])
	for i in PD.ROLES.size():
		var r2: String = PD.ROLES[i]
		button(Rect2(414 + i * 72, 218, 68, 22), PD.ROLE_NAME_KILN[r2], "role_" + r2, C["accent"] if craft_role == r2 else C["dim"])
	for i in PD.ELEMENTS.size():
		var e: String = PD.ELEMENTS[i]
		button(Rect2(414 + i * 72, 244, 68, 22), PD.GLAZE_NAME[e], "el_" + e, C[e].lightened(0.4) if craft_element == e else C["dim"])
	draw_ally_shape(Vector2(450, 300), craft_role, craft_element, "normal", 1.4)
	var cwhy := "" if run.can_craft() else ("흙 부족" if run.clay < PD.CLAY_CRAFT else ("자리가 없음 — 합치기!" if run.army.size() + run.queued_new() >= run.cap() else "가마가 가득 참"))
	button(Rect2(480, 286, 144, 30), ("빚기 → 가마") if cwhy == "" else cwhy, "craft", C["accent"], cwhy == "")
	# 진행
	button(Rect2(10, 344, 300, 30), "가마에 불 지피기  (스페이스)", "fire_go", C["fire"].lightened(0.3), not run.queue.is_empty())
	button(Rect2(330, 344, 300, 30), "밤 맞이하기  (Enter)" if run.queue.is_empty() else "가마를 먼저 여세요", "night_go", C["accent"], run.queue.is_empty() and not run.army.is_empty())
	text(Vector2(0, 392), "합치기: 같은 모양·유약·별 3명 → 별 +1 (확정) · 다시 굽기: 요변을 노림 (등급은 안 내려감, 불 5↑ 깨질 위험)", C["dim"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)


func _draw_night_end() -> void:
	panel(Rect2(120, 80, 400, 240))
	var won_night: bool = run.state != "lost"
	var title := "다섯 밤을 모두 지켰다!" if run.state == "won" else ("%d번째 밤을 지켰다!" % (run.night - 1) if won_night else "마을이 무너졌다")
	text(Vector2(120, 120), title, C["good"] if won_night else C["danger"], 24, 400.0, HORIZONTAL_ALIGNMENT_CENTER)
	var lines := [
		"처치 %d · 합동 기술 %d번 · 요변 특수기 %d번" % [battle.stats["kills"], battle.stats["synergies"], battle.stats["specials"]],
		"남은 마을 체력 %d%%" % roundi(100.0 * battle.village_hp / PD.VILLAGE_HP),
	]
	if run.state == "prep":
		lines.append("흙 +%d  (기본 %d + 처치 %d마리당 1)" % [run.last_reward, PD.CLAY_PER_NIGHT, PD.CLAY_PER_KILLS])
		lines.append("마을 수리 +%d · 병사 자리 +%d" % [roundi(PD.VILLAGE_REPAIR), PD.ARMY_CAP_PER_NIGHT])
		lines.append("다음 밤: 도깨비가 더 강해진다" + (" · 도깨비 대장 출현!" if run.night >= PD.KILN_NIGHTS else ""))
	var y := 156.0
	for l in lines:
		text(Vector2(120, y), l, C["text"], 12, 400.0, HORIZONTAL_ALIGNMENT_CENTER)
		y += 22.0
	button(Rect2(220, 280, 200, 28), "다음 밤 준비  (Enter)" if run.state == "prep" else "처음부터  (Enter)", "next")


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
