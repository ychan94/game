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
var font_bold: FontFile          # 피해 숫자용 굵은 글꼴
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
var wave_parts: Array = []       # 합동 기술 파도 입자 [{pos, vel, t, life, size, element}]
var anims: Array = []            # 이펙트 애니메이션 [{name, pos, frame_t, scale, add, flip}]
const FX_FPS := 20               # 이펙트 그림 한 장면당 3프레임 (초당 20장)


func _ready() -> void:
	font = load("res://assets/fonts/Galmuri11.ttf")
	font.antialiasing = TextServer.FONT_ANTIALIASING_NONE
	font.hinting = TextServer.HINTING_NONE
	font.subpixel_positioning = TextServer.SUBPIXEL_POSITIONING_DISABLED
	font_bold = load("res://assets/fonts/Galmuri11-Bold.ttf")
	font_bold.antialiasing = TextServer.FONT_ANTIALIASING_NONE
	font_bold.hinting = TextServer.HINTING_NONE
	font_bold.subpixel_positioning = TextServer.SUBPIXEL_POSITIONING_DISABLED
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
	# 고해상도로 그리기: 픽셀 그림은 또렷하게(가까운 점), 빛·안개·연기는 부드럽게 (층마다 따로)
	# project.godot 대신 실행 중에 바꾼다 (컴퓨터 쪽 편집기 변경과 겹치지 않게)
	var win := get_window()
	if win != null:
		win.content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS
		win.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_KEEP
	var Layer = load("res://src/game/glow_layer.gd")
	for mode in ["bg", "back", "glow", "front"]:
		var l: Node2D = Layer.new()
		l.setup(self, mode)
		add_child(l)
		if mode == "glow":
			glow_layer = l
	_init_atmosphere()


## 부드러운 빛 한 점 (어느 층에든 그릴 수 있다)
func glow(ci: CanvasItem, pos: Vector2, radius: float, color: Color, squash := 1.0) -> void:
	ci.draw_texture_rect(glow_tex, Rect2(pos - Vector2(radius, radius * squash), Vector2(radius * 2.0, radius * 2.0 * squash)), false, color)


## 이펙트 그림 (assets/sprites/fx/<이름>.png): 가로로 늘어선 정사각형 장면들. 있으면 재생하고 true, 없으면 false
func fx_frames(name: String) -> int:
	var tx := tex("fx/" + name)
	if tx == null:
		return 0
	return maxi(1, int(tx.get_width() / tx.get_height()))


func play_fx(name: String, pos: Vector2, scale_k := 1.0, add := true, flip := false) -> bool:
	if fx_frames(name) == 0:
		return false
	anims.append({"name": name, "pos": pos, "frame_t": 0, "scale": scale_k, "add": add, "flip": flip})
	return true


func _draw_anims(ci: CanvasItem, o: Vector2, add: bool) -> void:
	for a in anims:
		if a["add"] != add:
			continue
		var tx := tex("fx/" + a["name"])
		var n := fx_frames(a["name"])
		var f: int = mini(n - 1, a["frame_t"] * FX_FPS / 60)
		var fs: float = tx.get_height()
		var sz: Vector2 = Vector2(fs, fs) * a["scale"]
		var dst := Rect2(o + a["pos"] - sz / 2.0, sz)
		if a["flip"]:
			dst = Rect2(dst.position + Vector2(sz.x, 0), Vector2(-sz.x, sz.y))
		ci.draw_texture_rect_region(tx, dst, Rect2(f * fs, 0, fs, fs))


## 층마다 그릴 것
func draw_layer(ci: CanvasItem, mode: String) -> void:
	match mode:
		"bg":
			draw_background(ci)
		"back":
			draw_back(ci)
		"glow":
			draw_glow(ci)
		"front":
			draw_front(ci)


## 빛 층에 그릴 것: 장면마다 덮어써서 더한다 (super 호출)
func draw_glow(ci: CanvasItem) -> void:
	if battle == null:
		return
	var o := FIELD_OFFSET + _shake_now
	_draw_ambient_lights(ci, o)
	_draw_anims(ci, o, true)
	for l in lights:
		var c: Color = l["color"]
		c.a *= float(l["t"]) / l["life"]
		glow(ci, l["pos"] + o, l["radius"] * (1.2 - 0.4 * float(l["t"]) / l["life"]), c)
	for w in battle.waves:
		var gc: Color = C[w["element"]].lightened(0.3)
		gc.a = 0.22
		for y in range(10, 260, 30):
			glow(ci, Vector2(w["x"], y) + o, 34.0, gc)
	for wp in wave_parts:
		var age: float = float(wp["t"]) / wp["life"]
		var col: Color
		match wp["element"]:
			"fire":
				col = Color(1.0, 0.95, 0.75).lerp(Color(1.0, 0.55, 0.15), minf(1.0, age * 2.0)).lerp(Color(0.7, 0.12, 0.04), maxf(0.0, age * 2.0 - 1.0))
				col.a = (1.0 - age) * 0.8
			"water":
				col = Color(0.95, 1.0, 1.0).lerp(Color(0.4, 0.85, 0.8), age)
				col.a = (1.0 - age) * 0.6
			_:
				col = Color(0.75, 0.6, 0.42, (1.0 - age) * 0.35)
		glow(ci, wp["pos"] + o, wp["size"] * (1.0 - age * 0.4), col)
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
		if u.team == "ally" and u.tier == "legend" and fx_frames("legend_aura") > 0:
			var at := tex("fx/legend_aura")
			var an := fx_frames("legend_aura")
			var afs: float = at.get_height()
			var asz := Vector2(afs, afs) * 1.6
			ci.draw_texture_rect_region(at, Rect2(o + u.pos + Vector2(0, 14) - asz / 2.0, asz), Rect2((t / 3 % an) * afs, 0, afs, afs))
		if u.team == "ally" and u.tier == "legend":
			var lc: Color = C["accent"]
			lc.a = 0.22 + 0.08 * sin(t * 0.12)
			glow(ci, u.pos + o + Vector2(0, -8), 34.0, lc)
		if u.burn_t > 0:
			glow(ci, u.pos + o, 12.0, Color(1.0, 0.45, 0.15, 0.35))



# ---------------- 전장 분위기 (HD-2D: 캐릭터는 픽셀, 배경·빛·공기는 실감 나게) ----------------
var ground_tex: Texture2D        # 바닥 한 장 (Codex 배경 그림 field/battlefield 가 있으면 그걸 쓴다)
var vignette_tex: Texture2D      # 가장자리 어둡게
var fireflies: Array = []
var fogs: Array = []


func _init_atmosphere() -> void:
	# 가장자리로 갈수록 어두워지는 원
	var vg := GradientTexture2D.new()
	vg.width = 128
	vg.height = 128
	vg.fill = GradientTexture2D.FILL_RADIAL
	vg.fill_from = Vector2(0.5, 0.5)
	vg.fill_to = Vector2(1.05, 0.5)
	var vgrad := Gradient.new()
	vgrad.set_color(0, Color(0, 0, 0, 0))
	vgrad.set_color(1, Color(0, 0, 0, 0.75))
	vgrad.add_point(0.55, Color(0, 0, 0, 0.0))
	vg.gradient = vgrad
	vignette_tex = vg
	for i in 16:
		fireflies.append({"pos": Vector2(randf_range(60, 620), randf_range(10, 250)), "vel": Vector2.ZERO, "ph": randf() * TAU})
	for i in 6:
		fogs.append({"pos": Vector2(randf_range(-100, 640), randf_range(150, 250)), "speed": randf_range(0.08, 0.2), "r": randf_range(80, 140)})


## 바닥 한 장을 코드로 만든다: 밤 풀밭 + 마을로 이어지는 흙길 + 돌 + 풀 포기 (반 해상도 → 2배)
func _make_ground() -> Texture2D:
	var w := 320
	var h := 130
	var img := Image.create(w, h, false, Image.FORMAT_RGBA8)
	var nz := FastNoiseLite.new()
	nz.seed = 7
	nz.frequency = 0.06
	var nz2 := FastNoiseLite.new()
	nz2.seed = 11
	nz2.frequency = 0.25
	var grass := [Color("1b2a22"), Color("203227"), Color("26392b"), Color("2c4230")]
	var dirt := [Color("3a3026"), Color("44382b"), Color("4e4131"), Color("5a4b38")]
	var rng := RandomNumberGenerator.new()
	rng.seed = 3
	for y in h:
		for x in w:
			var n := (nz.get_noise_2d(x, y) + 1.0) * 0.5
			var fine := (nz2.get_noise_2d(x, y) + 1.0) * 0.5
			var path_y := 66.0 + sin(x * 0.025) * 9.0 + sin(x * 0.07) * 3.0
			var path_w := 20.0 + 8.0 * (1.0 - x / float(w)) + nz.get_noise_2d(x * 3.0, 99.0) * 4.0
			var d := absf(y - path_y)
			var c: Color
			if d < path_w:
				c = dirt[clampi(int((n * 0.6 + fine * 0.4) * 4.0), 0, 3)]
				if d > path_w - 3.0:
					c = c.lerp(grass[1], 0.5)   # 길 가장자리
				if fine > 0.82:
					c = Color("6a5a45")          # 자갈
			else:
				c = grass[clampi(int((n * 0.7 + fine * 0.3) * 4.0), 0, 3)]
				if fine > 0.86 and n > 0.4:
					c = Color("3a5338")          # 풀 포기 밝은 끝
			# 바퀴 자국 두 줄 (길 안쪽)
			if d < path_w - 4.0 and (absf(y - path_y - 5.0) < 0.8 or absf(y - path_y + 5.0) < 0.8) and fine > 0.3:
				c = c.darkened(0.25)
			# 마을 마당 (담장 안쪽): 다져진 흙 + 듬성한 풀
			var yard: float = PD.VILLAGE_LINE / 2.0 - 4.0
			if x < yard:
				var yc: Color = dirt[1].lerp(dirt[2], fine)
				c = yc if n < 0.62 else c.lerp(yc, 0.5)
			elif x < yard + 6:
				c = c.lerp(dirt[1], 0.4 * (1.0 - (x - yard) / 6.0))
			# 숲 가장자리: 위·아래 끝은 어두운 덤불
			var edge_top := 9.0 + nz.get_noise_2d(x * 2.0, 5.0) * 6.0 + sin(x * 0.2) * 2.0
			var edge_bot := h - 8.0 - nz.get_noise_2d(x * 2.0, 55.0) * 6.0 - sin(x * 0.17 + 1.0) * 2.0
			if x >= yard and (y < edge_top or y > edge_bot):
				var dd := minf(absf(y - edge_top), absf(y - edge_bot))
				c = Color("101a15") if dd > 2.0 else Color("17251c")
				if fine > 0.7 and dd < 4.0:
					c = Color("24382a")
			img.set_pixel(x, y, c)
	# 큰 바위 몇 개 (길에서 비켜서)
	for bpos in [Vector2(120, 24), Vector2(210, 104), Vector2(268, 30), Vector2(170, 112), Vector2(300, 98)]:
		for yy in range(-4, 4):
			for xx in range(-6, 7):
				if xx * xx / 36.0 + yy * yy / 16.0 <= 1.0:
					var cc := Color("5a5852") if yy < -1 else (Color("47453f") if yy < 2 else Color("33322e"))
					if xx * xx / 36.0 + yy * yy / 16.0 > 0.75:
						cc = Color("2a2925")
					img.set_pixel(clampi(int(bpos.x) + xx, 0, w - 1), clampi(int(bpos.y) + yy, 0, h - 1), cc)
	# 돌 몇 개
	for i in 26:
		var sx := rng.randi_range(30, w - 4)
		var sy := rng.randi_range(2, h - 4)
		img.set_pixel(sx, sy, Color("5c5a55"))
		img.set_pixel(sx + 1, sy, Color("4a4844"))
		img.set_pixel(sx, sy + 1, Color("3a3936"))
	return ImageTexture.create_from_image(img)


func _tick_atmosphere() -> void:
	for f in fireflies:
		f["ph"] += 0.05
		f["vel"] = (f["vel"] + Vector2(randf_range(-0.05, 0.05), randf_range(-0.05, 0.05))).limit_length(0.5)
		f["pos"] += f["vel"]
		f["pos"].x = wrapf(f["pos"].x, 50, 630)
		f["pos"].y = wrapf(f["pos"].y, 5, 255)
	for g in fogs:
		g["pos"].x += g["speed"]
		if g["pos"].x - g["r"] > 640:
			g["pos"].x = -g["r"]


## 마을: 담장(규칙의 마을 선) 왼쪽에 집 6채를 두 줄로 엇갈려 모아 세운다 (2배 크기)
const HOUSE_SCALE := 2.0
const HOUSES := [Vector2(30, 34), Vector2(78, 70), Vector2(28, 110), Vector2(80, 150), Vector2(30, 190), Vector2(78, 226)]
const HOUSE_BREAK_ORDER := [3, 0, 5, 2, 4, 1]   # 마을 체력이 줄 때 이 순서로 불탄다


func _house_pos(i: int) -> Vector2:
	return HOUSES[i]


## 집 상태: 0 멀쩡 · 1 불붙음(연기·불길) · 2 무너짐
func _house_state(i: int) -> int:
	var vk: float = clampf(battle.village_hp / PD.VILLAGE_HP, 0.0, 1.0) if battle != null else 1.0
	var n := HOUSES.size()
	var rank: int = HOUSE_BREAK_ORDER.find(i)
	var gone := 1.0 - float(rank + 1) / float(n + 1)
	if vk <= gone:
		return 2
	if vk <= gone + 0.5 / float(n + 1):
		return 1
	return 0


## 화면 배경색: 전장이 보일 때는 바닥층이 그리므로 기본층은 칠하지 않는다
func draw_screen_bg() -> void:
	if battle == null:
		draw_rect(Rect2(Vector2.ZERO, VIEW), C["bg"])


## 바닥층: 화면 배경색 + 전장 한 장 + 마을 돌담
func draw_background(ci: CanvasItem) -> void:
	if battle == null:
		return
	ci.draw_rect(Rect2(Vector2.ZERO, VIEW), C["bg"])
	var o := FIELD_OFFSET + _shake_now
	var bf := tex("field/battlefield")
	if bf != null:
		ci.draw_texture_rect(bf, Rect2(o, Vector2(640, 260)), false)
	else:
		if ground_tex == null:
			ground_tex = _make_ground()
		ci.draw_texture_rect(ground_tex, Rect2(o, Vector2(640, 260)), false)
	# 마을 돌담 (규칙의 마을 선 VILLAGE_LINE). 가운데 길 자리에 문
	var wx: float = PD.VILLAGE_LINE - 8.0
	for y in range(0, 260, 8):
		if y >= 112 and y < 148:
			continue
		var sx: float = wx + (2.0 if (y / 8) % 2 == 0 else 0.0)
		ci.draw_rect(Rect2(o + Vector2(sx, y + 2), Vector2(9, 8)), Color(0, 0, 0, 0.35))
		ci.draw_rect(Rect2(o + Vector2(sx, y), Vector2(8, 7)), Color("4b4842"))
		ci.draw_rect(Rect2(o + Vector2(sx, y), Vector2(8, 1)), Color("6f6a60"))
		ci.draw_rect(Rect2(o + Vector2(sx + 3, y + 3), Vector2(1, 1)), Color("3a3833"))
	# 문기둥 (장승 자리)
	for gy in [104.0, 148.0]:
		ci.draw_rect(Rect2(o + Vector2(wx - 1, gy), Vector2(10, 12)), Color("3b2c22"))
		ci.draw_rect(Rect2(o + Vector2(wx - 1, gy), Vector2(10, 2)), Color("5d4636"))


## 뒷층(부드럽게, 캐릭터 뒤): 달빛, 낮은 안개, 그림자, 병사 뒷빛
func draw_back(ci: CanvasItem) -> void:
	if battle == null:
		return
	var o := FIELD_OFFSET + _shake_now
	glow(ci, o + Vector2(560, -40), 260.0, Color(0.55, 0.65, 0.95, 0.10))   # 달빛
	for g in fogs:
		glow(ci, o + g["pos"], g["r"], Color(0.7, 0.78, 0.9, 0.07), 0.35)
	for i in HOUSES.size():
		if _house_state(i) == 0:
			continue
		for j in 6:
			var ph: float = fmod(t * 0.008 + j / 6.0 + i * 0.17, 1.0)
			var sp: Vector2 = o + _house_pos(i) + Vector2(sin(ph * 5.0 + i) * 8.0 + ph * 40.0, -18.0 - ph * 120.0)
			glow(ci, sp, 14.0 + ph * 34.0, Color(0.16, 0.14, 0.15, 0.45 * (1.0 - ph)))
	for u in battle.units:
		var mo := _motion(u)
		if u.team == "ally":
			glow(ci, o + u.pos + Vector2(0, 22), 20.0, Color(0, 0, 0, 0.55), 0.3)
			var bl: Color = C[u.element].lightened(0.55)
			bl.a = 0.28
			glow(ci, o + u.pos + mo["off"] + Vector2(0, -6), 30.0, bl)
		else:
			var look := _enemy_look(u)
			var tx := tex(look[0])
			var h: float = (tx.get_height() if tx != null else 20.0) * look[1]
			glow(ci, o + u.pos + Vector2(0, h * 0.36), h * 0.38, Color(0, 0, 0, 0.5), 0.3)


## 앞층(부드럽게, 캐릭터 앞): 앞 안개 자락, 밤 색감, 가장자리 어둡게
func draw_front(ci: CanvasItem) -> void:
	if battle == null:
		return
	var o := FIELD_OFFSET + _shake_now
	for i in 3:
		var fx_x: float = fmod(t * (0.25 + i * 0.1) + i * 230.0, 900.0) - 130.0
		glow(ci, o + Vector2(fx_x, 245 - i * 8), 120.0, Color(0.75, 0.82, 0.95, 0.06), 0.25)
	ci.draw_rect(Rect2(o, Vector2(640, 260)), Color(0.08, 0.12, 0.3, 0.12))   # 푸른 밤
	ci.draw_texture_rect(vignette_tex, Rect2(o + Vector2(-40, -30), Vector2(720, 320)), false)


## 빛층에 더하는 것: 마을 등불, 반딧불
func _draw_ambient_lights(ci: CanvasItem, o: Vector2) -> void:
	for i in HOUSES.size():
		var st := _house_state(i)
		var hp: Vector2 = _house_pos(i) + o
		var fl := 0.85 + 0.15 * sin(t * 0.21 + i * 1.7) + 0.06 * sin(t * 0.67 + i)
		if st == 0:
			# 창호지 너머 등불
			glow(ci, hp + Vector2(4, 8), 44.0 * fl, Color(1.0, 0.62, 0.25, 0.22 * fl))
			glow(ci, hp + Vector2(4, 8), 9.0, Color(1.0, 0.8, 0.45, 0.55 * fl))
		else:
			# 불길: 지붕 위로 넘실대는 주황 빛
			var k := 1.0 if st == 1 else 0.55
			var fl2 := 0.75 + 0.25 * sin(t * 0.5 + i * 2.3) + 0.12 * sin(t * 1.3 + i)
			glow(ci, hp + Vector2(0, -10), 70.0 * fl2 * k, Color(1.0, 0.38, 0.1, 0.30 * k))
			for j in 4:
				var ph: float = fmod(t * 0.05 + j * 0.25 + i * 0.13, 1.0)
				var fp := hp + Vector2(-14 + j * 9 + sin(t * 0.3 + j) * 3.0, -8 - ph * 26.0)
				glow(ci, fp, (11.0 - ph * 8.0) * k, Color(1.0, 0.55 + 0.3 * (1.0 - ph), 0.15, (1.0 - ph) * 0.8 * k))
	for f in fireflies:
		var a: float = maxf(0.0, sin(f["ph"]))
		if a > 0.05:
			glow(ci, o + f["pos"], 6.0, Color(0.75, 1.0, 0.45, 0.55 * a))
			ci.draw_rect(Rect2(o + f["pos"], Vector2(1, 1)), Color(0.9, 1.0, 0.7, a))


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
	_tick_atmosphere()
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
	for a in anims:
		a["frame_t"] += 1
	anims = anims.filter(func(a): return a["frame_t"] * FX_FPS / 60 < fx_frames(a["name"]))
	for wp in wave_parts:
		wp["pos"] += wp["vel"]
		if wp["element"] != "fire":
			wp["vel"].y += 0.18
		wp["t"] += 1
	wave_parts = wave_parts.filter(func(wp): return wp["t"] < wp["life"])
	for p in fx:
		p["pos"] += p["vel"]
		p["vel"] *= 0.93
		p["vel"].y += 0.05
		p["t"] -= 1
	fx = fx.filter(func(p): return p["t"] > 0)
	for f in floats:
		if f.has("vel"):
			# 피해 숫자: 톡 튀어 올랐다가 살짝 떨어지며 사라진다
			f["pos"] += f["vel"]
			f["vel"].y += 0.16
			f["vel"].x *= 0.9
			if f["vel"].y > 0.8:
				f["vel"].y = 0.8
		else:
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
	var sheet: String = {"fire": "fire_burst", "water": "splash", "earth": "dust"}.get(element, "hit_spark")
	if play_fx(sheet, pos, 1.5 if big else 1.0, element != "earth", dir.x < 0.0):
		light(pos, 22.0 if big else 14.0, Color(C.get(element, C["text"]).r, C.get(element, C["text"]).g, C.get(element, C["text"]).b, 0.5), 10)
		return
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
	# 합동 기술 파도: 벽 그림(fx/fire_wall·water_wave·earth_crack)이 있으면 세로로 이어 재생, 없으면 입자
	for w in battle.waves:
		var el: String = w["element"]
		var wall: String = {"fire": "fire_wall", "water": "water_wave", "earth": "earth_crack"}[el]
		if fx_frames(wall) > 0:
			if battle.frame % 3 == 0:
				for y in range(16, 260, 40):
					play_fx(wall, Vector2(w["x"], y), 1.0, el != "earth")
			continue
		for i in (14 if el == "fire" else 10):
			var y := randf_range(0.0, 260.0)
			match el:
				"fire":
					wave_parts.append({"pos": Vector2(w["x"] + randf_range(-8, 4), y), "vel": Vector2(randf_range(2.0, 4.0), -randf_range(1.0, 2.6)),
						"t": 0, "life": randi_range(10, 18), "size": randf_range(8.0, 14.0), "element": el})
				"water":
					wave_parts.append({"pos": Vector2(w["x"] + randf_range(-4, 4), y), "vel": Vector2(randf_range(1.0, 3.5), randf_range(-2.5, 0.5)),
						"t": 0, "life": randi_range(14, 26), "size": randf_range(5.0, 10.0), "element": el})
				"earth":
					wave_parts.append({"pos": Vector2(w["x"] + randf_range(-6, 6), y), "vel": Vector2(randf_range(-0.5, 0.8), -randf_range(1.5, 3.5)),
						"t": 0, "life": randi_range(16, 28), "size": randf_range(6.0, 12.0), "element": el})
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
				if not play_fx("slash", e["to"] - m["dir"] * 6.0, 1.2 if e["team"] == "ally" else 0.9, true, m["dir"].x < 0.0):
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
					damage_number(e["unit"], e["pos"], amt, col.lightened(0.45) if e["element"] != "" else C["text"])
					if big:
						hitstop = maxi(hitstop, 2)
						shake = maxf(shake, 2.0)
				else:
					light(e["pos"], 14.0, Color(1.0, 0.3, 0.25, 0.5), 8)
			"death":
				var who: String = e.get("who", "")
				corpses.append({"pos": e["pos"], "vel": Vector2(randf_range(1.0, 2.0) * (1.0 if e["team"] == "enemy" else -1.0), -3.5),
					"t": 22, "life": 22, "team": e["team"], "who": who, "element": e.get("element", ""), "id": e["unit"]})
				if not (e["team"] == "enemy" and play_fx("death_poof", e["pos"], 2.0 if e["big"] else 1.4, true)):
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


## 피해 숫자: 같은 적이 짧은 사이에 또 맞으면 새 숫자를 띄우지 않고 그 숫자를 키운다 (겹겹이 쌓이지 않게)
const DMG_MERGE := 18            # 이 프레임 안에 또 맞으면 합친다
const DMG_BIG := 25.0            # 이 이상이면 금빛 큰 숫자

func damage_number(uid: int, pos: Vector2, amt: float, color: Color) -> void:
	for f in floats:
		if f.get("uid", -1) == uid and f["life"] - f["t"] < DMG_MERGE:
			f["amount"] += amt
			f["t"] = f["life"]
			f["pop_t"] = 0
			f["vel"] = Vector2(f["vel"].x * 0.5, -1.6)
			if f["amount"] >= DMG_BIG:
				f["color"] = C["accent"]
			return
	floats.append({"uid": uid, "pos": pos + FIELD_OFFSET + Vector2(randf_range(-5, 5), -26), "amount": amt,
		"vel": Vector2(randf_range(-0.9, 0.9), -2.4), "color": C["accent"] if amt >= DMG_BIG else color,
		"t": 40, "life": 40, "pop_t": 0})


func _draw_damage_number(f: Dictionary) -> void:
	var amt: float = f["amount"]
	var a: float = minf(1.0, float(f["t"]) / 10.0)
	f["pop_t"] = int(f["pop_t"]) + 1
	# 글꼴 크기는 정수 단계만 (픽셀 글꼴이 흐려지지 않게): 맞은 순간 크게 → 제 크기
	var size := 12
	if amt >= DMG_BIG * 2.0:
		size = 24
	elif amt >= DMG_BIG:
		size = 18
	if f["pop_t"] <= 3:
		size += 6
	var s := "%d" % ceili(amt)
	var w: float = font_bold.get_string_size(s, HORIZONTAL_ALIGNMENT_LEFT, -1, size).x
	var p: Vector2 = (f["pos"] - Vector2(w * 0.5, 0)).round()
	var sh := Color(0.04, 0.02, 0.05, a * 0.9)
	draw_string(font_bold, p + Vector2(1, 2), s, HORIZONTAL_ALIGNMENT_LEFT, -1, size, Color(0, 0, 0, a * 0.5))
	for o in [Vector2(-1, 0), Vector2(1, 0), Vector2(0, -1), Vector2(0, 1)]:
		draw_string(font_bold, p + o, s, HORIZONTAL_ALIGNMENT_LEFT, -1, size, sh)
	var c: Color = f["color"]
	if f["pop_t"] <= 2:
		c = Color.WHITE   # 맞은 순간 하얗게 번쩍
	c.a = a
	draw_string(font_bold, p, s, HORIZONTAL_ALIGNMENT_LEFT, -1, size, c)


func rainbow(phase: float) -> Color:
	return Color.from_hsv(fmod(phase, 1.0), 0.6, 1.0)


func draw_fx() -> void:
	for p in fx:
		var c: Color = p["color"]
		c.a = float(p["t"]) / p["life"]
		draw_rect(Rect2(p["pos"] - Vector2.ONE * p["size"] / 2.0, Vector2.ONE * p["size"]), c)
	for f in floats:
		if f.has("amount"):
			_draw_damage_number(f)
			continue
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
	# 바닥·그림자·뒷빛은 층(bg/back)이 그린다
	# 마을 (뒤쪽 집부터)
	for i in HOUSES.size():
		_draw_house(i)
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
	_draw_anims(self, Vector2.ZERO, false)
	_draw_corpses(base)
	_draw_swooshes()
	_draw_arrows()
	draw_set_transform(Vector2.ZERO)


func _draw_house(i: int) -> void:
	var c: Vector2 = HOUSES[i]
	var st := _house_state(i)
	var sc := HOUSE_SCALE
	if st == 2:
		if draw_sprite("field/house_broken", c, sc):
			return
		if draw_sprite("field/house", c + Vector2(0, 6), sc, Color(0.3, 0.24, 0.24)):
			draw_line(c + Vector2(-14, -10), c + Vector2(10, 14), Color(0.08, 0.06, 0.06), 2.0)
			draw_line(c + Vector2(12, -12), c + Vector2(-6, 10), Color(0.08, 0.06, 0.06), 2.0)
			return
	var tint := Color(1, 0.86, 0.78) if st == 1 else Color.WHITE
	if draw_sprite("field/house", c, sc, tint if st != 2 else Color(0.3, 0.25, 0.25)):
		return
	var dk := 0.6 if st == 2 else 0.0
	draw_rect(Rect2(c + Vector2(-22, -6), Vector2(44, 28)), C["village"].darkened(dk))
	draw_colored_polygon(PackedVector2Array([c + Vector2(-28, -4), c + Vector2(28, -4), c + Vector2(0, -26)]), C["roof"].darkened(dk))


func _draw_ally_in_battle(u, base: Vector2) -> void:
	var mo := _motion(u)
	var p: Vector2 = u.pos + mo["off"]
	var sname := ("kiln/soldier_%s_%s" if view_style == "kiln" else "nest/creature_%s_%s") % [u.kind, u.element]
	if tex(sname) != null:
		_draw_unit_sprite(sname, base, p, ALLY_SCALE, mo["sq"], Color(2.5, 2.5, 2.5) if mo["white"] else Color.WHITE)
		_draw_tier_aura(p + Vector2(0, -6), u.tier, ALLY_SCALE * 0.9)
	else:
		draw_ally_shape(p, u.kind, u.element, u.tier, 1.6, mo["white"])
	if u.hp < u.max_hp:
		draw_rect(Rect2(u.pos + Vector2(-14, 26), Vector2(28, 3)), Color("3a2430"))
		draw_rect(Rect2(u.pos + Vector2(-14, 26), Vector2(28 * u.hp / u.max_hp, 3)), C["good"])


## 합동 기술 파도의 형태 (빛·입자는 빛층): 물은 하얀 물마루, 땅은 갈라진 줄과 돌조각
func _draw_waves() -> void:
	for w in battle.waves:
		var x: float = w["x"]
		match w["element"]:
			"water":
				for y in range(0, 260, 16):
					draw_arc(Vector2(x - 3, y + 8), 8.0, -PI / 2.0, PI / 2.0, 8, Color(0.92, 0.98, 1.0, 0.75), 2.0)
			"earth":
				var pts := PackedVector2Array()
				for y in range(0, 270, 10):
					pts.append(Vector2(x - 8 + (5.0 if (y / 10) % 2 == 0 else -5.0), y))
				draw_polyline(pts, Color(0.12, 0.08, 0.06), 3.0)
				draw_polyline(pts, Color(0.9, 0.6, 0.3, 0.6), 1.0)
	for wp in wave_parts:
		if wp["element"] == "earth" and wp["size"] > 10.0:
			var a: float = 1.0 - float(wp["t"]) / wp["life"]
			draw_rect(Rect2(wp["pos"] - Vector2(2, 2), Vector2(4, 4)), Color(0.35, 0.28, 0.22, a))


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
