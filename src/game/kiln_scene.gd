extends "res://src/game/proto_base.gd"
## B 가마의 병사 — 1분 시험판: 빚기 → 불 올리기 → 가마 열기 → 밤 한 번

const Kiln = preload("res://src/proto/kiln.gd")

var kiln
var state := "shape"     # shape → fire → reveal → battle → result
var reveal_t := 0
var reveal_shown := 0


func _ready() -> void:
	super._ready()
	view_style = "kiln"
	kiln = Kiln.new(int(Time.get_unix_time_from_system()))


func _physics_process(_d: float) -> void:
	back_to_menu_if_esc()
	match state:
		"shape":
			for i in kiln.slots.size():
				if clicked("role%d" % i):
					kiln.cycle_role(i)
				if clicked("elem%d" % i):
					kiln.cycle_element(i)
			if pressed(KEY_ENTER) or pressed(KEY_KP_ENTER) or clicked("go"):
				state = "fire"
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
				kiln.open()
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
				battle = kiln.make_battle(int(Time.get_unix_time_from_system()))
				state = "battle"
		"battle":
			step_battle()
			if battle.done:
				state = "result"
				banner = {}
		"result":
			if pressed(KEY_R) or pressed(KEY_ENTER) or clicked("retry"):
				kiln.reset_slots()
				battle = null
				state = "shape"
	tick_fx()
	queue_redraw()
	end_input()


func _slot_pos(i: int) -> Vector2:
	return Vector2(110 + i * 105, 225)


func _reveal_one(i: int) -> void:
	var r: Dictionary = kiln.results[i]
	var p := _slot_pos(i)
	if r["cracked"]:
		burst(p, C["clay"], 22, 3.5, 3.0)
		float_text(p + Vector2(-24, -40), "깨짐… 파편 +1", C["dim"])
		shake = maxf(shake, 3.0)
	elif r["tier"] == "legend":
		burst(p, C["accent"], 40, 4.5, 3.0)
		do_flash(C["accent"], 18)
		shake = maxf(shake, 9.0)
		show_banner("요변!", "%s — 불이 우연히 만든 귀한 빛깔 · 힘 2.6배" % r["name"], C["accent"], 90)
	elif r["tier"] == "fine":
		burst(p, C[r["element"]].lightened(0.4), 14, 2.5)
		float_text(p + Vector2(-12, -40), "상품", C["accent"])
	else:
		burst(p, C["dim"], 6, 1.5)


# ---------------- 그리기 ----------------
func _draw() -> void:
	buttons.clear()
	draw_rect(Rect2(Vector2.ZERO, VIEW), C["bg"])
	match state:
		"shape":
			_draw_shape()
		"fire":
			_draw_fire()
		"reveal":
			_draw_reveal()
		"battle", "result":
			draw_battle()
			draw_battle_hud("가마의 병사 — 밤")
			if state == "result":
				draw_result(battle.result == "win", "R  다시 빚기 (파편은 남아요)")
	draw_fx()


func _draw_shape() -> void:
	text(Vector2(0, 34), "병사 빚기", C["accent"], 24, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	text(Vector2(0, 56), "모양 = 역할 · 유약 = 속성 · 같은 유약 3개면 합동 기술", C["dim"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	var counts := {}
	for i in kiln.slots.size():
		var s: Dictionary = kiln.slots[i]
		counts[s["element"]] = counts.get(s["element"], 0) + 1
		var x: float = 28.0 + i * 120.0
		draw_rect(Rect2(x, 80, 104, 200), C["card"])
		draw_rect(Rect2(x, 80, 104, 200), C["dim"], false, 1.0)
		draw_ally_shape(Vector2(x + 52, 150), s["role"], s["element"], "normal", 2.2)
		button(Rect2(x + 8, 206, 88, 26), "모양: " + PD.ROLE_NAME_KILN[s["role"]], "role%d" % i, C["text"])
		button(Rect2(x + 8, 240, 88, 26), "유약: " + PD.GLAZE_NAME[s["element"]], "elem%d" % i, C[s["element"]].lightened(0.3))
	var syn := []
	for e in counts:
		if counts[e] >= PD.SYNERGY_COUNT:
			syn.append("%s %d → %s" % [PD.GLAZE_NAME[e], counts[e], PD.SYNERGY_NAME[e]])
	text(Vector2(0, 306), ("합동 기술 준비됨: " + ", ".join(syn)) if not syn.is_empty() else "합동 기술 없음 (같은 유약 3개가 필요)",
		C["accent"] if not syn.is_empty() else C["dim"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	button(Rect2(230, 328, 180, 30), "가마에 넣기  (Enter)", "go")
	text(Vector2(0, 378), "요변(窯變): 가마 불 속에서 우연히 생기는 귀한 빛깔. 요변 병사는 힘 2.6배에 혼자 특수기를 쓴다", C["accent"].darkened(0.15), 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	text(Vector2(0, 394), "버튼을 눌러 모양과 유약을 바꾸세요 · Esc 처음으로", C["dim"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)


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
		text(p + Vector2(-50, 78), PD.TIER_NAME_KILN[r["tier"]] + (" (파편 확정)" if r["lucky"] else ""), tc, 12, 100.0, HORIZONTAL_ALIGNMENT_CENTER)
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
		button(Rect2(230, 352, 180, 30), "밤이 온다  (Enter)", "fight")
