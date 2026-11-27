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

const ALLY_SCALE := 2.0          # 전투에서 아군 그림 크기 (32px → 64px)
var glow_layer: Node2D           # 빛 층 (가산 혼합)
var glow_tex: Texture2D          # 가운데가 밝고 가장자리로 사라지는 부드러운 원
var uv := {}                     # 유닛별 움직임 상태 {id: {lunge, dir, kb, hit, squash, walk, prev}}
var arrows: Array = []           # 날아가는 화살·도깨비불 [{from, to, t, life, element, team}]
var swooshes: Array = []         # 공격 궤적 [{pos, dir, t, life, role, element, team}]
var corpses: Array = []          # 쓰러지는 유닛 [{pos, vel, t, life, ...}]
var lights: Array = []           # 순간 섬광 [{pos, radius, color, t, life}]
var hitstop := 0                 # 큰 한 방에 전투를 잠깐 멈춘다 (손맛)
var impacts: Array = []          # 맞는 순간의 십자 섬광 [{pos, t, life, size, color}]


func _ready() -> void:
	font = load("res://assets/fonts/Galmuri11.ttf")
	font.antialiasing = TextServer.FONT_ANTIALIASING_NONE
	font.hinting = TextServer.HINTING_NONE
	font.subpixel_positioning = TextServer.SUBPIXEL_POSITIONING_DISABLED
	var g := GradientTexture2D.new()
	g.width = 64
	g.height = 64
	g.fill = GradientTexture2D.FILL_RADIAL
	g.fill_from = Vector2(0.5, 0.5)
	g.fill_to = Vector2(1.0, 0.5)
	var grad := Gradient.new()
	grad.set_color(0, Color(1, 1, 1, 1))
	grad.set_color(1, Color(1, 1, 1, 0))
	grad.add_point(0.35, Color(1, 1, 1, 0.55))
	g.gradient = grad
	glow_tex = g
	glow_layer = load("res://src/game/glow_layer.gd").new()
	glow_layer.host = self
	add_child(glow_layer)


## 부드러운 빛 한 점 (어느 층에든 그릴 수 있다)
func glow(ci: CanvasItem, pos: Vector2, radius: float, color: Color, squash := 1.0) -> void:
	ci.draw_texture_rect(glow_tex, Rect2(pos - Vector2(radius, radius * squash), Vector2(radius * 2.0, radius * 2.0 * squash)), false, color)


## 빛 층에 그릴 것: 장면마다 덮어써서 더한다 (super 호출)
func draw_glow(ci: CanvasItem) -> void:
	if battle == null:
		return
	var o := FIELD_OFFSET + _shake_now
	for l in lights:
		var c: Color = l["color"]
		c.a *= float(l["t"]) / l["life"]
		glow(ci, l["pos"] + o, l["radius"] * (1.2 - 0.4 * float(l["t"]) / l["life"]), c)
	for w in battle.waves:
		var gc: Color = C[w["element"]].lightened(0.3)
		gc.a = 0.5
		for y in range(10, 260, 26):
			glow(ci, Vector2(w["x"], y) + o, 26.0, gc)
	for im in impacts:
		var kk: float = float(im["t"]) / im["life"]
		var ip: Vector2 = im["pos"] + o
		var ic: Color = im["color"]
		ic.a = kk
		var sz: float = im["size"] * (0.6 + 0.4 * kk)
		var r: float = im["rot"]
		ci.draw_line(ip - Vector2.from_angle(r) * sz, ip + Vector2.from_angle(r) * sz, ic, 2.0)
		ci.draw_line(ip - Vector2.from_angle(r + PI / 2.0) * sz * 0.7, ip + Vector2.from_angle(r + PI / 2.0) * sz * 0.7, ic, 2.0)
		glow(ci, ip, sz * 1.3, Color(ic.r, ic.g, ic.b, 0.6 * kk))
	for w in swooshes:
		if w["team"] == "ally" and w["role"] == "spear":
			var wk: float = float(w["t"]) / w["life"]
			var wc: Color = C.get(w["element"], C["text"]).lightened(0.4)
			wc.a = 0.7 * wk
			var a0: Vector2 = w["pos"] + w["dir"] * 6.0 + o
			var b0: Vector2 = w["to"] + w["dir"] * 10.0 + o
			ci.draw_line(a0, b0, wc, 4.0)
			glow(ci, b0, 12.0, wc)
	for a in arrows:
		var k: float = 1.0 - float(a["t"]) / a["life"]
		var p: Vector2 = a["from"].lerp(a["to"], k) + o
		var col: Color = C.get(a["element"], C["imp"]) if a["team"] == "ally" else Color(0.45, 0.6, 1.0)
		col.a = 0.55
		glow(ci, p, 10.0, col)
	for u in battle.units:
		if u.team == "ally" and u.tier == "legend":
			var lc: Color = C["accent"]
			lc.a = 0.22 + 0.08 * sin(t * 0.12)
			glow(ci, u.pos + o + Vector2(0, -8), 34.0, lc)
		if u.burn_t > 0:
			glow(ci, u.pos + o, 12.0, Color(1.0, 0.45, 0.15, 0.35))


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


var _shake_now := Vector2.ZERO


func tick_fx() -> void:
	t += 1
	shake = maxf(0.0, shake * 0.85 - 0.05)
	_shake_now = shake_offset()
	for id in uv:
		var m: Dictionary = uv[id]
		m["lunge"] = maxi(0, m["lunge"] - 1)
		m["hit"] = maxi(0, m["hit"] - 1)
		m["kb"] *= 0.75
		m["squash"] *= 0.8
	for a in arrows:
		a["t"] -= 1
	arrows = arrows.filter(func(a): return a["t"] > 0)
	for w in swooshes:
		w["t"] -= 1
	swooshes = swooshes.filter(func(w): return w["t"] > 0)
	for c in corpses:
		c["pos"] += c["vel"]
		c["vel"].y += 0.25
		c["t"] -= 1
	corpses = corpses.filter(func(c): return c["t"] > 0)
	for l in lights:
		l["t"] -= 1
	lights = lights.filter(func(l): return l["t"] > 0)
	for im in impacts:
		im["t"] -= 1
	impacts = impacts.filter(func(im): return im["t"] > 0)
	for p in fx:
		p["pos"] += p["vel"]
		p["vel"] *= 0.93
		p["vel"].y += 0.05
		p["t"] -= 1
	fx = fx.filter(func(p): return p["t"] > 0)
	for f in floats:
		f["pos"].y -= 0.9 if f["t"] > f["life"] - 8 else 0.3
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
func _mv(id: int) -> Dictionary:
	if not uv.has(id):
		uv[id] = {"lunge": 0, "dir": Vector2.RIGHT, "kb": Vector2.ZERO, "hit": 0, "squash": 0.0, "walk": 0.0, "prev": Vector2.INF}
	return uv[id]


func light(pos: Vector2, radius: float, color: Color, life := 10) -> void:
	lights.append({"pos": pos, "radius": radius, "color": color, "t": life, "life": life})


func _element_hit_fx(pos: Vector2, element: String, dir: Vector2, big: bool) -> void:
	var sp := pos + FIELD_OFFSET
	match element:
		"fire":
			burst(sp, Color(1.0, 0.75, 0.3), 10 if big else 6, 3.2, 2.0)
			burst(sp, Color(0.95, 0.3, 0.1), 6, 2.0, 3.0)
			light(pos, 26.0 if big else 18.0, Color(1.0, 0.5, 0.15, 0.8), 12)
		"water":
			for i in (10 if big else 6):
				var a := dir.angle() + randf_range(-1.2, 1.2) + PI
				fx.append({"pos": sp, "vel": Vector2.from_angle(a) * randf_range(1.5, 3.5) + Vector2(0, -1.5), "t": 24, "life": 24, "color": Color(0.6, 0.9, 0.95), "size": 2.0})
			light(pos, 18.0, Color(0.4, 0.8, 0.9, 0.6), 10)
		"earth":
			burst(sp, Color(0.55, 0.42, 0.32), 8 if big else 5, 2.4, 3.0)
			for i in 3:
				fx.append({"pos": sp, "vel": Vector2(randf_range(-1.5, 1.5), randf_range(-3.5, -2.0)), "t": 28, "life": 28, "color": Color(0.35, 0.28, 0.22), "size": 3.0})
			light(pos, 14.0, Color(0.8, 0.65, 0.45, 0.4), 8)
		_:
			burst(sp, Color(1, 1, 1), 5, 2.4, 2.0)
			light(pos, 14.0, Color(1, 1, 1, 0.5), 6)


func step_battle() -> void:
	if battle == null or battle.done:
		return
	if hitstop > 0:
		hitstop -= 1
		return
	battle.step()
	# 합동 기술 파도 앞에서 튀는 입자
	for w in battle.waves:
		var wc: Color = C[w["element"]].lightened(0.4)
		for i in 4:
			fx.append({"pos": Vector2(w["x"], randf_range(0, 260)) + FIELD_OFFSET, "vel": Vector2(randf_range(0.5, 2.5), randf_range(-2.0, 0.5)),
				"t": 20, "life": 20, "color": wc, "size": 3.0 if w["element"] == "earth" else 2.0})
	# 걷기: 움직인 만큼 걸음 단계를 올린다
	for u in battle.units:
		var m := _mv(u.id)
		if m["prev"] != Vector2.INF:
			m["walk"] += m["prev"].distance_to(u.pos) * 0.35
		m["prev"] = u.pos
	for e in battle.events:
		var col: Color = C.get(e.get("element", ""), C["text"])
		match e["kind"]:
			"swing":
				var m := _mv(e["unit"])
				m["lunge"] = 10
				m["dir"] = (e["to"] - e["pos"]).normalized()
				swooshes.append({"pos": e["pos"], "to": e["to"], "dir": m["dir"], "t": 9, "life": 9, "role": e.get("role", ""), "element": e["element"], "team": e["team"]})
			"shot":
				var m2 := _mv(e["unit"])
				m2["lunge"] = 8
				m2["dir"] = -(e["to"] - e["from"]).normalized() * 0.5  # 활시위 반동: 살짝 뒤로
				arrows.append({"from": e["from"], "to": e["to"], "t": 7, "life": 7, "element": e["element"], "team": e["team"]})
			"hit":
				var m3 := _mv(e["unit"])
				var d: Vector2 = (e["pos"] - e.get("from", e["pos"])).normalized()
				m3["hit"] = 8
				m3["kb"] = d * (5.0 if e["team"] == "enemy" else 3.0)
				m3["squash"] = 0.25
				var amt: float = e["amount"]
				if e["team"] == "enemy":
					_element_hit_fx(e["pos"], e["element"], d, amt >= 20.0)
					var ic: Color = C.get(e["element"], C["text"]).lightened(0.6) if e["element"] != "" else Color.WHITE
					impacts.append({"pos": e["pos"] - d * 4.0, "t": 6, "life": 6, "size": 16.0 if amt >= 20.0 else 10.0, "color": ic, "rot": randf() * 0.8})
					var big := amt >= 20.0
					floats.append({"pos": e["pos"] + FIELD_OFFSET + Vector2(randf_range(-6, 6), -18), "text": "%d" % ceili(amt),
						"color": col.lightened(0.45) if e["element"] != "" else C["text"], "size": 24 if big else 12, "t": 36, "life": 36, "pop": true})
					if big:
						hitstop = maxi(hitstop, 2)
						shake = maxf(shake, 2.0)
				else:
					light(e["pos"], 14.0, Color(1.0, 0.3, 0.25, 0.5), 8)
			"death":
				var who: String = e.get("who", "")
				corpses.append({"pos": e["pos"], "vel": Vector2(randf_range(1.0, 2.0) * (1.0 if e["team"] == "enemy" else -1.0), -3.5),
					"t": 22, "life": 22, "team": e["team"], "who": who, "element": e.get("element", ""), "id": e["unit"]})
				burst(e["pos"] + FIELD_OFFSET, C["accent"] if e["team"] == "enemy" else C["dim"], 16 if e["big"] else 9, 3.2)
				light(e["pos"], 30.0 if e["big"] else 18.0, Color(1.0, 0.85, 0.5, 0.6), 12)
				if e["big"]:
					shake = maxf(shake, 6.0)
					hitstop = maxi(hitstop, 4)
			"special":
				shake = maxf(shake, 7.0)
				hitstop = maxi(hitstop, 5)
				burst(e["pos"] + FIELD_OFFSET, col.lightened(0.3), 30, 4.5, 3.0)
				light(e["pos"], 80.0, Color(col.r, col.g, col.b, 0.9), 22)
				light(e["pos"], 40.0, Color(1, 0.95, 0.7, 0.8), 14)
				floats.append({"pos": e["pos"] + FIELD_OFFSET + Vector2(-20, -40), "text": "%s!" % ("요변" if view_style == "kiln" else "전설"),
					"color": C["accent"], "size": 24, "t": 44, "life": 44, "pop": true})
			"synergy":
				shake = maxf(shake, 10.0)
				hitstop = maxi(hitstop, 8)
				do_flash(col, 22)
				show_banner(e["name"] + "!", "%s %d — 합동 기술" % [(PD.GLAZE_NAME if view_style == "kiln" else PD.ELEMENT_NAME)[e["element"]], e["count"]], col, 70)
				for u in battle.units:
					if u.team == "enemy":
						light(u.pos, 26.0, Color(col.r, col.g, col.b, 0.8), 18)
						_element_hit_fx(u.pos, e["element"], Vector2.LEFT, true)
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
		c2.a = minf(1.0, float(f["t"]) / 12.0)
		var age: int = f["life"] - f["t"]
		var pop: float = 1.0 + (0.6 * (1.0 - age / 6.0) if f.get("pop", false) and age < 6 else 0.0)
		draw_set_transform(f["pos"], 0.0, Vector2(pop, pop))
		var ol := Color(0.05, 0.03, 0.06, c2.a)
		for o in [Vector2(-1, 0), Vector2(1, 0), Vector2(0, -1), Vector2(0, 1), Vector2(1, 1)]:
			text(o, f["text"], ol, f["size"])
		text(Vector2.ZERO, f["text"], c2, f["size"])
		draw_set_transform(Vector2.ZERO)
	if not flash.is_empty():
		var fc: Color = flash["color"]
		fc.a = 0.35 * float(flash["t"]) / flash["life"]
		draw_rect(Rect2(Vector2.ZERO, VIEW), fc)
	if not banner.is_empty():
		var k: float = float(banner["t"]) / banner["life"]
		var bc: Color = banner["color"].lightened(0.3)
		bc.a = minf(1.0, k * 3.0)
		var by: float = 150.0 if battle == null else 66.0
		draw_rect(Rect2(0, by, 640, 56), Color(0, 0, 0, 0.45 * minf(1.0, k * 3.0)))
		text(Vector2(0, by + 34), banner["text"], bc, 36, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
		text(Vector2(0, by + 52), banner["sub"], Color(1, 1, 1, bc.a), 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)


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


## 그림 뒤에서 은은하게 번지는 속성 빛 + 발밑 그림자 (어두운 흑유도 바탕에서 떠 보이게, 테두리 없이)
func draw_backlight(pos: Vector2, element: String, scale_k: float, base := Vector2.ZERO) -> void:
	var sh := Color(0, 0, 0, 0.35)
	draw_set_transform(base + pos + Vector2(0, 11) * scale_k, 0.0, Vector2(1.0, 0.28))
	draw_circle(Vector2.ZERO, 9.0 * scale_k, sh)
	draw_set_transform(base)
	var bl: Color = C[element].lightened(0.55)
	bl.a = 0.30
	glow(self, pos + Vector2(0, -3) * scale_k, 15.0 * scale_k, bl)


## 요변·전설: 금빛이 은은하게 번지고 반짝이 셋이 맴돈다 / 상품: 반짝이 하나
func _draw_tier_aura(pos: Vector2, tier: String, scale_k: float) -> void:
	if tier == "legend":
		var gl: Color = C["accent"]
		gl.a = 0.18 + 0.06 * sin(t * 0.1)
		glow(self, pos + Vector2(0, -2) * scale_k, 16.0 * scale_k, gl)
		for i in 3:
			var a := t * 0.05 + i * TAU / 3.0
			var sp := pos + Vector2(cos(a) * 12.0, sin(a) * 5.0 - 4.0) * scale_k
			var tw: float = 0.6 + 0.4 * sin(t * 0.3 + i * 2.0)
			draw_rect(Rect2(sp - Vector2.ONE, Vector2(2, 2)), Color(1.0, 0.92, 0.6, tw))
			if tw > 0.9:
				draw_rect(Rect2(sp - Vector2(3, 0), Vector2(6, 1)), Color(1.0, 0.92, 0.6, 0.5))
				draw_rect(Rect2(sp - Vector2(0, 3), Vector2(1, 6)), Color(1.0, 0.92, 0.6, 0.5))
	elif tier == "fine":
		var sp2 := pos + Vector2(cos(t * 0.06) * 11.0, sin(t * 0.06) * 4.0 - 6.0) * scale_k
		draw_rect(Rect2(sp2, Vector2(2, 2)), Color(1.0, 0.92, 0.6, 0.6 + 0.4 * sin(t * 0.25)))


# ---------------- 병사·괴수·적 그리기 ----------------
func draw_ally_shape(pos: Vector2, role: String, element: String, tier: String, scale_k := 1.0, flash_white := false) -> void:
	var sname := ("kiln/soldier_%s_%s" if view_style == "kiln" else "nest/creature_%s_%s") % [role, element]
	if tex(sname) != null:
		draw_backlight(pos, element, scale_k)
		draw_sprite(sname, pos, scale_k, Color(2.5, 2.5, 2.5) if flash_white else Color.WHITE)
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


func _motion(u) -> Dictionary:
	var m := _mv(u.id)
	var off := Vector2.ZERO
	if m["lunge"] > 0:
		var k: float = float(m["lunge"]) / 10.0
		off += m["dir"] * sin(k * PI) * (12.0 if u.team == "ally" else 7.0)   # 나갔다 돌아오기
	off += m["kb"]
	if m["lunge"] == 0:
		off.y -= absf(sin(m["walk"])) * 2.5                               # 걸을 때 통통
	return {"off": off, "sq": m["squash"], "white": m["hit"] > 4}


## base 변환 위에 유닛 하나를 (위치·찌그러짐 포함) 그린다
func _draw_unit_sprite(name: String, base: Vector2, pos: Vector2, scale_k: float, sq: float, tint: Color, rot := 0.0) -> bool:
	var tx := tex(name)
	if tx == null:
		return false
	var sz: Vector2 = tx.get_size() * scale_k
	draw_set_transform(base + pos, rot, Vector2(1.0 + sq, 1.0 - sq))
	draw_texture_rect(tx, Rect2(Vector2(-sz.x / 2.0, -sz.y * 0.6), sz), false, tint)
	draw_set_transform(base)
	return true


const ENEMY_LOOK := {
	# 종류: [그림, 크기, 물들일 색]  — 큰 도깨비·대장은 도깨비 그림을 키워 쓴다 (전용 그림이 오면 그걸 쓴다)
	"goblin": ["enemy/goblin", 2.0, Color(1, 1, 1)],
	"imp": ["enemy/imp", 2.0, Color(1, 1, 1)],
	"brute": ["enemy/brute", 2.0, Color(1, 1, 1)],
	"chief": ["enemy/chief", 2.0, Color(1, 1, 1)],
}


func _enemy_look(u) -> Array:
	match u.kind:
		"hostile":
			return ["nest/creature_spear_" + (u.element if u.element != "" else "fire"), 1.6, Color(0.55, 0.35, 0.7)]
		"brute":
			if tex("enemy/brute") == null:
				return ["enemy/goblin", 2.6, Color(0.72, 0.68, 0.85)]
		"chief":
			if tex("enemy/chief") == null:
				return ["enemy/goblin", 3.6, Color(1.15, 0.72, 0.62)]
	return ENEMY_LOOK.get(u.kind, ["enemy/goblin", 2.0, Color(1, 1, 1)])


func draw_enemy_shape(u, base := Vector2.ZERO) -> void:
	var mo := _motion(u)
	var p: Vector2 = u.pos + mo["off"]
	var look := _enemy_look(u)
	var tx := tex(look[0])
	var sc: float = look[1]
	var h: float = (tx.get_height() if tx != null else 20.0) * sc
	var col: Color = C.get(u.kind, C["goblin"])
	if mo["white"]:
		col = Color.WHITE
	var r: float = u.radius
	draw_set_transform(base + u.pos + Vector2(0, h * 0.36), 0.0, Vector2(1.0, 0.3))
	draw_circle(Vector2.ZERO, h * 0.32, Color(0, 0, 0, 0.35))
	draw_set_transform(base)
	var etint: Color = Color(2.5, 2.5, 2.5) if mo["white"] else look[2]
	if tx != null:
		_draw_unit_sprite(look[0], base, p, sc, mo["sq"], etint)
		if u.kind == "brute" and tex("enemy/brute") == null:
			draw_line(p + Vector2(-h * 0.3, -h * 0.05), p + Vector2(-h * 0.5, -h * 0.45), Color("5a4030"), 5.0)
			draw_circle(p + Vector2(-h * 0.5, -h * 0.45), 5.0, Color("6b4c38"))
		if u.kind == "chief" and tex("enemy/chief") == null:
			var top := p + Vector2(0, -h * 0.62)
			draw_colored_polygon(PackedVector2Array([top + Vector2(-12, 6), top + Vector2(12, 6), top + Vector2(12, -2), top + Vector2(6, 3), top + Vector2(0, -6), top + Vector2(-6, 3), top + Vector2(-12, -2)]), C["accent"])
	else:
		_draw_enemy_fallback(u, p, col, r * 1.6 * (1.0 + mo["sq"]))
	_draw_enemy_status(u, p, r, h)


func _draw_enemy_fallback(u, p: Vector2, col: Color, r: float) -> void:
	match u.kind:
		"imp":
			var fl := sin(t * 0.35) * 2.0
			draw_colored_polygon(PackedVector2Array([p + Vector2(-r, 2), p + Vector2(r, 2), p + Vector2(fl, -r * 2.4)]), Color(0.35, 0.5, 1.0, 0.8))
			draw_colored_polygon(PackedVector2Array([p + Vector2(-r * 0.6, 2), p + Vector2(r * 0.6, 2), p + Vector2(fl * 0.5, -r * 1.6)]), Color(0.7, 0.85, 1.0))
			draw_circle(p, r * 0.8, Color(0.55, 0.7, 1.0))
			draw_circle(p + Vector2(-3, -1), 1.5, Color(1, 0.9, 0.3))
			draw_circle(p + Vector2(3, -1), 1.5, Color(1, 0.9, 0.3))
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


## 머리 위 상태 아이콘: 불꽃 = 화상(불), 물방울 = 느려짐(물), 별 = 기절(땅)
func _draw_enemy_status(u, p: Vector2, r: float, h := 20.0) -> void:
	var top := p + Vector2(0, -h * 0.62 - 8.0)
	var icons: Array = []
	if u.burn_t > 0:
		icons.append("burn")
	if u.slow_t > 0:
		icons.append("slow")
	if u.stun_t > 0:
		icons.append("stun")
	for i in icons.size():
		var c := top + Vector2((i - (icons.size() - 1) / 2.0) * 10.0, 0)
		match icons[i]:
			"burn":
				var fl := sin(t * 0.4) * 1.0
				draw_colored_polygon(PackedVector2Array([c + Vector2(-3, 3), c + Vector2(3, 3), c + Vector2(fl, -5)]), C["fire"].lightened(0.2))
				draw_colored_polygon(PackedVector2Array([c + Vector2(-1.5, 3), c + Vector2(1.5, 3), c + Vector2(fl * 0.5, -1)]), Color(1, 0.9, 0.5))
			"slow":
				draw_circle(c + Vector2(0, 1), 3.0, C["water"])
				draw_colored_polygon(PackedVector2Array([c + Vector2(-2.6, 0), c + Vector2(2.6, 0), c + Vector2(0, -5)]), C["water"])
				draw_rect(Rect2(c + Vector2(-1, 0), Vector2(1, 1)), Color.WHITE)
			"stun":
				for k in 3:
					var a := t * 0.15 + k * 2.1
					draw_rect(Rect2(c + Vector2(cos(a) * 6.0, sin(a) * 2.0) - Vector2.ONE, Vector2(2, 2)), C["accent"])
	if u.hp < u.max_hp:
		var bw: float = maxf(r * 2.0 + 8.0, h * 0.6)
		var by: float = p.y + h * 0.42
		draw_rect(Rect2(Vector2(p.x - bw / 2.0, by), Vector2(bw, 3)), Color("3a2430"))
		draw_rect(Rect2(Vector2(p.x - bw / 2.0, by), Vector2(bw * u.hp / u.max_hp, 3)), C["danger"])


func draw_battle() -> void:
	var base := FIELD_OFFSET + _shake_now
	draw_set_transform(base)
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
		if not hp_ok and draw_sprite("field/house", hpos + Vector2(12, 14), 1.0, Color(0.35, 0.3, 0.3)):
			draw_line(hpos + Vector2(6, 2), hpos + Vector2(14, 12), Color(0.1, 0.08, 0.08), 1.0)
			continue
		draw_rect(Rect2(hpos, Vector2(24, 18)), C["village"] if hp_ok else C["village"].darkened(0.6))
		draw_colored_polygon(PackedVector2Array([hpos + Vector2(-3, 0), hpos + Vector2(27, 0), hpos + Vector2(12, -12)]), C["roof"] if hp_ok else C["roof"].darkened(0.6))
	draw_line(Vector2(40, 0), Vector2(40, 260), Color(1, 1, 1, 0.08), 1.0)
	if battle == null:
		draw_set_transform(Vector2.ZERO)
		return
	# 위에서 아래 순서로 그려 앞뒤가 자연스럽게
	var order: Array = battle.units.duplicate()
	order.sort_custom(func(a, b): return a.pos.y < b.pos.y)
	for u in order:
		if u.team == "ally":
			_draw_ally_in_battle(u, base)
		else:
			draw_enemy_shape(u, base)
	_draw_waves()
	_draw_corpses(base)
	_draw_swooshes()
	_draw_arrows()
	draw_set_transform(Vector2.ZERO)


func _draw_ally_in_battle(u, base: Vector2) -> void:
	var mo := _motion(u)
	var p: Vector2 = u.pos + mo["off"]
	var sname := ("kiln/soldier_%s_%s" if view_style == "kiln" else "nest/creature_%s_%s") % [u.kind, u.element]
	if tex(sname) != null:
		draw_backlight(u.pos, u.element, ALLY_SCALE * 0.8, base)
		_draw_unit_sprite(sname, base, p, ALLY_SCALE, mo["sq"], Color(2.5, 2.5, 2.5) if mo["white"] else Color.WHITE)
		_draw_tier_aura(p + Vector2(0, -6), u.tier, ALLY_SCALE * 0.9)
	else:
		draw_ally_shape(p, u.kind, u.element, u.tier, 1.6, mo["white"])
	if u.hp < u.max_hp:
		draw_rect(Rect2(u.pos + Vector2(-14, 26), Vector2(28, 3)), Color("3a2430"))
		draw_rect(Rect2(u.pos + Vector2(-14, 26), Vector2(28 * u.hp / u.max_hp, 3)), C["good"])


## 합동 기술 파도: 불의 벽 / 물결 / 갈라지는 땅
func _draw_waves() -> void:
	for w in battle.waves:
		var x: float = w["x"]
		var col: Color = C[w["element"]]
		match w["element"]:
			"fire":
				for y in range(0, 260, 10):
					var hgt := 10.0 + 6.0 * sin(t * 0.5 + y * 0.3)
					draw_colored_polygon(PackedVector2Array([Vector2(x - 8, y + 10), Vector2(x + 4, y + 10), Vector2(x - 2 + sin(y + t * 0.4) * 3.0, y + 10 - hgt)]), Color(1.0, 0.55, 0.15, 0.85))
				var tail := col
				tail.a = 0.25
				draw_rect(Rect2(x - 60, 0, 52, 260), tail)
			"water":
				var tail2 := col
				tail2.a = 0.3
				draw_rect(Rect2(x - 70, 0, 66, 260), tail2)
				for y in range(0, 260, 18):
					draw_arc(Vector2(x - 4, y + 9), 9.0, -PI / 2.0, PI / 2.0, 8, Color(0.92, 0.98, 1.0, 0.9), 3.0)
			"earth":
				var pts := PackedVector2Array()
				for y in range(0, 270, 12):
					pts.append(Vector2(x + (6.0 if (y / 12) % 2 == 0 else -6.0), y))
				draw_polyline(pts, Color(0.2, 0.14, 0.1), 4.0)
				draw_polyline(pts, Color(0.85, 0.65, 0.4, 0.8), 1.0)


func _draw_corpses(base: Vector2) -> void:
	for c in corpses:
		var k: float = float(c["t"]) / c["life"]
		var tint := Color(1, 1, 1, k)
		var rot: float = (1.0 - k) * (1.2 if c["team"] == "enemy" else -1.2)
		var name: String = ("enemy/" + c["who"]) if c["team"] == "enemy" else (("kiln/soldier_%s_%s" if view_style == "kiln" else "nest/creature_%s_%s") % [c["who"], c["element"]])
		if not _draw_unit_sprite(name, base, c["pos"], 1.0 if c["team"] == "enemy" else ALLY_SCALE, 0.0, tint, rot):
			draw_circle(c["pos"], 8.0 * k, Color(C["dim"].r, C["dim"].g, C["dim"].b, k))


## 공격 궤적: 창 찌르기는 빛줄기, 방패는 충격파, 도깨비는 할퀴기
func _draw_swooshes() -> void:
	for w in swooshes:
		var k: float = float(w["t"]) / w["life"]
		var d: Vector2 = w["dir"]
		var col: Color = C.get(w["element"], C["text"]).lightened(0.5) if w["team"] == "ally" else Color(0.85, 0.85, 1.0)
		col.a = k
		if w["team"] == "ally" and w["role"] == "spear":
			var a: Vector2 = w["pos"] + d * 6.0
			var b: Vector2 = w["to"] + d * 14.0
			var n := d.orthogonal() * 6.0 * k
			draw_colored_polygon(PackedVector2Array([a + n, b, a - n]), col)
			draw_line(a, b, Color(1, 1, 1, k), 1.0)
		elif w["team"] == "ally" and w["role"] == "shield":
			draw_arc(w["pos"] + d * 14.0, 10.0 + (1.0 - k) * 14.0, d.angle() - 1.0, d.angle() + 1.0, 12, col, 3.0)
		else:
			for i in 3:
				var off := d.orthogonal() * (i - 1) * 4.0
				var c0: Vector2 = w["to"] + off - d * 6.0
				draw_line(c0, c0 + d * 9.0 + d.orthogonal() * 3.0, col, 2.0)


func _draw_arrows() -> void:
	for a in arrows:
		var k: float = 1.0 - float(a["t"]) / a["life"]
		var dir: Vector2 = (a["to"] - a["from"]).normalized()
		var p: Vector2 = a["from"].lerp(a["to"], k)
		if a["team"] == "ally":
			var tip: Color = C.get(a["element"], C["text"]).lightened(0.4)
			draw_line(p - dir * 12.0, p, Color(0.85, 0.75, 0.6), 2.0)
			draw_colored_polygon(PackedVector2Array([p + dir * 4.0, p + dir.orthogonal() * 2.5, p - dir.orthogonal() * 2.5]), tip)
			var tr := tip
			tr.a = 0.35
			draw_line(p - dir * 24.0, p - dir * 12.0, tr, 1.0)
		else:
			draw_circle(p, 4.0, Color(0.55, 0.7, 1.0))
			draw_circle(p, 2.0, Color(0.9, 0.95, 1.0))


func draw_battle_hud(title: String) -> void:
	text(Vector2(10, 18), title, C["accent"])
	var vk: float = battle.village_hp / PD.VILLAGE_HP
	text(Vector2(10, 40), "마을", C["dim"])
	draw_rect(Rect2(44, 31, 200, 10), Color("3a2430"))
	draw_rect(Rect2(44, 31, 200 * vk, 10), C["good"] if vk > 0.5 else C["accent"] if vk > 0.25 else C["danger"])
	text(Vector2(250, 40), "%d%%" % roundi(vk * 100.0))
	text(Vector2(300, 40), "처치 %d" % battle.stats["kills"], C["text"], 24 if battle.stats["kills"] >= 30 else 12)
	var left: int = battle.spawn_queue.size()
	text(Vector2(420, 40), "남은 적 %d" % (left + battle._count("enemy")), C["dim"])
	_draw_synergy_cooldowns()
	text(Vector2(0, 345), "아군은 알아서 싸웁니다 · Esc 처음으로", C["dim"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)


## 합동 기술마다: 유약 색 원이 차오르고, 다 차면 발동. 남은 초를 함께 보여 준다
func _draw_synergy_cooldowns() -> void:
	var i := 0
	for e in battle.synergy_t:
		var left: int = battle.synergy_t[e]
		var total: float = PD.SYNERGY_FIRST if battle.stats["synergies"] == 0 else PD.SYNERGY_EVERY
		var k: float = clampf(1.0 - left / total, 0.0, 1.0)
		var c := Vector2(600 - i * 56, 22)
		var col: Color = C[e].lightened(0.3)
		draw_circle(c, 14.0, Color(0.08, 0.07, 0.1))
		draw_arc(c, 12.0, -PI / 2.0, -PI / 2.0 + TAU * k, 32, col, 4.0)
		if left < 30:
			draw_circle(c, 15.0 + 2.0 * sin(t * 0.6), Color(col.r, col.g, col.b, 0.35))
		text(c + Vector2(-20, 5), "%d" % ceili(left / 60.0), C["text"], 12, 40.0, HORIZONTAL_ALIGNMENT_CENTER)
		text(c + Vector2(-40, 30), PD.SYNERGY_NAME[e], col, 12, 80.0, HORIZONTAL_ALIGNMENT_CENTER)
		i += 1


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
