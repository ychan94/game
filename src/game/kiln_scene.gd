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
			if (pressed(KEY_SPACE) or clicked("heat")) and kiln.heat < PD.KILN_MAX_HEAT:
				kiln.heat_up()
				shake = maxf(shake, 1.0 + kiln.heat * 0.4)
				burst(Vector2(170, 250), C["fire"].lightened(0.2), 6 + kiln.heat * 2, 2.0 + kiln.heat * 0.2)
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
		show_banner("요변!", "%s — 가마가 만든 기적" % r["name"], C["accent"], 80)
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
	text(Vector2(0, 384), "버튼을 눌러 모양과 유약을 바꾸세요 · Esc 처음으로", C["dim"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)


func _kiln_glow() -> Color:
	var k: float = float(kiln.heat) / PD.KILN_MAX_HEAT
	return Color("401010").lerp(Color("ff7a20"), minf(1.0, k * 1.4)).lerp(Color("fff2c0"), maxf(0.0, k - 0.6) * 2.0)


func _draw_kiln_body(offset: Vector2, door_open: float) -> void:
	var o := offset + shake_offset()
	var glow := _kiln_glow()
	var k: float = float(kiln.heat) / PD.KILN_MAX_HEAT
	# 가마 주변이 달아오른다
	for i in 4:
		var ring := glow
		ring.a = 0.06 * k * (4 - i)
		draw_circle(o + Vector2(170, 190), 150.0 + i * 18.0, ring)
	# 몸체 (벽돌)
	draw_rect(Rect2(o + Vector2(40, 120), Vector2(260, 150)), Color("5a3a2a"))
	draw_circle(o + Vector2(170, 120), 130.0, Color("5a3a2a"))
	for row in 6:
		for col in 7:
			var bx := 48.0 + col * 36.0 + (18.0 if row % 2 == 1 else 0.0)
			if bx < 290.0:
				draw_rect(Rect2(o + Vector2(bx, 128 + row * 22), Vector2(32, 18)), Color("634232"), false, 1.0)
	# 문 (닫힘 → 열림): 문틈으로 불빛이 샌다
	var door := Rect2(o + Vector2(80, 60), Vector2(180, 170))
	draw_rect(door.grow(4.0), glow)
	if door_open < 1.0:
		var dh := door.size.y * (1.0 - door_open)
		draw_rect(Rect2(door.position, Vector2(door.size.x, dh)), Color("3d2a20"))
		draw_rect(Rect2(door.position, Vector2(door.size.x, dh)), Color("7a5a44"), false, 2.0)
		# 뜨거우면 문이 달아오르고 금이 빛난다
		if kiln.heat >= 5:
			var hot := glow
			hot.a = 0.12 * (kiln.heat - 4)
			draw_rect(Rect2(door.position, Vector2(door.size.x, dh)), hot)
		if kiln.heat >= 8:
			draw_polyline(PackedVector2Array([o + Vector2(150, 70), o + Vector2(162, 110), o + Vector2(148, 150), o + Vector2(166, 200)]), glow.lightened(0.4), 2.0)
	# 아궁이: 불길
	var mouth := Rect2(o + Vector2(110, 238), Vector2(120, 32))
	draw_rect(mouth, Color("1a0d08"))
	for i in 4 + kiln.heat * 2:
		var fx_x: float = mouth.position.x + 8.0 + fmod(i * 29.0, mouth.size.x - 16.0)
		var flick := sin(t * 0.35 + i * 1.7) * 4.0
		var hgt: float = 6.0 + kiln.heat * 2.6 + flick
		draw_colored_polygon(PackedVector2Array([Vector2(fx_x - 6, mouth.end.y), Vector2(fx_x + 6, mouth.end.y), Vector2(fx_x + flick * 0.3, mouth.end.y - hgt)]),
			glow if i % 2 == 0 else glow.lightened(0.3))
	# 굴뚝 연기와 불티
	for i in 2 + kiln.heat:
		var sp := o + Vector2(170 + sin(t * 0.05 + i) * 8.0, 0 - fmod(t * (0.6 + k) + i * 17.0, 60.0))
		draw_circle(sp, 3.0 + i * 0.4, Color(glow.r, glow.g, glow.b, 0.5 * k))
	draw_rect(Rect2(o + Vector2(0, 270), Vector2(340, 20)), Color("3a261c"))


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
	text(Vector2(366, 124), "병사 한 명마다", C["dim"])
	text(Vector2(366, 146), "요변 (기적)   %d%%" % roundi(o["legend"] * 100.0), C["accent"], 12)
	text(Vector2(366, 166), "상품          %d%%" % roundi(o["fine"] * 100.0), C["text"], 12)
	text(Vector2(366, 186), "깨질 확률     %d%%" % roundi(o["crack"] * 100.0), C["danger"] if o["crack"] > 0.0 else C["dim"], 12)
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
