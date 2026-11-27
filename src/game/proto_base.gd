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
var beams: Array = []            # 청룡 물기둥 [{from, to, t, life, element}]
var boss_seen := {}              # 등장을 알린 대장
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
	for bm in beams:
		var bk: float = float(bm["t"]) / bm["life"]
		var a0: Vector2 = bm["from"] + Vector2(14, -8)
		var n := 10
		for i in n:
			glow(ci, a0.lerp(bm["to"], i / float(n - 1)) + o, 26.0 * bk + 8.0, Color(0.55, 0.85, 1.0, 0.45 * bk))
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
		if a.get("cannon", false):
			glow(ci, p + Vector2(0, -sin(k * PI) * 40.0), 16.0, Color(1.0, 0.6, 0.2, 0.8))
			continue
		var col: Color = C.get(a["element"], C["imp"]) if a["team"] == "ally" else Color(0.45, 0.6, 1.0)
		col.a = 0.55
		glow(ci, p, 10.0, col)
	for u in battle.units:
		if u.team == "ally" and u.tier == "legend":
			var lc := Color(1.0, 0.95, 0.82, 0.20 + 0.06 * sin(t * 0.1))
			glow(ci, u.pos + o + Vector2(0, -10), 40.0, lc)
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
			var gr: String = PD.ROLE_GRADE.get(u.kind, "common")
			if PD.GRADES.find(gr) >= 3:
				# 영웅 이상: 발밑에 등급 색 빛 (신화일수록 크게)
				var gc: Color = GRADE_COL[gr]
				gc.a = 0.35 + 0.1 * sin(t * 0.1 + u.id)
				glow(ci, o + u.pos + Vector2(0, 20), 26.0 + 6.0 * (PD.GRADES.find(gr) - 3), gc, 0.35)
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
	if battle != null:
		for u in battle.units:
			var hm := _mv(u.id)
			var hk: float = clampf(u.hp / u.max_hp, 0.0, 1.0)
			var tr: float = hm.get("hp_trail", 1.0)
			hm["hp_trail"] = hk if tr < hk else maxf(hk, tr - 0.008)
	for id in uv:
		var m: Dictionary = uv[id]
		m["lunge"] = maxi(0, m["lunge"] - 1)
		m["hit"] = maxi(0, m["hit"] - 1)
		m["atk"] = maxi(0, m.get("atk", 0) - 1)
		m["kb"] *= 0.75
		m["squash"] *= 0.8
	for bm in beams:
		bm["t"] -= 1
	beams = beams.filter(func(bm): return bm["t"] > 0)
	for a in arrows:
		a["t"] -= 1
		if a["t"] == 0 and a.get("cannon", false):
			# 화차 불화살이 터진다
			if not play_fx("fire_burst", a["to"], 2.2, true):
				burst(a["to"] + FIELD_OFFSET, Color(1.0, 0.6, 0.25), 18, 3.0, 2.5)
			light(a["to"], 48.0, Color(1.0, 0.55, 0.2, 0.85), 14)
			shake = maxf(shake, 3.0)
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
	for u in battle.units:
		if u.team == "enemy" and u.kind in PD.BOSSES and not boss_seen.has(u.id):
			boss_seen[u.id] = true
			show_banner("%s 출현!" % u.name, "챕터 대장 — 쓰러뜨리면 다음 챕터로", C["danger"], 100)
			shake = maxf(shake, 8.0)
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
			var moved: float = m["prev"].distance_to(u.pos)
			m["walk"] += moved * 0.35
			m["walking"] = moved > 0.15
		m["prev"] = u.pos
	for e in battle.events:
		var col: Color = C.get(e.get("element", ""), C["text"])
		match e["kind"]:
			"swing":
				var m := _mv(e["unit"])
				m["lunge"] = 10
				start_attack_motion(e["unit"], e.get("role", "") if e["team"] == "ally" else "", e["to"] - e["pos"])
				if not play_fx("slash", e["to"] - m["dir"] * 6.0, 1.2 if e["team"] == "ally" else 0.9, true, m["dir"].x < 0.0):
					swooshes.append({"pos": e["pos"], "to": e["to"], "dir": m["dir"], "t": 9, "life": 9, "role": e.get("role", ""), "element": e["element"], "team": e["team"]})
			"shot":
				var m2 := _mv(e["unit"])
				m2["lunge"] = 8
				start_attack_motion(e["unit"], e.get("role", "") if e["team"] == "ally" else "", e["to"] - e["from"])
				var cannon: bool = e.get("role", "") == "cannon"
				arrows.append({"from": e["from"], "to": e["to"], "t": 14 if cannon else 7, "life": 14 if cannon else 7, "element": e["element"], "team": e["team"], "cannon": cannon})
				if cannon:
					light(e["from"] + Vector2(10, -6), 26.0, Color(1.0, 0.7, 0.3, 0.8), 8)
					shake = maxf(shake, 1.5)
			"beam":
				start_attack_motion(e["unit"], "dragon", e["to"] - e["from"])
				beams.append({"from": e["from"], "to": e["to"], "t": 14, "life": 14, "element": e["element"]})
				light(e["from"] + Vector2(16, -6), 40.0, Color(0.6, 0.9, 1.0, 0.9), 12)
				shake = maxf(shake, 5.0)
				hitstop = maxi(hitstop, 2)
			"summon":
				burst(e["pos"] + FIELD_OFFSET, Color(0.75, 0.55, 1.0), 12, 2.4, 2.0)
				light(e["pos"], 26.0, Color(0.7, 0.5, 1.0, 0.6), 10)
			"heal":
				start_attack_motion(e["unit"], "healer", Vector2.RIGHT)
				light(e["pos"], 26.0, Color(0.5, 1.0, 0.6, 0.6), 14)
				light(e["from"], 16.0, Color(1.0, 0.9, 0.5, 0.5), 10)
				burst(e["pos"] + FIELD_OFFSET + Vector2(0, -10), Color(0.6, 1.0, 0.65), 8, 1.4, 2.0)
				floats.append({"pos": e["pos"] + FIELD_OFFSET + Vector2(-8, -34), "text": "+%d" % roundi(e["amount"]), "color": Color(0.55, 1.0, 0.6), "size": 12, "t": 30, "life": 30})
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
## 폭에 맞춰 자르기 (넘치면 … ) — 글자가 다른 칸 밑으로 들어가 겹치지 않게
func fit(s: String, width: float, size := 12) -> String:
	if font.get_string_size(s, HORIZONTAL_ALIGNMENT_LEFT, -1, size).x <= width:
		return s
	var out := s
	while out.length() > 1 and font.get_string_size(out + "…", HORIZONTAL_ALIGNMENT_LEFT, -1, size).x > width:
		out = out.substr(0, out.length() - 1)
	return out + "…"


## 글자: 갈무리 픽셀 글꼴은 12의 배수 크기에서만 또렷하다 → 크기를 12·24·36 으로 맞추고, 자리는 정수 픽셀로
func text(pos: Vector2, s: String, color: Color = C["text"], size := 12, width := -1.0, align := HORIZONTAL_ALIGNMENT_LEFT) -> void:
	size = maxi(12, roundi(size / 12.0) * 12)
	pos = pos.round()
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
		size = 36 if f["pop_t"] <= 3 else 24
	elif amt >= DMG_BIG:
		size = 24
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
		# 글자를 비율로 키우면 픽셀 글꼴이 깨진다 → 크기 대신 자리만 움직인다
		draw_set_transform(f["pos"].round())
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


const PixelArt = preload("res://src/game/pixel_art.gd")


func tex(name: String) -> Texture2D:
	if _tex_cache.has(name):
		return _tex_cache[name]
	if name.begins_with("pix:"):
		var parts := name.split(":")
		_tex_cache[name] = PixelArt.make(parts[1], parts[2])
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
	# 발바닥 기준: 32px 그림과 같은 자리에 발이 오게 (큰 그림은 위로 자란다)
	draw_texture_rect(tx, Rect2(center + Vector2(-sz.x / 2.0, 12.8 * scale_k - sz.y), sz), false, tint)
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
## 요변은 링·반짝이 없이 '빛만 더 난다' (사용자 요청): 그림을 밝게 + 부드러운 빛 (빛은 glow 층)
func tier_tint(tier: String) -> Color:
	if tier == "legend":
		var k := 1.28 + 0.07 * sin(t * 0.08)
		return Color(k, k, k * 0.96)
	return Color.WHITE


func _draw_tier_aura(_pos: Vector2, _tier: String, _scale_k: float) -> void:
	pass


# ---------------- 병사·괴수·적 그리기 ----------------
## 새 병사(도끼병·기마병·무당·화차)는 Codex 그림이 오기 전까지 가까운 병사 그림 + 코드로 그린 소품으로 보인다
const ROLE_BASE := {"axe": "spear", "cavalry": "spear", "healer": "archer", "cannon": "archer",
	"slinger": "archer", "twin": "spear", "general": "shield", "sniper": "archer", "cheoyong": "spear"}
## 사람 모양이 아닌 신화 짐승은 그림이 올 때까지 코드로 그린다
const BEASTS := ["haetae", "dragon", "bulgasari"]
## 등급 색 (일반 → 신화)
const GRADE_COL := {"common": Color("cfc6b4"), "uncommon": Color("8fd88a"), "rare": Color("6fa8ff"),
	"hero": Color("c58bff"), "legendary": Color("ffb347"), "mythic": Color("ff5f7a")}


## 그림 고르기: Codex 그림 → 도트 격자(pixel_art.gd) → 비슷한 병사 그림 + 소품
func soldier_sprite(role: String, element: String) -> String:
	var own := ("kiln/soldier_%s_%s" if view_style == "kiln" else "nest/creature_%s_%s") % [role, element]
	if tex(own) != null:
		return own
	if view_style == "kiln" and PixelArt.MAPS.has(role):
		return "pix:%s:%s" % [role, element]
	if not ROLE_BASE.has(role):
		return own
	return "kiln/soldier_%s_%s" % [ROLE_BASE[role], element]


## 제 모양 그림이 있나 (있으면 소품을 덧그리지 않는다)
func has_own_sprite(role: String, element: String) -> bool:
	return tex(("kiln/soldier_%s_%s" if view_style == "kiln" else "nest/creature_%s_%s") % [role, element]) != null \
		or (view_style == "kiln" and PixelArt.MAPS.has(role))


## 소품: 그림 뒤(behind=true)·앞에 그린다. scale_k 는 그림 배율 (32px 기준)
func draw_role_prop(role: String, pos: Vector2, scale_k: float, element: String, behind: bool) -> void:
	var k := scale_k / 2.0
	var wood := Color("6b4a32")
	var dark := Color("2a1d16")
	match role:
		"cavalry":
			if behind:
				# 말: 몸통·목·머리·다리 (진흙빛 말 인형)
				var hc := Color("7a5a44")
				var b := pos + Vector2(-2, 12) * k
				draw_rect(Rect2(b + Vector2(-16, -6) * k, Vector2(30, 13) * k), dark)
				draw_rect(Rect2(b + Vector2(-15, -5) * k, Vector2(28, 11) * k), hc)
				draw_rect(Rect2(b + Vector2(-15, -5) * k, Vector2(28, 3) * k), hc.lightened(0.2))
				draw_rect(Rect2(b + Vector2(10, -16) * k, Vector2(7, 14) * k), hc)
				draw_rect(Rect2(b + Vector2(12, -19) * k, Vector2(11, 6) * k), hc.lightened(0.1))
				draw_rect(Rect2(b + Vector2(9, -18) * k, Vector2(3, 10) * k), dark)        # 갈기
				draw_rect(Rect2(b + Vector2(19, -18) * k, Vector2(1, 1) * k), Color.BLACK)  # 눈
				for lx in [-13.0, -8.0, 6.0, 11.0]:
					draw_rect(Rect2(b + Vector2(lx, 5) * k, Vector2(3, 9) * k), hc.darkened(0.25))
				draw_rect(Rect2(b + Vector2(-19, -4) * k, Vector2(4, 9) * k), dark)        # 꼬리
				draw_rect(Rect2(b + Vector2(-6, -7) * k, Vector2(10, 3) * k), C[element].darkened(0.1))   # 안장 (유약 색)
		"axe":
			if not behind:
				var h := pos + Vector2(9, -2) * k
				draw_line(h + Vector2(0, 10) * k, h + Vector2(0, -14) * k, wood, 2.0 * k)
				draw_colored_polygon(PackedVector2Array([h + Vector2(0, -14) * k, h + Vector2(9, -17) * k, h + Vector2(10, -6) * k, h + Vector2(0, -8) * k]), Color("c9c4b8"))
				draw_line(h + Vector2(9, -17) * k, h + Vector2(10, -6) * k, Color("f2eee4"), 1.0 * k)
		"healer":
			if not behind:
				# 방울과 오색 천
				var hb := pos + Vector2(-10, -2) * k
				draw_line(hb + Vector2(0, 8) * k, hb + Vector2(0, -6) * k, wood, 1.5 * k)
				for j in 3:
					draw_circle(hb + Vector2(-2 + j * 2, -8 - j * 2) * k, 1.8 * k, Color("e8c35a"))
				var cols := [Color("d9533f"), Color("e8c35a"), Color("7fc7b8")]
				for j in 3:
					draw_line(hb + Vector2(0, -4) * k, hb + Vector2(-4 - j * 2, 4 + j * 2) * k + Vector2(sin(t * 0.12 + j) * 1.5 * k, 0), cols[j], 1.2 * k)
		"slinger":
			if not behind:
				var sp0 := pos + Vector2(8, -6) * k
				draw_line(sp0, sp0 + Vector2(6 + sin(t * 0.3) * 2.0, -8) * k, Color("8a6a48"), 1.2 * k)
				draw_circle(sp0 + Vector2(6 + sin(t * 0.3) * 2.0, -8) * k, 2.2 * k, Color("7a7670"))
		"twin":
			if not behind:
				for j in 2:
					var a0 := pos + Vector2(-8 + j * 16, 0) * k
					draw_line(a0, a0 + Vector2(-3 + j * 9, -14) * k, Color("dcdad2"), 1.6 * k)
					draw_line(a0, a0 + Vector2(0, 3) * k, wood, 2.0 * k)
		"general":
			if behind:
				# 깃발 (유약 색) + 투구 장식
				var f0 := pos + Vector2(-10, -24) * k
				draw_line(f0, f0 + Vector2(0, 34) * k, wood, 2.0 * k)
				var wv := sin(t * 0.15) * 2.0
				draw_colored_polygon(PackedVector2Array([f0, f0 + Vector2(14, 2 + wv) * k, f0 + Vector2(13, 9 + wv) * k, f0 + Vector2(0, 8) * k]), C[element].lightened(0.1))
				draw_rect(Rect2(f0 + Vector2(3, 2) * k, Vector2(4, 4) * k), Color("e8c35a"))
			else:
				draw_rect(Rect2(pos + Vector2(-2, -17) * k, Vector2(4, 4) * k), Color("e8c35a"))
		"sniper":
			if not behind:
				# 큰 활 + 금빛 시위
				draw_arc(pos + Vector2(8, -2) * k, 13.0 * k, -1.35, 1.35, 14, Color("8a5a30"), 2.2 * k)
				draw_line(pos + Vector2(8 + cos(-1.35) * 13.0, -2 + sin(-1.35) * 13.0) * k, pos + Vector2(8 + cos(1.35) * 13.0, -2 + sin(1.35) * 13.0) * k, Color("ffe08a"), 1.0 * k)
		"cheoyong":
			if not behind:
				# 처용 탈 (붉은 얼굴) + 너울대는 소매
				var hp0 := pos + Vector2(0, -11) * k
				draw_circle(hp0, 5.0 * k, Color("b8463a"))
				draw_rect(Rect2(hp0 + Vector2(-3, -1) * k, Vector2(2, 1) * k), Color.BLACK)
				draw_rect(Rect2(hp0 + Vector2(1, -1) * k, Vector2(2, 1) * k), Color.BLACK)
				draw_rect(Rect2(hp0 + Vector2(-2, 2) * k, Vector2(4, 1) * k), Color("f2e6c8"))
				for j in 2:
					var sl := pos + Vector2(-7 + j * 14, -2) * k
					draw_line(sl, sl + Vector2((-6 + j * 12) + sin(t * 0.2 + j) * 3.0, 6) * k, C[element].lightened(0.3), 3.0 * k)
		"cannon":
			if behind:
				# 화차: 바퀴 달린 나무 수레 + 앞을 향한 신기전 통들
				var c0 := pos + Vector2(10, 8) * k
				draw_rect(Rect2(c0 + Vector2(-8, -4) * k, Vector2(20, 8) * k), dark)
				draw_rect(Rect2(c0 + Vector2(-7, -3) * k, Vector2(18, 6) * k), wood)
				for j in 3:
					for i2 in 3:
						draw_rect(Rect2(c0 + Vector2(-5 + i2 * 5, -14 + j * 4) * k, Vector2(4, 3) * k), Color("3a2a1e"))
						draw_rect(Rect2(c0 + Vector2(-4 + i2 * 5, -13 + j * 4) * k, Vector2(2, 1) * k), C[element].lightened(0.2))
				for wx in [-4.0, 8.0]:
					draw_circle(c0 + Vector2(wx, 6) * k, 4.0 * k, dark)
					draw_circle(c0 + Vector2(wx, 6) * k, 2.6 * k, wood)
					draw_circle(c0 + Vector2(wx, 6) * k, 0.9 * k, dark)


## 신화 짐승 (그림이 없을 때): 유약 바른 도자기 짐승. scale_k 는 32px 기준 배율
func draw_beast(role: String, pos: Vector2, scale_k: float, element: String, flash_white := false) -> void:
	var k := scale_k / 2.0
	var col: Color = Color(2.2, 2.2, 2.2) if flash_white else C[element]
	var hi: Color = col.lightened(0.35)
	var dk: Color = col.darkened(0.45)
	var ol := Color("1a1310")
	match role:
		"haetae":
			# 해치: 네발 사자 짐승, 갈기·뿔
			var b := pos + Vector2(-2, 6) * k
			draw_rect(Rect2(b + Vector2(-17, -9) * k, Vector2(32, 17) * k), ol)
			draw_rect(Rect2(b + Vector2(-16, -8) * k, Vector2(30, 15) * k), col)
			draw_rect(Rect2(b + Vector2(-16, -8) * k, Vector2(30, 4) * k), hi)
			for lx in [-14.0, -8.0, 6.0, 11.0]:
				draw_rect(Rect2(b + Vector2(lx, 6) * k, Vector2(4, 8) * k), dk)
			var h := b + Vector2(16, -12) * k
			draw_circle(h, 11.0 * k, ol)
			draw_circle(h, 10.0 * k, dk)                    # 갈기
			draw_circle(h + Vector2(2, 1) * k, 6.5 * k, col)  # 얼굴
			draw_rect(Rect2(h + Vector2(3, -2) * k, Vector2(2, 2) * k), Color("ffd36a"))
			draw_line(h + Vector2(-2, -9) * k, h + Vector2(1, -15) * k, hi, 2.0 * k)   # 뿔
			draw_rect(Rect2(h + Vector2(4, 3) * k, Vector2(4, 2) * k), Color("f2eee4"))
			draw_line(b + Vector2(-16, -4) * k, b + Vector2(-23, -12 + sin(t * 0.2) * 2.0) * k, dk, 3.0 * k)   # 꼬리
		"dragon":
			# 청룡: 구불구불 떠 있는 긴 몸
			var segs := 9
			for i in range(segs, -1, -1):
				var x := -22.0 + i * 5.0
				var y := sin(t * 0.12 + i * 0.7) * 5.0 - 6.0
				var r := (6.5 - absf(i - 5.0) * 0.35) * k
				draw_circle(pos + Vector2(x, y) * k, r + 1.0 * k, ol)
				draw_circle(pos + Vector2(x, y) * k, r, col if i % 2 == 0 else col.darkened(0.12))
				if i % 2 == 0:
					draw_rect(Rect2(pos + Vector2(x - 1, y - r / k - 2) * k, Vector2(2, 3) * k), hi)   # 등지느러미
			var hd := pos + Vector2(26, sin(t * 0.12 + 6.3) * 5.0 - 8.0) * k
			draw_circle(hd, 7.5 * k, ol)
			draw_circle(hd, 6.5 * k, col)
			draw_rect(Rect2(hd + Vector2(3, -3) * k, Vector2(2, 2) * k), Color("ffd36a"))
			draw_line(hd + Vector2(-3, -5) * k, hd + Vector2(-8, -12) * k, Color("e8c35a"), 1.5 * k)   # 뿔
			draw_line(hd + Vector2(5, 2) * k, hd + Vector2(12, 5 + sin(t * 0.2) * 2.0) * k, hi, 1.0 * k)  # 수염
			draw_circle(pos + Vector2(14, 10) * k, 3.0 * k, Color("f2e6c8"))   # 여의주
		"bulgasari":
			# 불가사리: 쇠를 먹는 가시 짐승, 덩치 큼
			var b2 := pos + Vector2(0, 4) * k
			draw_circle(b2, 15.0 * k, ol)
			draw_circle(b2, 14.0 * k, col)
			draw_circle(b2 + Vector2(-4, -5) * k, 6.0 * k, hi)
			for i in 7:
				var a := -PI + i * PI / 6.0
				var sp := b2 + Vector2.from_angle(a) * 14.0 * k
				draw_colored_polygon(PackedVector2Array([sp + Vector2.from_angle(a - 0.4) * 3.0 * k, sp + Vector2.from_angle(a + 0.4) * 3.0 * k, sp + Vector2.from_angle(a) * 7.0 * k]), Color("8f8a80"))
			draw_rect(Rect2(b2 + Vector2(6, -4) * k, Vector2(3, 3) * k), Color("ffd36a"))
			draw_rect(Rect2(b2 + Vector2(5, 3) * k, Vector2(7, 2) * k), Color("f2eee4"))
			for lx in [-9.0, 5.0]:
				draw_rect(Rect2(b2 + Vector2(lx, 11) * k, Vector2(5, 6) * k), dk)


func draw_ally_shape(pos: Vector2, role: String, element: String, tier: String, scale_k := 1.0, flash_white := false) -> void:
	if role in BEASTS and not has_own_sprite(role, element):
		draw_backlight(pos, element, scale_k)
		draw_beast(role, pos, scale_k, element, flash_white)
		_draw_tier_aura(pos, tier, scale_k)
		return
	var sname := soldier_sprite(role, element)
	if tex(sname) != null:
		var own := has_own_sprite(role, element)
		draw_backlight(pos, element, scale_k)
		if not own:
			draw_role_prop(role, pos, scale_k, element, true)
		var lift := Vector2(0, -6) * scale_k / 2.0 if role == "cavalry" and not own else Vector2.ZERO
		draw_sprite(sname, pos + lift, scale_k, Color(2.5, 2.5, 2.5) if flash_white else tier_tint(tier))
		if not own:
			draw_role_prop(role, pos, scale_k, element, false)
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


## 병사마다 다른 공격 모션 (k: 0 → 1 진행). 준비(뒤로) → 때리기(빠르게 앞으로) → 돌아오기
const ATK_DUR := {"spear": 14, "axe": 18, "twin": 16, "general": 18, "cavalry": 16, "shield": 12, "cheoyong": 22,
	"haetae": 20, "bulgasari": 22, "dragon": 20, "archer": 12, "slinger": 14, "sniper": 18, "cannon": 14, "healer": 18}


func start_attack_motion(id: int, role: String, dir: Vector2) -> void:
	var m := _mv(id)
	var d: int = ATK_DUR.get(role, 10)
	m["atk"] = d
	m["atk_d"] = d
	m["atk_role"] = role
	m["dir"] = dir.normalized() if dir.length() > 0.01 else Vector2.RIGHT


## 0→1 구간을 앞당김(빠른 출발·느린 정지)
static func _ease_out(x: float) -> float:
	return 1.0 - pow(1.0 - clampf(x, 0.0, 1.0), 3.0)


func _motion(u) -> Dictionary:
	var m := _mv(u.id)
	var off := Vector2.ZERO
	var rot := 0.0
	var sq: float = m["squash"]
	var flip := 1.0
	var dir: Vector2 = m["dir"]
	var atk: int = m.get("atk", 0)
	if atk > 0:
		var k: float = 1.0 - float(atk) / m["atk_d"]
		var wind: float = clampf(k / 0.35, 0.0, 1.0)           # 준비
		var hit: float = clampf((k - 0.35) / 0.2, 0.0, 1.0)    # 때리기
		var back: float = clampf((k - 0.55) / 0.45, 0.0, 1.0)  # 돌아오기
		var strike: float = _ease_out(hit) * (1.0 - back)
		match m.get("atk_role", ""):
			"spear":     # 찌르기: 살짝 당겼다가 길게 쭉
				off += dir * (-4.0 * wind * (1.0 - hit) + 16.0 * strike)
				rot = 0.12 * strike
			"axe":       # 내려찍기: 뒤로 크게 젖혔다가 앞으로 꺾으며 찍는다
				rot = -0.45 * wind * (1.0 - hit) + 0.5 * strike
				off += dir * 8.0 * strike
				sq += 0.18 * maxf(0.0, strike - 0.7) / 0.3
			"twin":      # 쌍검: 짧게 두 번
				var two := absf(sin(k * TAU))
				off += dir * 9.0 * two
				rot = 0.18 * sin(k * TAU * 2.0)
			"general":   # 장수: 칼을 치켜들고(위로 쭉) 크게 베며 내딛는다
				off += Vector2(0, -5.0 * wind * (1.0 - hit)) + dir * 14.0 * strike
				rot = -0.25 * wind * (1.0 - hit) + 0.3 * strike
				sq += -0.1 * wind * (1.0 - hit)
			"cavalry":   # 기마: 길게 돌진, 말 따라 들썩
				off += dir * 22.0 * strike + Vector2(0, -3.0 * absf(sin(k * PI * 3.0)))
				rot = 0.1 * strike
			"shield":    # 방패: 몸으로 밀치기
				off += dir * 9.0 * strike
				sq += 0.15 * strike
			"cheoyong":  # 처용: 한 바퀴 돌며 소매로 휘감는 춤 (돌 때 좌우가 뒤집힌다)
				flip = cos(k * TAU)
				if absf(flip) < 0.15:
					flip = 0.15 * signf(flip + 0.0001)
				off += Vector2(0, -6.0 * sin(k * PI)) + dir * 6.0 * sin(k * PI)
			"haetae":    # 해치: 웅크렸다가 덮친다 (포물선)
				sq += 0.2 * wind * (1.0 - hit)
				off += dir * 18.0 * strike + Vector2(0, -12.0 * sin(clampf((k - 0.3) / 0.5, 0.0, 1.0) * PI))
				rot = 0.15 * strike
			"bulgasari": # 불가사리: 몸을 일으켰다가 땅을 쿵
				off += Vector2(0, -8.0 * wind * (1.0 - hit))
				sq += -0.15 * wind * (1.0 - hit) + 0.3 * maxf(0.0, 1.0 - absf(k - 0.55) / 0.15)
				rot = -0.12 * wind * (1.0 - hit)
			"dragon":    # 청룡: 머리를 젖혔다가 앞으로 뿜는다
				rot = -0.22 * wind * (1.0 - hit) + 0.08 * strike
				off += dir * (-6.0 * wind * (1.0 - hit) + 6.0 * strike)
			"archer", "slinger", "sniper", "cannon":   # 쏘기: 당기며 웅크렸다가 반동
				var pull := 3.0 if m.get("atk_role", "") != "sniper" else 6.0
				off += -dir * (pull * wind * (1.0 - hit) + 4.0 * strike)
				sq += 0.08 * wind * (1.0 - hit) - 0.06 * strike
				rot = -0.06 * strike
			"healer":    # 무당: 깡충 뛰며 방울을 흔든다
				off += Vector2(0, -7.0 * sin(k * PI))
				rot = 0.15 * sin(k * TAU * 2.0)
			_:           # 적·기타: 덤벼들었다 돌아오기
				off += dir * sin(k * PI) * 8.0
	off += m["kb"]
	if atk == 0:
		if u.team == "ally" and u.kind == "dragon":
			off.y += sin(t * 0.06 + u.id) * 3.0                          # 청룡은 늘 떠서 출렁
		elif m.get("walking", false):
			off.y -= absf(sin(m["walk"])) * 2.5                          # 걸을 때 통통
		else:
			sq += sin(t * 0.07 + u.id * 1.3) * 0.025                      # 숨쉬기
	return {"off": off, "sq": sq, "white": m["hit"] > 4, "rot": rot, "flip": flip}


## base 변환 위에 유닛 하나를 (위치·찌그러짐 포함) 그린다
func _draw_unit_sprite(name: String, base: Vector2, pos: Vector2, scale_k: float, sq: float, tint: Color, rot := 0.0, flip := 1.0) -> bool:
	var tx := tex(name)
	if tx == null:
		return false
	var sz: Vector2 = tx.get_size() * scale_k
	# 발 쪽을 축으로 기울이고 찌그러뜨린다 (발이 땅에서 떨어지지 않게)
	var foot := Vector2(0, 12.8 * scale_k)
	draw_set_transform(base + pos + foot, rot, Vector2((1.0 + sq) * flip, 1.0 - sq))
	draw_texture_rect(tx, Rect2(Vector2(-sz.x / 2.0, -sz.y), sz), false, tint)
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
	if tex("enemy/" + u.kind) != null:
		return ["enemy/" + u.kind, 2.0, Color(1, 1, 1)]
	if ENEMY_STAND_IN.has(u.kind):
		return ENEMY_STAND_IN[u.kind]
	return ENEMY_LOOK.get(u.kind, ["enemy/goblin", 2.0, Color(1, 1, 1)])


## 챕터 적·대장: 전용 그림이 오기 전까지 도깨비 그림을 키우고 물들여 쓴다 (+ 코드 소품)
const ENEMY_STAND_IN := {
	"fox": ["enemy/goblin", 1.7, Color(1.45, 0.85, 0.5)],
	"armored": ["enemy/goblin", 2.3, Color(0.75, 0.8, 0.88)],
	"ghost": ["enemy/goblin", 2.1, Color(1.5, 1.6, 1.8, 0.55)],
	"giant": ["enemy/goblin", 3.1, Color(0.85, 0.62, 0.55)],
	"gumiho": ["enemy/goblin", 3.4, Color(1.6, 1.05, 0.7)],
	"imugi": ["enemy/goblin", 3.9, Color(0.55, 0.95, 0.75)],
	"reaper": ["enemy/goblin", 3.5, Color(0.5, 0.5, 0.62)],
	"king": ["enemy/goblin", 4.3, Color(1.25, 0.6, 0.5)],
}


func _draw_enemy_prop(u, p: Vector2, h: float) -> void:
	if tex("enemy/" + u.kind) != null:
		return
	match u.kind:
		"fox", "gumiho":
			var n := 9 if u.kind == "gumiho" else 1
			for i in n:
				var a := 0.2 + (i - (n - 1) / 2.0) * 0.22
				var base := p + Vector2(h * 0.25, h * 0.1)
				var tip := base + Vector2(cos(a) * h * 0.5, -h * 0.35 + sin(a) * h * 0.3 + sin(t * 0.15 + i) * 3.0)
				draw_line(base, tip, Color("e8853a"), maxf(3.0, h * 0.08))
				draw_circle(tip, maxf(2.0, h * 0.05), Color("fff0d8"))
		"armored":
			var top := p + Vector2(0, -h * 0.42)
			draw_rect(Rect2(top + Vector2(-h * 0.22, -3), Vector2(h * 0.44, 6)), Color("8a8f98"))
			draw_rect(Rect2(top + Vector2(-2, -9), Vector2(4, 6)), Color("b8bcc4"))
		"reaper":
			# 검은 갓
			var top2 := p + Vector2(0, -h * 0.45)
			draw_rect(Rect2(top2 + Vector2(-h * 0.36, 0), Vector2(h * 0.72, 4)), Color("101014"))
			draw_rect(Rect2(top2 + Vector2(-h * 0.13, -h * 0.16), Vector2(h * 0.26, h * 0.16)), Color("101014"))
		"imugi":
			for i in 5:
				draw_circle(p + Vector2(h * 0.3 + i * h * 0.14, h * 0.25 + sin(t * 0.1 + i) * 4.0), h * (0.12 - i * 0.015), Color(0.3, 0.55, 0.45))
		"king":
			var top3 := p + Vector2(0, -h * 0.62)
			draw_colored_polygon(PackedVector2Array([top3 + Vector2(-16, 8), top3 + Vector2(16, 8), top3 + Vector2(16, -4), top3 + Vector2(8, 3), top3 + Vector2(0, -9), top3 + Vector2(-8, 3), top3 + Vector2(-16, -4)]), C["accent"])


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
		_draw_unit_sprite(look[0], base, p, sc, mo["sq"], etint, mo["rot"])
		if u.kind == "brute" and tex("enemy/brute") == null:
			draw_line(p + Vector2(-h * 0.3, -h * 0.05), p + Vector2(-h * 0.5, -h * 0.45), Color("5a4030"), 5.0)
			draw_circle(p + Vector2(-h * 0.5, -h * 0.45), 5.0, Color("6b4c38"))
		_draw_enemy_prop(u, p, h)
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
	# 체력 바: 깎인 만큼 흰 꼬리가 남았다가 천천히 줄어든다 (얼마나 맞았는지 보이게)
	var m := _mv(u.id)
	var k: float = clampf(u.hp / u.max_hp, 0.0, 1.0)
	var trail: float = m.get("hp_trail", 1.0)
	if k < 1.0 or trail > k:
		var big: bool = u.kind in PD.BOSSES
		var bw: float = maxf(r * 2.0 + 10.0, h * 0.7)
		var bh := 4.0
		var by: float = p.y + h * 0.42
		var x0: float = p.x - bw / 2.0
		draw_rect(Rect2(Vector2(x0 - 1, by - 1), Vector2(bw + 2, bh + 2)), Color(0.05, 0.03, 0.05, 0.85))
		draw_rect(Rect2(Vector2(x0, by), Vector2(bw, bh)), Color("3a2430"))
		draw_rect(Rect2(Vector2(x0 + bw * k, by), Vector2(bw * maxf(0.0, trail - k), bh)), Color(1.0, 0.92, 0.7))
		var hc: Color = C["danger"] if k > 0.3 else Color("ff8a3a")
		draw_rect(Rect2(Vector2(x0, by), Vector2(bw * k, bh)), hc)
		draw_rect(Rect2(Vector2(x0, by), Vector2(bw * k, 1)), hc.lightened(0.35))
		if not big:
			for i in range(1, 4):
				draw_rect(Rect2(Vector2(x0 + bw * i / 4.0, by), Vector2(1, bh)), Color(0, 0, 0, 0.35))


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
	for bm in beams:
		var k: float = float(bm["t"]) / bm["life"]
		var bc: Color = C.get(bm["element"], C["water"]).lightened(0.5)
		bc.a = k
		draw_line(bm["from"] + Vector2(14, -8), bm["to"], bc, 10.0 * k + 2.0)
		draw_line(bm["from"] + Vector2(14, -8), bm["to"], Color(1, 1, 1, k), 3.0 * k + 1.0)
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
	var sname := soldier_sprite(u.kind, u.element)
	if u.kind in BEASTS and not has_own_sprite(u.kind, u.element):
		var gk: float = sqrt(u.grow) if u.kind == "bulgasari" else 1.0
		draw_beast(u.kind, p, ALLY_SCALE * gk, u.element, mo["white"])
		_draw_tier_aura(p + Vector2(0, -6), u.tier, ALLY_SCALE * 0.9)
	elif tex(sname) != null:
		var own := has_own_sprite(u.kind, u.element)
		if not own:
			draw_role_prop(u.kind, p, ALLY_SCALE, u.element, true)
		var lift := Vector2(0, -6) if u.kind == "cavalry" and not own else Vector2.ZERO
		_draw_unit_sprite(sname, base, p + lift, ALLY_SCALE, mo["sq"], Color(2.5, 2.5, 2.5) if mo["white"] else tier_tint(u.tier), mo["rot"], mo["flip"])
		if not own:
			draw_role_prop(u.kind, p, ALLY_SCALE, u.element, false)
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
		if a.get("cannon", false):
			# 신기전: 포물선으로 날아가는 불화살 + 불꼬리
			var arc := -sin(k * PI) * 40.0
			var pp := p + Vector2(0, arc)
			var prev: Vector2 = a["from"].lerp(a["to"], maxf(0.0, k - 0.08)) + Vector2(0, -sin(maxf(0.0, k - 0.08) * PI) * 40.0)
			draw_line(prev, pp, Color(1.0, 0.55, 0.2, 0.7), 3.0)
			draw_circle(pp, 3.5, Color(1.0, 0.85, 0.5))
			continue
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
	var vk: float = clampf(battle.village_hp / PD.VILLAGE_HP, 0.0, 1.0)
	text(Vector2(10, 40), "마을", C["dim"])
	draw_rect(Rect2(44, 31, 200, 10), Color("3a2430"))
	draw_rect(Rect2(44, 31, 200 * vk, 10), C["good"] if vk > 0.5 else C["accent"] if vk > 0.25 else C["danger"])
	text(Vector2(250, 40), "%d%%" % roundi(vk * 100.0))
	text(Vector2(300, 40), "처치 %d" % battle.stats["kills"], C["text"])
	var left: int = battle.spawn_queue.size()
	text(Vector2(372, 40), "남은 적 %d" % (left + battle._count("enemy")), C["dim"])
	_draw_synergy_cooldowns()
	# 대장 체력: 화면 아래 큰 바 (이름 + 깎이는 꼬리)
	for u in battle.units:
		if u.team == "enemy" and u.kind in PD.BOSSES:
			var bk: float = clampf(u.hp / u.max_hp, 0.0, 1.0)
			var btr: float = _mv(u.id).get("hp_trail", 1.0)
			var r := Rect2(170, 328, 300, 8)
			draw_rect(r.grow(2), Color(0.05, 0.03, 0.05, 0.9))
			draw_rect(r, Color("3a2430"))
			draw_rect(Rect2(r.position + Vector2(r.size.x * bk, 0), Vector2(r.size.x * maxf(0.0, btr - bk), r.size.y)), Color(1.0, 0.92, 0.7))
			draw_rect(Rect2(r.position, Vector2(r.size.x * bk, r.size.y)), C["danger"])
			draw_rect(Rect2(r.position, Vector2(r.size.x * bk, 2)), C["danger"].lightened(0.35))
			text(Vector2(170, 324), u.name, C["danger"].lightened(0.3))
			text(Vector2(170, 324), "%d / %d" % [ceili(u.hp), roundi(u.max_hp)], C["text"], 12, 300.0, HORIZONTAL_ALIGNMENT_RIGHT)
			break
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
