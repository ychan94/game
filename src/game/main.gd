extends Node2D
## 화면과 입력. 규칙은 src/core/ 에 있고, 여기서는 읽어서 그리기만 한다.
## 그림은 아직 임시 도형이다 (실제 그림은 Codex 작업으로 바꾼다).
##
## 조작: WASD/방향키 이동 · 마우스 조준 · 왼쪽 클릭/J 공격 · 스페이스/Shift/오른쪽 클릭 구르기
##       1~3 선택 · Enter 진행 · R 다시 시작 · F12 스크린샷

const Data = preload("res://src/core/data.gd")
const Run = preload("res://src/core/run.gd")
const Save = preload("res://src/core/save.gd")

const ROOM_OFFSET := Vector2(0, 40)
const VIEW := Vector2(640, 400)

const C := {
	"bg": Color("14121c"), "floor_a": Color("2a2638"), "floor_b": Color("26222f"), "wall": Color("0d0b12"),
	"text": Color("ece6d8"), "dim": Color("8f879c"), "accent": Color("ffcf5a"), "danger": Color("ff5a5a"),
	"player": Color("5ab4ff"), "echo": Color("b77bff"), "slime": Color("6fd36a"), "archer": Color("ff9d4a"),
	"charger": Color("e0504a"), "shot_player": Color("bfe6ff"), "shot_enemy": Color("ffb36b"),
	"panel": Color(0.06, 0.05, 0.09, 0.92), "card": Color("221e2e"), "hp": Color("ff6b6b"), "hp_bg": Color("3a2430"),
}

var font: FontFile
var save
var run
var start_step := "weapon"
var picked_weapon := ""
var effects: Array = []
var trail: Array = []
var _prev := {}


func _ready() -> void:
	font = load("res://assets/fonts/Galmuri11.ttf")
	font.antialiasing = TextServer.FONT_ANTIALIASING_NONE
	font.hinting = TextServer.HINTING_NONE
	font.subpixel_positioning = TextServer.SUBPIXEL_POSITIONING_DISABLED
	save = Save.new("user://save.json")
	_new_run()


func _new_run() -> void:
	run = Run.new(int(Time.get_unix_time_from_system()), save)
	start_step = "weapon"
	effects.clear()
	trail.clear()


# ---------------- 입력 ----------------
func _down(key: int) -> bool:
	return Input.is_physical_key_pressed(key)


func _pressed(key: int) -> bool:
	return _down(key) and not _prev.get(key, false)


func _mouse_pressed(button: int) -> bool:
	return Input.is_mouse_button_pressed(button) and not _prev.get(-button, false)


func _remember_keys() -> void:
	for k in [KEY_0, KEY_1, KEY_2, KEY_3, KEY_4, KEY_5, KEY_6, KEY_ENTER, KEY_KP_ENTER, KEY_SPACE, KEY_SHIFT, KEY_R, KEY_F12]:
		_prev[k] = _down(k)
	_prev[-MOUSE_BUTTON_RIGHT] = Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)


func _number_pressed() -> int:
	for i in 7:
		if _pressed(KEY_0 + i):
			return i
	return -1


func _gather_inputs() -> Dictionary:
	var move := Vector2(
		float(_down(KEY_D) or _down(KEY_RIGHT)) - float(_down(KEY_A) or _down(KEY_LEFT)),
		float(_down(KEY_S) or _down(KEY_DOWN)) - float(_down(KEY_W) or _down(KEY_UP)))
	var aim: Vector2 = get_local_mouse_position() - ROOM_OFFSET - run.world.player.pos
	return {
		"move": move,
		"aim": aim,
		"attack": Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) or _down(KEY_J),
		"dodge": _pressed(KEY_SPACE) or _pressed(KEY_SHIFT) or _mouse_pressed(MOUSE_BUTTON_RIGHT),
	}


func _physics_process(_delta: float) -> void:
	if _pressed(KEY_F12):
		_screenshot()
	match run.state:
		"start":
			_start_input()
		"room", "echo":
			run.step(_gather_inputs())
			if run.world != null:
				_collect_effects()
		"reward", "recover":
			var n := _number_pressed()
			if n >= 1:
				run.choose(n - 1)
		"analysis":
			if _pressed(KEY_ENTER) or _pressed(KEY_KP_ENTER):
				run.begin_echo_fight()
		"end":
			if _pressed(KEY_R) or _pressed(KEY_ENTER):
				_new_run()
	_tick_effects()
	queue_redraw()
	_remember_keys()


func _start_input() -> void:
	var n := _number_pressed()
	if start_step == "weapon":
		if n == 1 or n == 2:
			picked_weapon = "sword" if n == 1 else "bow"
			if save.codex().is_empty():
				run.start(picked_weapon)
			else:
				start_step = "carry"
	elif start_step == "carry":
		var codex: Array = save.codex()
		if n == 0:
			run.start(picked_weapon)
		elif n >= 1 and n <= codex.size():
			run.start(picked_weapon, codex[n - 1])


func _screenshot() -> void:
	var img := get_viewport().get_texture().get_image()
	var path := "user://screenshot_%d.png" % Time.get_unix_time_from_system()
	img.save_png(path)
	print("스크린샷: ", ProjectSettings.globalize_path(path))


# ---------------- 효과 ----------------
func _collect_effects() -> void:
	for e in run.world.events:
		var life: int = {"slash": 8, "hit": 6, "death": 16, "blast": 12, "dodge": 8, "exposed": 18, "shoot": 4, "windup": 1}.get(e["kind"], 6)
		var fx: Dictionary = e.duplicate()
		fx["t"] = life
		fx["life"] = life
		effects.append(fx)
	if run.state == "echo" and run.world.frame % 3 == 0:
		for u in run.world.units:
			if u.is_echo and u.alive:
				trail.append({"pos": u.pos, "t": 12})


func _tick_effects() -> void:
	for fx in effects:
		fx["t"] -= 1
	effects = effects.filter(func(fx): return fx["t"] > 0)
	for tr in trail:
		tr["t"] -= 1
	trail = trail.filter(func(tr): return tr["t"] > 0)


# ---------------- 그리기 ----------------
func _text(pos: Vector2, s: String, color: Color = C["text"], size := 12, width := -1.0, align := HORIZONTAL_ALIGNMENT_LEFT) -> void:
	if width > 0.0:
		draw_multiline_string(font, pos, s, align, width, size, -1, color)
	else:
		draw_string(font, pos, s, align, -1, size, color)


func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, VIEW), C["bg"])
	match run.state:
		"start":
			_draw_start()
		"room", "echo":
			_draw_world()
			_draw_hud()
		"reward":
			_draw_world()
			_draw_hud()
			_draw_choices("능력 하나를 고르세요", "1·2·3")
		"recover":
			_draw_world()
			_draw_hud()
			_draw_choices("어제의 나에게서 되찾을 능력", "1·2·3 — 고른 능력은 기억 도감에 남습니다")
		"analysis":
			_draw_analysis()
		"end":
			_draw_end()


func _draw_world() -> void:
	var w = run.world
	if w == null:
		return
	draw_set_transform(ROOM_OFFSET)
	var room: Rect2 = w.ROOM
	for x in int(room.size.x / 32):
		for y in int(room.size.y / 32):
			draw_rect(Rect2(x * 32, y * 32, 32, 32), C["floor_a"] if (x + y) % 2 == 0 else C["floor_b"])
	var wall: float = w.WALL
	draw_rect(Rect2(0, 0, room.size.x, wall), C["wall"])
	draw_rect(Rect2(0, room.size.y - wall, room.size.x, wall), C["wall"])
	draw_rect(Rect2(0, 0, wall, room.size.y), C["wall"])
	draw_rect(Rect2(room.size.x - wall, 0, wall, room.size.y), C["wall"])

	# 예고선 (돌진·조준)
	for u in w.units:
		if not u.alive:
			continue
		if u.kind == "charger" and (u.state == "telegraph" or u.state == "dash"):
			var length: float = Data.ENEMIES["charger"]["dash_speed"] * Data.ENEMIES["charger"]["dash"]
			var col: Color = C["danger"]
			col.a = 0.25 if u.state == "telegraph" else 0.5
			draw_line(u.pos, u.pos + u.aim_dir * length, col, u.radius * 2.0)
		if u.kind == "archer" and u.state == "aim":
			var col2: Color = C["archer"]
			col2.a = 0.5
			draw_line(u.pos, u.pos + u.aim_dir * 400.0, col2, 1.0)

	for tr in trail:
		var tc: Color = C["echo"]
		tc.a = 0.25 * tr["t"] / 12.0
		draw_circle(tr["pos"], Data.PLAYER_RADIUS, tc)

	for u in w.units:
		if u.alive or u == w.player:
			_draw_unit(u)

	for s in w.shots:
		draw_circle(s.pos, s.radius, C["shot_player"] if s.team == "player" else C["shot_enemy"])

	for fx in effects:
		_draw_effect(fx)
	draw_set_transform(Vector2.ZERO)


func _draw_unit(u) -> void:
	var col: Color = C.get(u.kind, C["text"])
	if u.kind == "player":
		col = C["player"]
	if u.state == "spawn":
		col.a = 0.35
	if u.dodge_t > 0:
		col = col.lightened(0.4)
	if u.is_echo:
		col.a = 0.9
	if u.hit_flash > 0:
		col = Color.WHITE
	if u.kind == "player" and u.invuln > 0 and u.dodge_t == 0 and (run.world.frame / 4) % 2 == 0:
		col.a = 0.4
	if not u.alive:
		col = C["dim"]
		col.a = 0.5
	draw_circle(u.pos, u.radius, col)
	draw_line(u.pos, u.pos + u.facing * (u.radius + 5.0), col.darkened(0.3), 2.0)
	if u.is_echo:
		if u.state == "windup":
			var k: float = 1.0 - float(u.timer) / Data.ECHO_WINDUP
			draw_arc(u.pos, u.radius + 4.0 + 10.0 * k, 0, TAU, 24, C["danger"], 2.0)
		if u.exposed > 0:
			draw_arc(u.pos, u.radius + 3.0, 0, TAU, 24, C["accent"], 2.0)
			_text(u.pos + Vector2(-3, -u.radius - 6), "!", C["accent"], 12)
	if u.team == "enemy" and u.alive and u.hp < u.max_hp:
		var bw: float = u.radius * 2.0 + 6.0
		var top: Vector2 = u.pos + Vector2(-bw / 2.0, -u.radius - 6.0)
		draw_rect(Rect2(top, Vector2(bw, 3)), C["hp_bg"])
		draw_rect(Rect2(top, Vector2(bw * u.hp / u.max_hp, 3)), C["hp"])


func _draw_effect(fx: Dictionary) -> void:
	var k: float = float(fx["t"]) / fx["life"]
	match fx["kind"]:
		"slash":
			var col: Color = C["text"]
			col.a = 0.7 * k
			var arc := deg_to_rad(fx.get("arc", 100.0))
			var f: Vector2 = fx["facing"]
			draw_arc(fx["pos"], fx.get("reach", 40.0) - 4.0, f.angle() - arc / 2.0, f.angle() + arc / 2.0, 20, col, 4.0)
		"hit":
			draw_arc(fx["pos"], 6.0 + (1.0 - k) * 8.0, 0, TAU, 16, Color(1, 1, 1, k), 2.0)
		"death":
			for i in 8:
				var a := TAU * i / 8.0
				draw_circle(fx["pos"] + Vector2.from_angle(a) * (1.0 - k) * 18.0, 2.0, Color(1, 1, 1, k))
		"blast":
			draw_arc(fx["pos"], 44.0 * (1.2 - k), 0, TAU, 24, Color(1, 0.6, 0.2, k), 3.0)
		"dodge":
			draw_circle(fx["pos"], 4.0 * k + 2.0, Color(0.8, 0.8, 0.9, 0.4 * k))


func _draw_hud() -> void:
	var w = run.world
	if w == null:
		return
	var p = w.player
	_text(Vector2(8, 16), "체력", C["dim"])
	draw_rect(Rect2(40, 7, 140, 10), C["hp_bg"])
	draw_rect(Rect2(40, 7, 140 * maxf(p.hp, 0.0) / p.max_hp, 10), C["hp"])
	_text(Vector2(186, 16), "%d" % ceili(p.hp))
	_text(Vector2(8, 33), "구르기", C["dim"])
	for i in p.dodge_max:
		draw_rect(Rect2(52 + i * 14, 25, 10, 10), C["accent"] if i < p.dodge_charges else C["hp_bg"])
	var where := "어제의 나" if run.state == "echo" else "%d층 %d번째 방" % [run.floor_no, run.room_no]
	_text(Vector2(240, 16), where, C["accent"] if run.state == "echo" else C["text"])
	_text(Vector2(240, 33), "%s · 남은 적 %d" % [Data.WEAPONS[run.weapon]["name"], w.foes_left()], C["dim"])
	var names: Array = []
	for a in run.abilities:
		names.append(Data.ABILITIES[a]["name"])
	_text(Vector2(400, 16), "능력 %d/%d" % [names.size(), Data.MAX_ABILITIES], C["dim"])
	_text(Vector2(400, 33), ", ".join(names) if not names.is_empty() else "-", C["text"], 12, 236.0)


func _panel(rect: Rect2) -> void:
	draw_rect(rect, C["panel"])
	draw_rect(rect, C["dim"], false, 1.0)


func _draw_choices(title: String, footer: String) -> void:
	_panel(Rect2(40, 90, 560, 230))
	_text(Vector2(40, 120), title, C["accent"], 24, 560.0, HORIZONTAL_ALIGNMENT_CENTER)
	var n: int = run.choices.size()
	var cw := 168.0
	var x0: float = 320.0 - (cw * n + 12.0 * (n - 1)) / 2.0
	for i in n:
		var a: Dictionary = Data.ABILITIES[run.choices[i]]
		var r := Rect2(x0 + i * (cw + 12.0), 140, cw, 140)
		draw_rect(r, C["card"])
		draw_rect(r, C["dim"], false, 1.0)
		_text(r.position + Vector2(10, 22), "[%d] %s" % [i + 1, a["name"]], C["text"], 12)
		_text(r.position + Vector2(10, 40), a["type"], C["accent"], 12)
		_text(r.position + Vector2(10, 62), a["desc"], C["dim"], 12, cw - 20.0)
	_text(Vector2(40, 306), footer, C["dim"], 12, 560.0, HORIZONTAL_ALIGNMENT_CENTER)


func _draw_start() -> void:
	_text(Vector2(0, 110), "AFTERSELF", C["echo"], 36, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	_text(Vector2(0, 136), "(가제) 어제 죽은 내가 기다린다", C["dim"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	if start_step == "weapon":
		_text(Vector2(0, 200), "무기를 고르세요", C["text"], 24, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
		_text(Vector2(0, 236), "[1] 검 — 가까이, 강하게      [2] 활 — 멀리서, 꾸준히", C["accent"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	else:
		_text(Vector2(0, 200), "기억 도감에서 하나 들고 갈 수 있습니다", C["text"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
		var codex: Array = save.codex()
		var lines := ["[0] 들고 가지 않음"]
		for i in codex.size():
			lines.append("[%d] %s" % [i + 1, Data.ABILITIES[codex[i]]["name"]])
		_text(Vector2(0, 226), "   ".join(lines), C["accent"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	_text(Vector2(0, 330), "이동 WASD · 조준 마우스 · 공격 클릭/J · 구르기 스페이스", C["dim"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	var e: Dictionary = save.echo()
	var msg := "아직 어제의 나가 없습니다. 3층에는 연습용 메아리가 기다립니다." if e.is_empty() \
		else "3층에서 어제의 내가 기다립니다 (%s, 능력 %d개)" % [Data.WEAPONS[e["weapon"]]["name"], e["abilities"].size()]
	_text(Vector2(0, 360), msg, C["echo"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)


func _stars(n: int) -> String:
	return "★".repeat(n) + "☆".repeat(3 - n)


func _draw_analysis() -> void:
	var e: Dictionary = run.echo_profile
	_panel(Rect2(24, 20, 592, 360))
	_text(Vector2(24, 52), "어제의 나 분석표", C["echo"], 24, 592.0, HORIZONTAL_ALIGNMENT_CENTER)
	var who := "연습용 메아리" if e.get("tutorial", false) else ("%d층에서 쓰러진 나" % e["floor"] if e["result"] == "dead" else "끝까지 간 나")
	var names: Array = []
	for a in e["abilities"]:
		names.append(Data.ABILITIES[a]["name"])
	_text(Vector2(24, 74), "%s · %s · %s" % [who, Data.WEAPONS[e["weapon"]]["name"], ", ".join(names) if not names.is_empty() else "능력 없음"],
		C["dim"], 12, 592.0, HORIZONTAL_ALIGNMENT_CENTER)
	var y := 104.0
	for row in run.analysis_rows():
		draw_rect(Rect2(48, y - 14, 544, 54), C["card"])
		_text(Vector2(60, y + 2), row["label"], C["text"], 12)
		_text(Vector2(150, y + 2), _stars(row["stars"]), C["accent"], 12)
		_text(Vector2(210, y + 2), row["value"], C["text"], 12)
		_text(Vector2(60, y + 24), "→ " + row["hint"], C["echo"], 12)
		y += 62.0
	_text(Vector2(24, 368), "Enter: 들어가기", C["accent"], 12, 592.0, HORIZONTAL_ALIGNMENT_CENTER)


func _draw_end() -> void:
	var won: bool = run.result == "victory"
	_text(Vector2(0, 110), "어제의 나를 넘었다" if won else "쓰러졌다", C["accent"] if won else C["danger"], 24, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	_text(Vector2(0, 150), "이번 판의 당신이 다음 판의 '어제의 나'가 됩니다.", C["echo"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	var h: Dictionary = run.new_echo.get("habits", {})
	var lines := [
		"무기: %s" % Data.WEAPONS[run.weapon]["name"],
		"능력: %d개" % run.abilities.size(),
		"구르기: 1분에 %.0f번" % h.get("dodge_per_min", 0.0),
		"주로 싸운 거리: %.0fpx" % h.get("pref_distance", 0.0),
	]
	var y := 190.0
	for l in lines:
		_text(Vector2(0, y), l, C["text"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
		y += 20.0
	_text(Vector2(0, 340), "R: 다시 시작", C["dim"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
