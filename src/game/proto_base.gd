extends Node2D
## 1분 시험판 화면 공통: 글꼴·버튼·입력·연출(흔들림·파편·떠오르는 글자·배너·번쩍임)·전투 그리기.
## 규칙은 src/proto/ 에 있고, 여기서는 읽어서 그리기만 한다. 그림은 임시 도형.

const PD = preload("res://src/proto/data.gd")

const VIEW := Vector2(640, 400)
const FIELD_OFFSET := Vector2(0, 64)
const C := {
	"bg": Color("15131d"), "text": Color("efe8da"), "dim": Color("8e869b"), "accent": Color("ffcf5a"),
	"danger": Color("ff5a4f"), "good": Color("7ee08a"), "panel": Color(0.07, 0.06, 0.1, 0.94), "card": Color("231f2f"),
	"grass_a": Color("23301f"), "grass_b": Color("1f2b1c"), "village": Color("6b4f3a"), "roof": Color("a2493a"),
	"water": Color("7fc7b8"), "fire": Color("d9533f"), "earth": Color("5a4236"),
	"goblin": Color("b0553c"), "imp": Color("5f8cff"), "brute": Color("8c3b2e"), "hostile": Color("5b2a6e"),
	"clay": Color("b98a5e"),
}

var font: FontFile
var buttons: Array = []          # 이번 프레임에 그린 버튼 [{rect, id}]
var _prev := {}
var _mouse_prev := false
var fx: Array = []               # 파편 [{pos, vel, t, life, color, size}]
var floats: Array = []           # 떠오르는 글자 [{pos, text, color, size, t, life}]
var banner := {}                 # {text, sub, color, t, life}
var flash := {}                  # {color, t, life}
var shake := 0.0
var t := 0                       # 화면 프레임 (애니메이션용)
var battle = null
var view_style := "kiln"
var shot_lines: Array = []


func _ready() -> void:
	font = load("res://assets/fonts/Galmuri11.ttf")
	font.antialiasing = TextServer.FONT_ANTIALIASING_NONE
	font.hinting = TextServer.HINTING_NONE
	font.subpixel_positioning = TextServer.SUBPIXEL_POSITIONING_DISABLED


# ---------------- 입력 ----------------
func pressed(key: int) -> bool:
	return Input.is_physical_key_pressed(key) and not _prev.get(key, false)


func clicked(id: String) -> bool:
	if not (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not _mouse_prev):
		return false
	var m := get_local_mouse_position()
	for b in buttons:
		if b["id"] == id and b["rect"].has_point(m):
			return true
	return false


func end_input() -> void:
	for k in [KEY_SPACE, KEY_ENTER, KEY_KP_ENTER, KEY_R, KEY_ESCAPE, KEY_1, KEY_2, KEY_3, KEY_4, KEY_5, KEY_Q, KEY_W, KEY_E, KEY_F12]:
		_prev[k] = Input.is_physical_key_pressed(k)
	_mouse_prev = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	if Input.is_physical_key_pressed(KEY_F12) and not _prev.get(-1, false):
		var img := get_viewport().get_texture().get_image()
		img.save_png("user://shot_%d.png" % Time.get_unix_time_from_system())
	_prev[-1] = Input.is_physical_key_pressed(KEY_F12)


func back_to_menu_if_esc() -> void:
	if pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file("res://src/game/launcher.tscn")


# ---------------- 연출 ----------------
func burst(pos: Vector2, color: Color, n := 10, speed := 2.5, size := 2.0) -> void:
	for i in n:
		var a := randf() * TAU
		var life := randi_range(18, 34)
		fx.append({"pos": pos, "vel": Vector2.from_angle(a) * randf_range(0.5, speed), "t": life, "life": life, "color": color, "size": size})


func float_text(pos: Vector2, text: String, color: Color, size := 12) -> void:
	floats.append({"pos": pos, "text": text, "color": color, "size": size, "t": 40, "life": 40})


func show_banner(text: String, sub: String, color: Color, life := 90) -> void:
	banner = {"text": text, "sub": sub, "color": color, "t": life, "life": life}


func do_flash(color: Color, life := 16) -> void:
	flash = {"color": color, "t": life, "life": life}


func tick_fx() -> void:
	t += 1
	shake = maxf(0.0, shake * 0.85 - 0.05)
	for p in fx:
		p["pos"] += p["vel"]
		p["vel"] *= 0.93
		p["vel"].y += 0.05
		p["t"] -= 1
	fx = fx.filter(func(p): return p["t"] > 0)
	for f in floats:
		f["pos"].y -= 0.6
		f["t"] -= 1
	floats = floats.filter(func(f): return f["t"] > 0)
	for s in shot_lines:
		s["t"] -= 1
	shot_lines = shot_lines.filter(func(s): return s["t"] > 0)
	if not banner.is_empty():
		banner["t"] -= 1
		if banner["t"] <= 0:
			banner = {}
	if not flash.is_empty():
		flash["t"] -= 1
		if flash["t"] <= 0:
			flash = {}


## 전투 한 프레임 + 이벤트를 연출로 바꾸기
func step_battle() -> void:
	if battle == null or battle.done:
		return
	battle.step()
	for e in battle.events:
		var col: Color = C.get(e.get("element", ""), C["text"])
		match e["kind"]:
			"hit":
				if e["team"] == "enemy":
					var amt: float = e["amount"]
					float_text(e["pos"] + FIELD_OFFSET + Vector2(randf_range(-6, 6), -10), "%d" % ceili(amt),
						col.lightened(0.3) if e["element"] != "" else C["text"], 24 if amt >= 20.0 else 12)
			"death":
				burst(e["pos"] + FIELD_OFFSET, C["accent"] if e["team"] == "enemy" else C["dim"], 14 if e["big"] else 8, 3.0)
				if e["big"]:
					shake = maxf(shake, 5.0)
			"shot":
				shot_lines.append({"from": e["from"], "to": e["to"], "t": 6, "color": col if e["team"] == "ally" else C["imp"]})
			"special":
				shake = maxf(shake, 6.0)
				burst(e["pos"] + FIELD_OFFSET, col, 24, 4.0, 3.0)
				float_text(e["pos"] + FIELD_OFFSET + Vector2(-20, -24), "%s!" % ("요변" if view_style == "kiln" else "전설"), C["accent"], 24)
			"synergy":
				shake = maxf(shake, 10.0)
				do_flash(col, 20)
				show_banner(e["name"] + "!", "%s %d — 합동 기술" % [(PD.GLAZE_NAME if view_style == "kiln" else PD.ELEMENT_NAME)[e["element"]], e["count"]], col, 70)
				for i in 30:
					burst(Vector2(randf_range(200, 640), randf_range(80, 320)), col, 2, 3.0, 3.0)
			"village_hit":
				shake = maxf(shake, 3.0)
				do_flash(C["danger"], 8)


# ---------------- 그리기 도우미 ----------------
func text(pos: Vector2, s: String, color: Color = C["text"], size := 12, width := -1.0, align := HORIZONTAL_ALIGNMENT_LEFT) -> void:
	if width > 0.0:
		draw_multiline_string(font, pos, s, align, width, size, -1, color)
	else:
		draw_string(font, pos, s, align, -1, size, color)


func button(rect: Rect2, label: String, id: String, color: Color = C["accent"], enabled := true) -> void:
	buttons.append({"rect": rect, "id": id})
	var hover := rect.has_point(get_local_mouse_position())
	draw_rect(rect, C["card"].lightened(0.15 if hover else 0.0))
	draw_rect(rect, color if enabled else C["dim"], false, 1.0)
	text(rect.position + Vector2(0, rect.size.y / 2.0 + 5.0), label, color if enabled else C["dim"], 12, rect.size.x, HORIZONTAL_ALIGNMENT_CENTER)


func panel(rect: Rect2) -> void:
	draw_rect(rect, C["panel"])
	draw_rect(rect, C["dim"], false, 1.0)


func shake_offset() -> Vector2:
	return Vector2(randf_range(-shake, shake), randf_range(-shake, shake)) if shake > 0.2 else Vector2.ZERO


func rainbow(phase: float) -> Color:
	return Color.from_hsv(fmod(phase, 1.0), 0.6, 1.0)


func draw_fx() -> void:
	for p in fx:
		var c: Color = p["color"]
		c.a = float(p["t"]) / p["life"]
		draw_rect(Rect2(p["pos"] - Vector2.ONE * p["size"] / 2.0, Vector2.ONE * p["size"]), c)
	for f in floats:
		var c2: Color = f["color"]
		c2.a = minf(1.0, float(f["t"]) / 15.0)
		text(f["pos"], f["text"], c2, f["size"])
	if not flash.is_empty():
		var fc: Color = flash["color"]
		fc.a = 0.35 * float(flash["t"]) / flash["life"]
		draw_rect(Rect2(Vector2.ZERO, VIEW), fc)
	if not banner.is_empty():
		var k: float = float(banner["t"]) / banner["life"]
		var bc: Color = banner["color"].lightened(0.3)
		bc.a = minf(1.0, k * 3.0)
		draw_rect(Rect2(0, 150, 640, 70), Color(0, 0, 0, 0.55 * minf(1.0, k * 3.0)))
		text(Vector2(0, 190), banner["text"], bc, 36, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
		text(Vector2(0, 210), banner["sub"], Color(1, 1, 1, bc.a), 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)


# ---------------- 그림 (Codex 작업물) ----------------
## assets/sprites/<name>.png 가 있으면 그 그림을, 없으면 null (도형으로 대신 그린다).
## 편집기에서 가져오기(import) 전이라도 보이도록 파일을 직접 읽는 길도 둔다.
var _tex_cache := {}


func tex(name: String) -> Texture2D:
	if _tex_cache.has(name):
		return _tex_cache[name]
	var path := "res://assets/sprites/%s.png" % name
	var t: Texture2D = null
	if ResourceLoader.exists(path):
		t = load(path)
	elif FileAccess.file_exists(path):
		var img := Image.load_from_file(ProjectSettings.globalize_path(path))
		if img != null and not img.is_empty():
			t = ImageTexture.create_from_image(img)
	_tex_cache[name] = t
	return t


## 가운데 아래쪽 기준으로 그림을 그린다. 그림이 없으면 false.
func draw_sprite(name: String, center: Vector2, scale_k := 1.0, tint: Color = Color.WHITE) -> bool:
	var tx := tex(name)
	if tx == null:
		return false
	var sz: Vector2 = tx.get_size() * scale_k
	draw_texture_rect(tx, Rect2(center - Vector2(sz.x / 2.0, sz.y * 0.6), sz), false, tint)
	return true


## 그림 둘레에 테두리(rim)를 두른 뒤 그림을 그린다. 그림이 없으면 false.
func draw_sprite_rim(name: String, center: Vector2, scale_k: float, rim: Color, tint: Color = Color.WHITE) -> bool:
	var tx := tex(name)
	if tx == null:
		return false
	var sz: Vector2 = tx.get_size() * scale_k
	var r := Rect2(center - Vector2(sz.x / 2.0, sz.y * 0.6), sz)
	var d := maxf(1.0, roundf(scale_k))
	for off in [Vector2(d, 0), Vector2(-d, 0), Vector2(0, d), Vector2(0, -d)]:
		draw_texture_rect(tx, Rect2(r.position + off, r.size), false, rim)
	draw_texture_rect(tx, r, false, tint)
	return true


func _draw_tier_aura(pos: Vector2, tier: String, scale_k: float) -> void:
	if tier == "legend":
		draw_arc(pos + Vector2(0, -2) * scale_k, 15.0 * scale_k, 0, TAU, 28, rainbow(t * 0.01), 2.0)
		draw_arc(pos + Vector2(0, -2) * scale_k, 17.0 * scale_k, 0, TAU, 28, rainbow(t * 0.01 + 0.5), 1.0)
	elif tier == "fine":
		var sp := pos + Vector2.from_angle(t * 0.08) * 13.0 * scale_k
		draw_rect(Rect2(sp, Vector2(2, 2)), C["accent"])


# ---------------- 병사·괴수·적 그리기 ----------------
func draw_ally_shape(pos: Vector2, role: String, element: String, tier: String, scale_k := 1.0, flash_white := false) -> void:
	var sname := ("kiln/soldier_%s_%s" if view_style == "kiln" else "nest/creature_%s_%s") % [role, element]
	if tex(sname) != null:
		# 발밑에 옅은 속성 빛 + 속성 색 테두리: 어두운 흑유도 밤 풀밭에서 보이고, 유약 구분도 쉬워진다
		var rim: Color = C[element].lightened(0.5)
		var under := rim
		under.a = 0.14
		draw_set_transform(pos + Vector2(0, 11) * scale_k, 0.0, Vector2(1.0, 0.3))  # 납작한 타원
		draw_circle(Vector2.ZERO, 10.0 * scale_k, under)
		draw_set_transform(Vector2.ZERO)
		rim.a = 0.85
		draw_sprite_rim(sname, pos, scale_k, rim, Color(2.5, 2.5, 2.5) if flash_white else Color.WHITE)
		_draw_tier_aura(pos, tier, scale_k)
		return
	var col: Color = Color.WHITE if flash_white else C[element]
	if view_style == "kiln":
		# 흙 병사: 몸통 + 머리 + 역할 표시, 유약 색
		var body := Rect2(pos + Vector2(-6, -6) * scale_k, Vector2(12, 16) * scale_k)
		draw_rect(body, col)
		draw_circle(pos + Vector2(0, -10) * scale_k, 5.0 * scale_k, col.lightened(0.15))
		draw_rect(Rect2(body.position + Vector2(2, 3) * scale_k, Vector2(3, 6) * scale_k), col.lightened(0.35))  # 유약 광택
		match role:
			"spear":
				draw_line(pos + Vector2(8, 10) * scale_k, pos + Vector2(8, -18) * scale_k, C["clay"].lightened(0.3), 2.0 * scale_k)
				draw_colored_polygon(PackedVector2Array([pos + Vector2(5, -18) * scale_k, pos + Vector2(11, -18) * scale_k, pos + Vector2(8, -25) * scale_k]), C["text"])
			"archer":
				draw_arc(pos + Vector2(9, -2) * scale_k, 9.0 * scale_k, -1.2, 1.2, 10, C["clay"].lightened(0.3), 2.0 * scale_k)
			"shield":
				draw_rect(Rect2(pos + Vector2(6, -8) * scale_k, Vector2(7, 18) * scale_k), C["clay"].darkened(0.2))
				draw_rect(Rect2(pos + Vector2(6, -8) * scale_k, Vector2(7, 18) * scale_k), col, false, 1.0)
	else:
		# 괴수: 둥근 몸 + 눈 + 역할 특징
		var r := 9.0 * scale_k
		match role:
			"spear":
				for i in 4:
					var a := -PI / 2.0 + (i - 1.5) * 0.45
					draw_colored_polygon(PackedVector2Array([pos + Vector2.from_angle(a - 0.15) * r, pos + Vector2.from_angle(a + 0.15) * r, pos + Vector2.from_angle(a) * (r + 7.0 * scale_k)]), col.darkened(0.2))
			"archer":
				for i in 3:
					draw_line(pos + Vector2(-5 + i * 5, 4) * scale_k, pos + Vector2(-6 + i * 6, 15) * scale_k + Vector2(sin(t * 0.1 + i) * 2.0, 0), col.lightened(0.2), 2.0)
			"shield":
				draw_arc(pos, r + 3.0 * scale_k, PI, TAU, 16, col.darkened(0.35), 4.0 * scale_k)
		draw_circle(pos, r, col)
		draw_circle(pos + Vector2(-3.5, -2) * scale_k, 2.2 * scale_k, Color.WHITE)
		draw_circle(pos + Vector2(3.5, -2) * scale_k, 2.2 * scale_k, Color.WHITE)
		draw_circle(pos + Vector2(-3.5, -1.5) * scale_k, 1.1 * scale_k, Color.BLACK)
		draw_circle(pos + Vector2(3.5, -1.5) * scale_k, 1.1 * scale_k, Color.BLACK)
	_draw_tier_aura(pos, tier, scale_k)


func draw_enemy_shape(u) -> void:
	var p: Vector2 = u.pos
	var col: Color = C.get(u.kind, C["goblin"])
	if u.hit_flash > 0:
		col = Color.WHITE
	var r: float = u.radius
	var ename: String = "enemy/" + u.kind
	if u.kind == "hostile":
		ename = "nest/creature_spear_" + (u.element if u.element != "" else "fire")
	var etint: Color = Color(2.5, 2.5, 2.5) if u.hit_flash > 0 else (Color(0.55, 0.35, 0.7) if u.kind == "hostile" else Color.WHITE)
	if not draw_sprite_rim(ename, p, 1.0, Color(0.78, 0.82, 1.0, 0.45), etint):
		_draw_enemy_fallback(u, p, col, r)
	_draw_enemy_status(u, p, r)


func _draw_enemy_fallback(u, p: Vector2, col: Color, r: float) -> void:
	match u.kind:
		"imp":
			draw_colored_polygon(PackedVector2Array([p + Vector2(-r, 2), p + Vector2(r, 2), p + Vector2(0, -r * 2.2 + sin(t * 0.3) * 2.0)]), col.lightened(0.2))
			draw_circle(p, r, col)
		"hostile":
			draw_circle(p, r, col)
			draw_circle(p + Vector2(-4, -2), 2.0, C["danger"])
			draw_circle(p + Vector2(4, -2), 2.0, C["danger"])
		_:
			draw_colored_polygon(PackedVector2Array([p + Vector2(-r * 0.7, -r * 0.5), p + Vector2(-r * 0.3, -r * 0.8), p + Vector2(-r * 0.6, -r * 1.5)]), C["accent"].darkened(0.3))
			draw_colored_polygon(PackedVector2Array([p + Vector2(r * 0.7, -r * 0.5), p + Vector2(r * 0.3, -r * 0.8), p + Vector2(r * 0.6, -r * 1.5)]), C["accent"].darkened(0.3))
			draw_circle(p, r, col)
			draw_circle(p + Vector2(-r * 0.35, -r * 0.1), 1.6, Color.BLACK)
			draw_circle(p + Vector2(r * 0.35 - 3.0, -r * 0.1), 1.6, Color.BLACK)
			if u.kind == "brute":
				draw_line(p + Vector2(-r, 0), p + Vector2(-r - 8, -12), C["clay"].darkened(0.3), 4.0)


func _draw_enemy_status(u, p: Vector2, r: float) -> void:
	if u.burn_t > 0 and t % 6 < 3:
		draw_rect(Rect2(p + Vector2(randf_range(-r, r), -r - 3), Vector2(2, 2)), C["fire"].lightened(0.4))
	if u.slow_t > 0:
		draw_arc(p, r + 2.0, 0, TAU, 16, C["water"], 1.0)
	if u.stun_t > 0:
		for i in 3:
			draw_rect(Rect2(p + Vector2.from_angle(t * 0.15 + i * 2.1) * (r + 4.0) - Vector2(1, r + 4), Vector2(2, 2)), C["accent"])
	if u.hp < u.max_hp:
		var bw: float = r * 2.0 + 4.0
		draw_rect(Rect2(p + Vector2(-bw / 2.0, r + 3.0), Vector2(bw, 2)), Color("3a2430"))
		draw_rect(Rect2(p + Vector2(-bw / 2.0, r + 3.0), Vector2(bw * u.hp / u.max_hp, 2)), C["danger"])


func draw_battle() -> void:
	draw_set_transform(FIELD_OFFSET + shake_offset())
	var ga := tex("field/grass_a")
	var gb := tex("field/grass_b")
	for x in 20:
		for y in 9:
			var g: Texture2D = ga if (x + y) % 2 == 0 else (gb if gb != null else ga)
			if g != null:
				draw_texture_rect(g, Rect2(x * 32, y * 32, 32, 32), false)
			else:
				draw_rect(Rect2(x * 32, y * 32, 32, 32), C["grass_a"] if (x + y) % 2 == 0 else C["grass_b"])
	# 마을
	var vk: float = battle.village_hp / PD.VILLAGE_HP if battle != null else 1.0
	for i in 4:
		var hp_ok := vk > i * 0.25
		var hpos := Vector2(8, 30 + i * 60)
		if draw_sprite("field/house" if hp_ok else "field/house_broken", hpos + Vector2(12, 14)):
			continue
		draw_rect(Rect2(hpos, Vector2(24, 18)), C["village"] if hp_ok else C["village"].darkened(0.6))
		draw_colored_polygon(PackedVector2Array([hpos + Vector2(-3, 0), hpos + Vector2(27, 0), hpos + Vector2(12, -12)]), C["roof"] if hp_ok else C["roof"].darkened(0.6))
	draw_line(Vector2(40, 0), Vector2(40, 260), Color(1, 1, 1, 0.08), 1.0)
	if battle != null:
		for s in shot_lines:
			var sc: Color = s["color"]
			sc.a = float(s["t"]) / 6.0
			draw_line(s["from"], s["to"], sc, 1.5)
		for u in battle.units:
			if u.team == "ally":
				draw_ally_shape(u.pos, u.kind, u.element, u.tier, 1.0, u.hit_flash > 0)
				if u.hp < u.max_hp:
					draw_rect(Rect2(u.pos + Vector2(-9, 12), Vector2(18, 2)), Color("3a2430"))
					draw_rect(Rect2(u.pos + Vector2(-9, 12), Vector2(18 * u.hp / u.max_hp, 2)), C["good"])
			else:
				draw_enemy_shape(u)
	draw_set_transform(Vector2.ZERO)


func draw_battle_hud(title: String) -> void:
	text(Vector2(10, 18), title, C["accent"])
	var vk: float = battle.village_hp / PD.VILLAGE_HP
	text(Vector2(10, 40), "마을", C["dim"])
	draw_rect(Rect2(44, 31, 200, 10), Color("3a2430"))
	draw_rect(Rect2(44, 31, 200 * vk, 10), C["good"] if vk > 0.5 else C["accent"] if vk > 0.25 else C["danger"])
	text(Vector2(250, 40), "%d%%" % roundi(vk * 100.0))
	text(Vector2(330, 40), "처치 %d" % battle.stats["kills"], C["text"], 24 if battle.stats["kills"] >= 30 else 12)
	var left: int = battle.spawn_queue.size()
	text(Vector2(470, 40), "남은 적 %d" % (left + battle._count("enemy")), C["dim"])
	var syn := []
	for e in battle.synergy_t:
		syn.append((PD.GLAZE_NAME if view_style == "kiln" else PD.ELEMENT_NAME)[e])
	if not syn.is_empty():
		text(Vector2(470, 18), "합동: " + ", ".join(syn), C["accent"])
	text(Vector2(0, 345), "아군은 알아서 싸웁니다 · Esc 처음으로", C["dim"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)


func draw_result(win: bool, retry: String) -> void:
	panel(Rect2(120, 90, 400, 220))
	text(Vector2(120, 135), "마을을 지켰다!" if win else "마을이 무너졌다", C["good"] if win else C["danger"], 24, 400.0, HORIZONTAL_ALIGNMENT_CENTER)
	var lines := [
		"남은 마을 체력  %d%%" % roundi(100.0 * battle.village_hp / PD.VILLAGE_HP),
		"처치  %d" % battle.stats["kills"],
		"합동 기술  %d번" % battle.stats["synergies"],
		"%s 특수기  %d번" % ["요변" if view_style == "kiln" else "전설", battle.stats["specials"]],
		"걸린 시간  %.1f초" % (battle.frame / 60.0),
	]
	var y := 170.0
	for l in lines:
		text(Vector2(120, y), l, C["text"], 12, 400.0, HORIZONTAL_ALIGNMENT_CENTER)
		y += 20.0
	button(Rect2(220, 272, 200, 26), retry, "retry")
