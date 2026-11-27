extends "res://src/game/proto_base.gd"
## A 알을 품는 성 — 1분 시험판: 알 3개 (먹이 → 데우기 → 깨우기) → 밤 한 번

const Nest = preload("res://src/proto/nest.gd")

var nest
var state := "egg"       # egg → hatch → (egg …) → night → battle → result
var hatch_t := 0
var last := {}           # 방금 깬 결과 {"kind": "hatch"/"burst", "creature": {}}


func _ready() -> void:
	super._ready()
	view_style = "nest"
	nest = Nest.new(int(Time.get_unix_time_from_system()))


func _physics_process(_d: float) -> void:
	back_to_menu_if_esc()
	match state:
		"egg":
			for e in PD.ELEMENTS:
				if clicked("food_" + e):
					nest.feed(e)
					burst(Vector2(200, 200), C[e].lightened(0.3), 10, 2.0)
			if pressed(KEY_SPACE) or clicked("warm"):
				var r: String = nest.warm()
				if r == "burst":
					last = {"kind": "burst", "creature": nest.hostiles[-1]}
					_start_hatch()
					burst(Vector2(200, 200), C["hostile"], 40, 5.0, 3.0)
					do_flash(C["danger"], 20)
					shake = 12.0
				else:
					shake = maxf(shake, 1.0 + nest.egg().get("warmth", 0) * 0.5)
					burst(Vector2(200, 200), C["accent"], 4 + nest.egg().get("warmth", 0), 1.5)
			elif pressed(KEY_ENTER) or pressed(KEY_KP_ENTER) or clicked("hatch"):
				var c: Dictionary = nest.hatch()
				last = {"kind": "hatch", "creature": c}
				_start_hatch()
				var col: Color = C[c["element"]]
				if c["tier"] == "legend":
					burst(Vector2(200, 200), C["accent"], 46, 5.0, 3.0)
					do_flash(C["accent"], 20)
					shake = 10.0
					show_banner("전설!", c["name"], C["accent"], 80)
				elif c["tier"] == "fine":
					burst(Vector2(200, 200), col.lightened(0.3), 24, 3.5, 3.0)
					shake = 4.0
				else:
					burst(Vector2(200, 200), col, 12, 2.0)
				if c.get("lucky", false):
					float_text(Vector2(140, 120), "운 좋게 한 단계 위!", C["accent"], 12)
		"hatch":
			hatch_t += 1
			if hatch_t > 30 and (pressed(KEY_ENTER) or pressed(KEY_KP_ENTER) or pressed(KEY_SPACE) or clicked("next")):
				state = "night" if nest.done() else "egg"
		"night":
			if pressed(KEY_ENTER) or pressed(KEY_KP_ENTER) or clicked("fight"):
				battle = nest.make_battle(int(Time.get_unix_time_from_system()))
				state = "battle"
		"battle":
			step_battle()
			if battle.done:
				state = "result"
				banner = {}
		"result":
			if pressed(KEY_R) or pressed(KEY_ENTER) or clicked("retry"):
				nest.new_clutch()
				battle = null
				state = "egg"
	tick_fx()
	queue_redraw()
	end_input()


func _start_hatch() -> void:
	state = "hatch"
	hatch_t = 0


# ---------------- 그리기 ----------------
func _draw() -> void:
	buttons.clear()
	draw_screen_bg()
	match state:
		"egg":
			_draw_egg_screen()
		"hatch":
			_draw_hatch()
		"night":
			_draw_night()
		"battle", "result":
			draw_battle()
			draw_battle_hud("알을 품는 성 — 밤")
			if state == "result":
				draw_result(battle.result == "win", "R  새 알 품기 (껍질 조각은 남아요)")
	draw_fx()


func _egg_shape(center: Vector2, e: Dictionary, size_k: float, wobble: float) -> void:
	var c: Color = C[e["hint"]].lerp(Color("e8dcc8"), 0.55)
	var rot := sin(t * 0.25) * wobble
	var etex := tex("nest/egg_" + e["role"])
	if etex != null:
		# 알 그림(밝은 흰색 계열)을 기운 색으로 물들이고, 흔들림은 회전으로
		var sz: Vector2 = etex.get_size() * size_k * 2.0
		draw_set_transform(center, rot, Vector2.ONE)
		draw_texture_rect(etex, Rect2(-sz / 2.0, sz), false, C[e["hint"]].lerp(Color.WHITE, 0.6))
		draw_set_transform(Vector2.ZERO)
		_draw_egg_cracks(center, e, size_k)
		return
	var pts := PackedVector2Array()
	for i in 24:
		var a := TAU * i / 24.0
		var r := Vector2(cos(a) * 26.0, sin(a) * 34.0 - (6.0 if sin(a) < 0 else 0.0))
		match e["role"]:
			"spear":
				if i % 4 == 0:
					r *= 1.12
			"archer":
				r.y *= 1.15
				r.x *= 0.85
			"shield":
				r.x *= 1.15
		pts.append(center + r.rotated(rot) * size_k)
	draw_colored_polygon(pts, c)
	for i in 3:
		draw_circle(center + Vector2(-10 + i * 10, -6 + (i % 2) * 12).rotated(rot) * size_k, 4.0 * size_k, C[e["hint"]].lightened(0.1))
	_draw_egg_cracks(center, e, size_k)


func _draw_egg_cracks(center: Vector2, e: Dictionary, size_k: float) -> void:
	var w: int = e["warmth"]
	for k in mini(w, 8):
		var a2 := 0.7 * k
		var p0 := center + Vector2(cos(a2) * 8.0, sin(a2) * 10.0 - 6.0) * size_k
		draw_polyline(PackedVector2Array([p0, p0 + Vector2(6, 5) * size_k, p0 + Vector2(2, 12) * size_k, p0 + Vector2(8, 18) * size_k]), Color(0.15, 0.1, 0.08), 1.5)
	if w > 0 and size_k > 1.0:
		for i in 3:
			draw_arc(center, (38.0 + i * 6.0 + sin(t * 0.2 + i) * 2.0) * size_k, 0, TAU, 32, Color(1.0, 0.7, 0.3, 0.08 + w * 0.03 - i * 0.03), 2.0)


func _draw_egg_screen() -> void:
	var e: Dictionary = nest.egg()
	text(Vector2(0, 34), "알 품기  (%d / %d)" % [nest.current + 1, PD.NEST_EGGS], C["accent"], 24, 400.0, HORIZONTAL_ALIGNMENT_CENTER)
	var w: int = e["warmth"]
	_egg_shape(Vector2(200, 200) + shake_offset(), e, 2.2, 0.03 + w * 0.025)
	# 다른 알들
	for i in nest.eggs.size():
		var o: Dictionary = nest.eggs[i]
		var p := Vector2(60 + i * 40, 352)
		if o["state"] == "hatched":
			draw_ally_shape(p, o["creature"]["role"], o["creature"]["element"], o["creature"]["tier"], 0.8)
		elif o["state"] == "burst":
			text(p + Vector2(-6, 4), "✕", C["danger"])
		else:
			_egg_shape(p, o, 0.45, 0.0)
	text(Vector2(40, 384), "모양: %s · 색: %s 기운" % [PD.ROLE_NAME_NEST[e["role"]], PD.ELEMENT_NAME[e["hint"]]], C["dim"])
	panel(Rect2(380, 20, 246, 360))
	text(Vector2(396, 48), "먹이로 기운 기울이기 (%d%%)" % roundi(PD.FOOD_TILT * 100), C["dim"])
	for i in PD.ELEMENTS.size():
		var el: String = PD.ELEMENTS[i]
		var chosen: bool = e["food"] == el
		button(Rect2(396 + i * 76, 58, 70, 26), PD.FOOD_NAME[el], "food_" + el, C[el].lightened(0.3) if not chosen else C["accent"])
	text(Vector2(396, 108), "먹인 것: %s" % (PD.FOOD_NAME[e["food"]] if e["food"] != "" else "없음"), C["text"])
	text(Vector2(396, 140), "온기  %d" % w, C["text"], 24)
	var tier: String = nest.tier_for(w)
	text(Vector2(396, 166), "지금 깨우면:  %s" % PD.TIER_NAME_NEST[tier], C["accent"] if tier != "normal" else C["text"])
	var nxt := PD.NEST_FINE_AT - w if w < PD.NEST_FINE_AT else PD.NEST_LEGEND_AT - w if w < PD.NEST_LEGEND_AT else 0
	if nxt > 0:
		text(Vector2(396, 186), "다음 등급까지 %d번 더" % nxt, C["dim"])
	var bc: float = nest.burst_chance()
	text(Vector2(396, 218), "한 번 더 데우면 터질 확률", C["dim"])
	text(Vector2(396, 244), "%d%%" % roundi(bc * 100.0), C["good"] if bc == 0.0 else C["accent"] if bc < 0.25 else C["danger"], 24)
	text(Vector2(396, 272), "껍질 조각 %d / %d" % [nest.shells, PD.SHARDS_FOR_LEGEND] + ("  (이 알은 안전!)" if nest.safe_egg else ""), C["accent"] if nest.safe_egg else C["dim"])
	button(Rect2(396, 290, 214, 30), "데우기  (스페이스)", "warm", C["fire"].lightened(0.3))
	button(Rect2(396, 330, 214, 30), "깨우기  (Enter)", "hatch")


func _draw_hatch() -> void:
	var c: Dictionary = last["creature"]
	var k := minf(1.0, hatch_t / 20.0)
	if last["kind"] == "burst":
		text(Vector2(0, 60), "알이 터졌다!", C["danger"], 24, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
		draw_ally_shape(Vector2(320, 190), c["role"], c["element"], c["tier"], 1.5 + k * 1.5, false)
		draw_circle(Vector2(320, 190), 60.0 * k, Color(0.35, 0.1, 0.4, 0.35))
		text(Vector2(0, 280), "폭주 %s — 밤에 적으로 나타납니다" % c["name"], C["danger"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
		text(Vector2(0, 300), "껍질 조각 +1  (3개면 다음 알은 전설까지 안전)", C["dim"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	else:
		var tc: Color = C["accent"] if c["tier"] == "legend" else C["text"]
		draw_circle(Vector2(320, 190), 70.0 * k, Color(1, 0.9, 0.6, 0.12))
		draw_ally_shape(Vector2(320, 190), c["role"], c["element"], c["tier"], 1.0 + k * 2.2)
		text(Vector2(0, 280), c["name"], C["text"], 24, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
		text(Vector2(0, 302), "%s · %s · %s" % [PD.TIER_NAME_NEST[c["tier"]], PD.ELEMENT_NAME[c["element"]], PD.ROLE_NAME_NEST[c["role"]]], tc, 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	if hatch_t > 30:
		button(Rect2(230, 340, 180, 30), "다음  (Enter)", "next")


func _draw_night() -> void:
	text(Vector2(0, 40), "밤이 온다", C["accent"], 24, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	var x := 140.0
	var counts := {}
	for e in nest.eggs:
		if e["state"] == "hatched":
			var c: Dictionary = e["creature"]
			counts[c["element"]] = counts.get(c["element"], 0) + 1
			draw_ally_shape(Vector2(x, 160), c["role"], c["element"], c["tier"], 2.0)
			text(Vector2(x - 60, 220), c["name"], C["text"], 12, 120.0, HORIZONTAL_ALIGNMENT_CENTER)
			text(Vector2(x - 60, 238), PD.TIER_NAME_NEST[c["tier"]], C["accent"] if c["tier"] != "normal" else C["dim"], 12, 120.0, HORIZONTAL_ALIGNMENT_CENTER)
		else:
			text(Vector2(x - 60, 170), "(터진 알)", C["danger"], 12, 120.0, HORIZONTAL_ALIGNMENT_CENTER)
		x += 180.0
	var syn := []
	for el in counts:
		if counts[el] >= PD.SYNERGY_COUNT:
			syn.append(PD.SYNERGY_NAME[el])
	text(Vector2(0, 280), ("무리 효과: " + ", ".join(syn)) if not syn.is_empty() else "무리 효과 없음 (같은 기운 3마리 필요)", C["accent"] if not syn.is_empty() else C["dim"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	if not nest.hostiles.is_empty():
		text(Vector2(0, 300), "폭주 괴수 %d마리가 적과 함께 옵니다" % nest.hostiles.size(), C["danger"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	button(Rect2(230, 330, 180, 30), "둥지 지키기  (Enter)", "fight")
