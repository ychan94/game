extends "res://src/game/proto_base.gd"
## B 가마의 병사 — 한 판 = 챕터 5개 × (아침 5번 · 밤 5번). 병사는 밤·챕터가 지나도 남는다.
##   아침(뽑기·다시 굽기·합치기) → 가마(불 올리기·열기) → 아침 → 밤 → 밤 결과 → … → 다섯째 밤 대장 → 다음 챕터

const KilnRun = preload("res://src/proto/kiln_run.gd")
const Meta = preload("res://src/proto/meta.gd")
var meta                 # 전술 강화·기록 (판이 끝나도 남는다)
var last_rank := -1      # 방금 챕터 기록 순위
var last_embers := 0     # 방금 판에서 얻은 불씨
var meta_hover := ""

var run
var kiln                 # run.kiln (불 세기·확률·파편)
var state := "prep"      # prep → fire → reveal → prep → battle → night_end → prep … / final
var reveal_t := 0
var reveal_shown := 0
var selected := -1       # 고른 병사 id
var draw_flash := 0      # 방금 뽑은 칸 반짝임
var fought := Vector2i(1, 1)   # 방금 싸운 (챕터, 밤) — 밤 결과 화면용
var show_help := false   # 별·등급 안내 창
var right_tab := "draw"  # 오른쪽 칸: draw 뽑기 / shop 상점 / equip 장비 (챕터 3부터)
var bet_on := false      # 가마신과 내기를 걸었나
var bet_told := false    # 내기 결과를 알렸나
var promo_pick := false  # 전직 재료를 고르는 중
var drag_id := -1        # 배치: 끌고 있는 병사 id
var drag_from := Vector2.ZERO
var mouse_was := false
var tip_sid := -1        # 정보창을 띄운 병사 id (배치·전투)
var tip_t := 0
var unit_sid := {}       # 전투 유닛 id → 병사 id
var gfx := {}            # 희귀 이상 등장 연출 {i, grade, need, taps, phase(tap/burst/show), t}
var gfx_done := {}       # 연출을 마친 결과 칸
const GFX_TAPS := {"rare": 3, "hero": 3, "legendary": 3, "mythic": 3}   # 2026-12-01 "희귀 이상은 전부다 3번 클릭"
var army_page := 0       # 부대 칸 쪽 (18칸 넘으면 여러 쪽)
var meta_from := "title" # 전술 강화를 어디서 열었나 (처음 화면 / 로비)
var res_page := 0        # 대기실 쪽
var inv_page := 0        # 장비 가방 쪽 (12개씩)
var codex_tab := "unit"  # 도감: unit 병사 / skill 스킬 / combo 합동 기술 / rule 합치기·전직
var codex_role := "spear"
var codex_from := "prep" # 도감을 어디서 열었나
var rf_pick: Array = []   # 원군으로 고른 대기실 병사 id (최대 3)
var preview := {}        # 스킬·합동 기술 영상: 작은 전투를 되풀이해 보여 준다 {kind, role, element, combo, t, back}
var res_sort := "grade"  # 대기실 정렬: grade 등급순 / new 최근순
var res_pick := -1       # 대기실에서 고른 병사 (부대 병사를 누르면 맞바꾼다)
var hover_sid := -1      # 대기실 화면: 마우스가 올라간 병사 (정보창)
var release_armed := -1  # 돌려보내기: 한 번 더 눌러야 확정
var drawn_at := {}       # 작업대: 가마 줄 번호 → 흙 인형이 나타나는 프레임 (5번 뽑기는 차례로)
var popped := {}         # 나타날 때 흙먼지를 이미 냈나
var load_t := 0          # 흙 인형이 가마로 들어가는 연출 시간
var card_at := {}        # 꺼낸 병사 카드가 나타난 프레임 (결과 번호 → t)
const OPEN_T := 64       # 가마 문이 열리기까지
const CARD_GAP := 16     # 카드 사이 간격 (프레임)
const NEUTRAL := Color(1.0, 0.9, 0.74)   # 등장 연출의 빛: 등급을 미리 알리지 않는 따뜻한 흰빛
const CLAY_TONES := [Color("3a2c22"), Color("7a604a"), Color("a88a6c"), Color("cdb594")]
var end_t := 0           # 밤 결과 창 연출 시간
var shop_pick := -1      # 상점: 병사를 고르는 중인 진열 칸
var shop_table := false  # 상점: 물건 목록·확률표 창
var end_wait := 0        # 마지막 적이 쓰러진 뒤 여운
# 튜토리얼 (처음 한 번씩만): draw 뽑기 → fire 가마 → star 별 올리기 → full 자리 꽉 참
const TUT_FILE := "user://kiln_tutorial.cfg"
var tut_seen := {}
var tut_now := ""
var tutorial_enabled := true
var new_best := false
var paused := false      # 일시정지 창
var pause_ask := ""      # "title": 처음 화면으로 갈지 묻는 중
var pause_settings := false
var start_ask := false
var name_edit: LineEdit = null   # 군주 이름 입력칸
var naming_from := "title"   # 처음 화면: 저장된 판이 있을 때 이어하기 / 새로 시작
var draft_shown_t := 0   # 전술 카드가 나온 때 (솟아오르는 연출)
# 환경설정 (판과 무관, 이 컴퓨터에 저장)
const OPT_FILE := "user://kiln_settings.cfg"
var opt := {"music": 0.7, "sound": 0.7, "fullscreen": false, "speed": 1, "shake": true, "numbers": true, "tutorial": true}


func _ready() -> void:
	super._ready()
	view_style = "kiln"
	var cf := ConfigFile.new()
	if cf.load(TUT_FILE) == OK:
		for k in cf.get_section_keys("seen") if cf.has_section("seen") else []:
			tut_seen[k] = true
	meta = Meta.new()
	meta.load_saved()
	_load_opts()
	_new_run()
	state = "title"


## 판 저장 / 이어하기 ---------------------------------------------
var save_enabled := true   # 스크린샷·시험에서는 끈다

func _save_run() -> void:
	if save_enabled and run != null and run.state == "prep":
		run.save_to()


func _continue_run() -> void:
	var r = KilnRun.load_from(KilnRun.RUN_SAVE, meta.effects())
	if r == null:
		show_banner("저장된 판을 불러오지 못했다", "새 판을 시작합니다", C["danger"], 90)
		_new_run()
		return
	run = r
	kiln = run.kiln
	state = "prep"
	selected = -1
	battle = null
	show_banner("이어하기", "챕터 %d · 아침 %d" % [run.chapter, run.night], UI["gold"], 70)


## 창을 닫아도 판이 남게: 전투 중이 아니면 지금 상태를, 전투 중이면 밤 직전 저장을 그대로 둔다
func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST and run != null and state in ["prep", "gacha", "shop", "equip", "barracks", "combo"]:
		_save_run()


## 일시정지 창을 열어도 되는 때 (전술 뽑기·원군 고르기 중에도 된다)
func pause_ok() -> bool:
	return run != null


func _pause_input() -> void:
	if pause_settings:
		_settings_input()
		return
	var in_battle: bool = state in ["battle", "battle_end"]
	if pause_ask == "title":
		if clicked("pz_yes"):
			if not in_battle and state != "night_end":
				_save_run()
			paused = false
			pause_ask = ""
			battle = null
			cutin = {}
			floats.clear()
			state = "title"
			sfx("confirm")
		elif clicked("pz_no") or pressed(KEY_ESCAPE):
			pause_ask = ""
		return
	if clicked("pz_resume") or pressed(KEY_ESCAPE):
		paused = false
		sfx("click")
	elif clicked("pz_settings"):
		pause_settings = true
	elif clicked("pz_title"):
		pause_ask = "title"



# ---------------- 군주 이름 · 프로필 (2026-12-01) ----------------
const NAME_PARTS_A := ["가마", "흙", "불꽃", "청자", "진사", "달빛", "솔", "바람", "구름", "백자"]
const NAME_PARTS_B := ["군주", "도공", "성주", "장군", "지기", "왕", "대감", "나리"]


func _open_naming(from: String) -> void:
	naming_from = from
	state = "naming"
	if name_edit == null:
		name_edit = LineEdit.new()
		name_edit.max_length = Meta.NAME_MAX
		name_edit.alignment = HORIZONTAL_ALIGNMENT_CENTER
		name_edit.placeholder_text = "이름 (2~8자)"
		name_edit.add_theme_font_override("font", font_bold)
		name_edit.add_theme_font_size_override("font_size", 16)
		name_edit.position = Vector2(220, 170)
		name_edit.size = Vector2(200, 30)
		name_edit.text_submitted.connect(func(_tx): _confirm_name())
		add_child(name_edit)
	name_edit.text = meta.lord_name
	name_edit.visible = true
	name_edit.grab_focus()


func _close_naming() -> void:
	if name_edit != null:
		name_edit.visible = false
		name_edit.release_focus()
	state = naming_from


func _confirm_name() -> void:
	var n := Meta.clean_name(name_edit.text if name_edit != null else "")
	if n == "":
		show_banner("이름은 %d~%d자로 지어 주세요" % [Meta.NAME_MIN, Meta.NAME_MAX], "", C["danger"], 70)
		sfx("deny")
		return
	var first: bool = meta.lord_name == ""
	meta.lord_name = n
	meta.save()
	sfx("confirm")
	_close_naming()
	if first and naming_from == "title":
		show_banner("%s 군주, 마을을 부탁합니다" % n, "", UI["gold"], 90)
		_new_run()
		_save_run()


func _naming_input() -> void:
	if clicked("nm_ok"):
		_confirm_name()
	elif clicked("nm_dice"):
		name_edit.text = NAME_PARTS_A[randi() % NAME_PARTS_A.size()] + NAME_PARTS_B[randi() % NAME_PARTS_B.size()]
		sfx("click")
	elif (clicked("nm_back") or pressed(KEY_ESCAPE)) and meta.lord_name != "":
		_close_naming()


func _draw_naming() -> void:
	_draw_title_bg_only()
	draw_rect(Rect2(Vector2.ZERO, VIEW), Color(0, 0, 0, 0.6))
	var pr := Rect2(170, 80, 300, 220)
	panel(pr)
	text(Vector2(pr.position.x, pr.position.y + 34), "군주의 이름", UI["gold"], 24, pr.size.x, HORIZONTAL_ALIGNMENT_CENTER)
	text(Vector2(pr.position.x, pr.position.y + 56), "마을을 다스릴 당신의 이름을 정하세요 · 랭킹에 남습니다", UI["muted"], 12, pr.size.x, HORIZONTAL_ALIGNMENT_CENTER)
	var preview: String = Meta.clean_name(name_edit.text) if name_edit != null else ""
	_draw_lord_seal(Vector2(pr.get_center().x - 16, pr.position.y + 132), 32.0, preview)
	button(Rect2(pr.position.x + 30, pr.position.y + 178, 110, 28), "주사위 이름", "nm_dice", C["dim"])
	button(Rect2(pr.position.x + 160, pr.position.y + 178, 110, 28), "정하기  (Enter)", "nm_ok", UI["gold"], true, true)
	if meta.lord_name != "":
		button(Rect2(pr.position.x + 10, pr.position.y + 10, 60, 22), "‹ 뒤로", "nm_back", UI["gold"])


## 군주 도장: 붉은 네모 낙관에 이름 첫 글자 (단계가 오를수록 테두리가 금빛)
func _draw_lord_seal(pos: Vector2, sz: float, name_override := "") -> void:
	var nm: String = name_override if name_override != "" else meta.lord_name
	var lv: int = meta.lord_level()
	var r := Rect2(pos, Vector2(sz, sz))
	rrect(Rect2(r.position + Vector2(0, 2), r.size), Color(0, 0, 0, 0.45))
	rrect(r, Color("9e2b25"))
	draw_rect(r.grow(-2.0), Color("f4e6c8"), false, 1.0)
	if lv >= 2:
		draw_rect(r.grow(1.0), UI["gold"] if lv >= 3 else Color("c0c8d0"), false, 1.0 + (1.0 if lv >= 4 else 0.0))
	var ch: String = nm.substr(0, 1) if nm != "" else "?"
	var f: Font = font_head
	var fs: int = int(sz * 0.62)
	var w: float = f.get_string_size(ch, HORIZONTAL_ALIGNMENT_LEFT, -1, fs).x
	draw_string(f, Vector2(r.get_center().x - w / 2.0, r.get_center().y + fs * 0.36).round(), ch, HORIZONTAL_ALIGNMENT_LEFT, -1, fs, Color("f4e6c8"))


## 처음 화면 왼쪽 위 군주 프로필: 도장 · 이름 · 칭호 · 다음 칭호까지
func _draw_lord_badge(r: Rect2, clickable: bool) -> void:
	panel(r)
	_draw_lord_seal(r.position + Vector2(6, 6), r.size.y - 12)
	var x: float = r.position.x + r.size.y
	if meta.lord_name == "":
		text(Vector2(x, r.position.y + 20), "이름 없는 군주", UI["gold"])
		text(Vector2(x, r.position.y + 37), "게임 시작에서 이름 짓기", UI["muted"])
	else:
		text(Vector2(x, r.position.y + 20), fit(meta.lord_name, r.end.x - x - 6), UI["gold"])
		text(Vector2(x, r.position.y + 35), meta.lord_title(), C["text"])
		var pg: Vector2i = meta.lord_progress()
		var bw: float = r.end.x - x - 8
		draw_rect(Rect2(x, r.position.y + 39, bw, 2), Color("3a2e22"))
		draw_rect(Rect2(x, r.position.y + 39, bw * float(pg.x) / maxf(1.0, pg.y), 2), UI["gold"])
	if clickable:
		buttons.append({"rect": r, "id": "lord_badge"})


func _draw_start_ask() -> void:
	# 저장된 판이 있으면: 이어하기 / 새로 시작
	draw_rect(Rect2(Vector2.ZERO, VIEW), Color(0, 0, 0, 0.6))
	var ar := Rect2(200, 120, 240, 150)
	panel(ar)
	text(Vector2(ar.position.x, ar.position.y + 30), "저장된 판이 있습니다", UI["gold"], 12, ar.size.x, HORIZONTAL_ALIGNMENT_CENTER)
	button(Rect2(ar.position.x + 40, ar.position.y + 44, 160, 30), "이어하기  (Enter)", "cont", UI["gold"], true, true)
	button(Rect2(ar.position.x + 40, ar.position.y + 82, 160, 26), "새로 시작 (저장한 판 지움)", "fresh", C["dim"])
	button(Rect2(ar.position.x + 40, ar.position.y + 114, 160, 24), "닫기", "ask_close", C["dim"])


func _draw_pause() -> void:
	draw_rect(Rect2(Vector2.ZERO, VIEW), Color(0.02, 0.01, 0.04, 0.7))
	if pause_settings:
		_draw_settings_panel()
		return
	var pr := Rect2(200, 100, 240, 200)
	panel(pr)
	text(Vector2(pr.position.x, pr.position.y + 34), "일시정지", UI["gold"], 24, pr.size.x, HORIZONTAL_ALIGNMENT_CENTER)
	var in_battle: bool = state in ["battle", "battle_end"]
	if pause_ask == "title":
		text(Vector2(pr.position.x, pr.position.y + 66), "처음 화면으로 갈까요?", C["text"], 12, pr.size.x, HORIZONTAL_ALIGNMENT_CENTER)
		var note: String = "판은 저장됩니다 · 이 밤은 아침(배치)부터 다시" if in_battle else "판은 저장됩니다 · '게임 시작'에서 이어하기"
		text(Vector2(pr.position.x, pr.position.y + 86), note, UI["muted"], 12, pr.size.x, HORIZONTAL_ALIGNMENT_CENTER)
		button(Rect2(pr.position.x + 24, pr.position.y + 120, 90, 28), "처음 화면으로", "pz_yes", UI["gold"], true, true)
		button(Rect2(pr.position.x + 126, pr.position.y + 120, 90, 28), "아니요", "pz_no", C["dim"])
		return
	text(Vector2(pr.position.x, pr.position.y + 56), "챕터 %d · %s %d" % [run.chapter, "밤" if in_battle else "아침", fought.y if in_battle else run.night], UI["muted"], 12, pr.size.x, HORIZONTAL_ALIGNMENT_CENTER)
	button(Rect2(pr.position.x + 40, pr.position.y + 72, 160, 30), "계속하기  (Esc)", "pz_resume", UI["gold"], true, true)
	button(Rect2(pr.position.x + 40, pr.position.y + 110, 160, 26), "환경설정", "pz_settings", UI["gold"])
	button(Rect2(pr.position.x + 40, pr.position.y + 144, 160, 26), "저장하고 처음 화면으로", "pz_title", UI["gold"])


func _load_opts() -> void:
	var cf := ConfigFile.new()
	if cf.load(OPT_FILE) == OK:
		for k in opt:
			opt[k] = cf.get_value("opt", k, opt[k])
	_apply_opts()


func _save_opts() -> void:
	var cf := ConfigFile.new()
	for k in opt:
		cf.set_value("opt", k, opt[k])
	cf.save(OPT_FILE)


func _apply_opts() -> void:
	shake_on = opt["shake"]
	numbers_on = opt["numbers"]
	music_vol = float(opt["music"])
	sfx_vol = float(opt["sound"])
	tutorial_enabled = opt["tutorial"]
	if DisplayServer.get_name() != "headless":
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if opt["fullscreen"] else DisplayServer.WINDOW_MODE_WINDOWED)


const OPT_ROWS := [
	["music", "음악", ["끄기", "작게", "보통", "크게"], [0.0, 0.35, 0.7, 1.0]],
	["sound", "효과음", ["끄기", "작게", "보통", "크게"], [0.0, 0.35, 0.7, 1.0]],
	["fullscreen", "화면", ["창 모드", "전체 화면"], [false, true]],
	["speed", "전투 속도", ["보통 ×1", "빠르게 ×2"], [1, 2]],
	["shake", "화면 흔들림", ["끄기", "켜기"], [false, true]],
	["numbers", "피해 숫자", ["끄기", "켜기"], [false, true]],
	["tutorial", "처음 안내", ["끄기", "켜기"], [false, true]],
]


func _opt_index(row: Array) -> int:
	var vals: Array = row[3]
	var v = opt[row[0]]
	var best := 0
	for i in vals.size():
		if typeof(vals[i]) == TYPE_BOOL:
			if bool(v) == vals[i]:
				return i
		elif absf(float(vals[i]) - float(v)) < absf(float(vals[best]) - float(v)):
			best = i
	return best


func _settings_input() -> void:
	if clicked("back") or pressed(KEY_ESCAPE):
		if pause_settings:
			pause_settings = false
		else:
			state = "title"
		return
	for row in OPT_ROWS:
		for i in row[2].size():
			if clicked("opt_%s_%d" % [row[0], i]):
				opt[row[0]] = row[3][i]
				_apply_opts()
				_save_opts()
				if row[0] == "sound":
					sfx("confirm")
	if clicked("opt_rename") and not pause_settings:
		_open_naming("settings")
		return
	if clicked("opt_tut_reset"):
		tut_seen.clear()
		DirAccess.remove_absolute(ProjectSettings.globalize_path(TUT_FILE))
		show_banner("처음 안내를 다시 보여 줍니다", "", UI["gold"], 60)


func _draw_settings() -> void:
	_draw_title_bg_only()
	draw_rect(Rect2(Vector2.ZERO, VIEW), Color(0, 0, 0, 0.55))
	_draw_settings_panel()


func _draw_settings_panel() -> void:
	var pr := Rect2(130, 24, 380, 352)
	panel(pr)
	button(Rect2(pr.position.x + 10, pr.position.y + 10, 70, 22), "‹ 뒤로", "back", UI["gold"])
	text(Vector2(pr.position.x, pr.position.y + 30), "환경설정", UI["gold"], 24, pr.size.x, HORIZONTAL_ALIGNMENT_CENTER)
	for r in OPT_ROWS.size():
		var row: Array = OPT_ROWS[r]
		var y: float = pr.position.y + 52 + r * 36
		text(Vector2(pr.position.x + 20, y + 17), row[1], UI["muted"])
		var cur := _opt_index(row)
		var n: int = row[2].size()
		var w: float = (260.0 - (n - 1) * 6.0) / n
		for i in n:
			button(Rect2(pr.position.x + 104 + i * (w + 6.0), y, w, 24), row[2][i], "opt_%s_%d" % [row[0], i], UI["gold"] if i == cur else C["dim"], true, i == cur)
	button(Rect2(pr.position.x + 104, pr.position.y + 310, 126, 22), "처음 안내 다시 보기", "opt_tut_reset", C["dim"])
	if not pause_settings:
		button(Rect2(pr.position.x + 238, pr.position.y + 310, 126, 22), "군주 이름 바꾸기", "opt_rename", C["dim"])


## 처음 화면 배경만 (제목·버튼 없이) — 환경설정·랭킹 뒤에
func _draw_title_bg_only() -> void:
	var far := tex("ui/title_far")
	if far == null:
		for i in 10:
			draw_rect(Rect2(0, i * 40, 640, 40), Color("0b0a14").lerp(Color("2a1a30"), i / 10.0))
		return
	var sway: float = sin(t * 0.004)
	_draw_layer_fit(far, Vector2(sway * 12.0, 0))
	var mid := tex("ui/title_mid")
	if mid != null:
		_draw_layer_fit(mid, Vector2(sway * 24.0, 0))


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
	run = KilnRun.new(int(Time.get_unix_time_from_system()), meta.effects() if meta != null else {})
	if PD.DEMO:
		run.last_chapter = PD.DEMO_LAST_CHAPTER
	kiln = run.kiln
	state = "prep"
	selected = -1
	battle = null


## 일시정지 창을 여는 화면 (Esc). 상점·뽑기·대기실 등은 Esc 가 로비로 돌아가기라 그대로 둔다
const PAUSE_STATES := ["prep", "deploy", "battle", "battle_end", "night_end", "fire", "load", "reveal"]


## 화면마다 배경 음악: 낮(로비·가마·상점) = lobby, 밤 = battle, 최종 보스 밤 = boss. 밤 결과 창은 짧은 가락만
func _pick_music() -> void:
	if state in ["deploy", "battle"]:
		# 챕터마다 다른 노래 (2026-12-01 "챕터마다 노래가 달라야 해")
		var ch: int = run.chapter if run != null else 1
		var nm: String = ("boss_%d" if battle != null and battle.boss_stage else "battle_%d") % ch
		if not ResourceLoader.exists("res://assets/audio/music/%s.ogg" % nm):
			nm = "boss" if battle != null and battle.boss_stage else "battle"
		music(nm)
	elif state in ["battle_end", "night_end"]:
		pass
	else:
		music("lobby")


func _physics_process(_d: float) -> void:
	_pick_music()
	# 일시정지 (2026-11-28 "esc키로 인한 판 사라짐"): Esc 는 바로 나가지 않고 창을 연다. 그동안 모든 것이 멈춘다
	if paused:
		_pause_input()
		queue_redraw()
		end_input()
		return
	if pressed(KEY_ESCAPE) and state in PAUSE_STATES and not show_help and not promo_pick and pause_ok():
		paused = true
		pause_ask = ""
		sfx("pause")
		queue_redraw()
		end_input()
		return
	match state:
		"title":
			# 처음 화면은 게임 시작 · 랭킹 · 환경설정 셋만 (2026-11-28 사용자). 전술 강화·도감은 로비에서
			if start_ask:
				if clicked("cont") or pressed(KEY_ENTER) or pressed(KEY_KP_ENTER):
					start_ask = false
					_continue_run()
				elif clicked("fresh"):
					start_ask = false
					KilnRun.clear_save()
					_new_run()
					_save_run()
				elif clicked("ask_close") or pressed(KEY_ESCAPE):
					start_ask = false
			elif (clicked("start") or pressed(KEY_ENTER) or pressed(KEY_KP_ENTER)) and meta.lord_name == "":
				_open_naming("title")
			elif clicked("lord_badge"):
				_open_naming("title")
			elif clicked("start") or pressed(KEY_ENTER) or pressed(KEY_KP_ENTER):
				if KilnRun.has_save():
					start_ask = true
				else:
					_new_run()
					_save_run()
			elif clicked("to_records"):
				state = "records"
			elif clicked("to_settings"):
				state = "settings"
		"settings":
			_settings_input()
		"naming":
			_naming_input()
		"meta":
			_meta_input()
		"barracks":
			_barracks_input()
		"codex", "combo" when not preview.is_empty():
			_preview_tick()
		"codex":
			if clicked("codex_back") or pressed(KEY_ESCAPE):
				state = codex_from
			for tb in ["unit", "skill", "combo", "rule"]:
				if clicked("ctab_" + tb):
					codex_tab = tb
			for r in PD.KILN_ROLES:
				if clicked("crole_" + r):
					codex_role = r
			for e in PD.ELEMENTS:
				if clicked("pv_skill_" + e):
					_preview_start("skill", codex_role, e, "")
			for id in PD.COMBOS:
				if clicked("pv_combo_" + id):
					_preview_start("combo", "", "", id)
		"combo":
			if clicked("lobby") or pressed(KEY_ESCAPE):
				state = "prep"
			for id in PD.COMBOS:
				if clicked("pv_combo_" + id):
					_preview_start("combo", "", "", id)
				elif clicked("cb_" + id):
					run.set_combo(id if run.combo != id else "")
		"records":
			if clicked("back") or pressed(KEY_ESCAPE):
				state = "title"
		"prep", "gacha", "shop", "equip":
			_prep_input()
			for i in drawn_at:
				if not popped.has(i) and t >= drawn_at[i] and i < run.queue.size():
					popped[i] = true
					if state == "gacha":
						var bp := _bench_pos(i, run.queue.size())
						burst(bp + Vector2(0, 8), CLAY_TONES[2], 12, 2.2, 2.0)
						shake = maxf(shake, 1.5)
						sfx("clay", 0.8, 0.12)
		"load":
			_tick_fire()
			load_t += 1
			var nq: int = run.queue.size()
			for i in nq:
				if load_t == _load_start(i) + LOAD_FLY:
					var dc := _door_screen_box(FIRE_O).get_center()
					burst(dc + Vector2(0, 30), CLAY_TONES[3], 10, 2.0, 2.0)
					shake = maxf(shake, 2.0)
					sfx("kiln_load", 0.8, 0.1)
			if load_t >= _load_start(nq - 1) + LOAD_FLY + 16:
				state = "fire"
		"fire":
			_tick_fire()
			if (pressed(KEY_SPACE) or clicked("heat")) and kiln.heat < PD.KILN_MAX_HEAT:
				kiln.heat_up()
				shake = maxf(shake, 1.0 + kiln.heat * 0.4)
				sfx("fire", 0.6 + kiln.heat * 0.06, 0.03)
				var bx := _door_screen_box(FIRE_O)
				for i in 8 + kiln.heat * 2:
					flames.append({"pos": Vector2(bx.position.x + bx.size.x * randf_range(0.1, 0.9), bx.end.y - randf_range(2.0, 14.0)),
						"vel": Vector2(randf_range(-0.6, 0.6), -randf_range(1.4, 2.6)), "t": 0, "life": randi_range(18, 30), "size": randf_range(10.0, 16.0)})
			if clicked("bet"):
				bet_on = not bet_on
			if pressed(KEY_ENTER) or pressed(KEY_KP_ENTER) or clicked("open"):
				sfx("fire", 1.0)
				kiln.results = run.fire(bet_on)
				bet_on = false
				bet_told = false
				gfx = {}
				gfx_done = {}
				card_at = {}
				drawn_at.clear()
				popped.clear()
				state = "reveal"
				reveal_t = 0
				reveal_shown = 0
		"reveal":
			if not gfx.is_empty():
				_gfx_tick()
			else:
				reveal_t += 1
				if reveal_t == 24 or reveal_t == 44:
					shake = maxf(shake, 4.0)
				if reveal_t == 24 or reveal_t == 44:
					sfx("crackle", 0.8)
				if reveal_t == OPEN_T - 6:
					sfx("crack")
					do_flash(NEUTRAL, 16)
					shake = maxf(shake, 7.0)
				var due := (reveal_t - OPEN_T) / CARD_GAP + 1 if reveal_t >= OPEN_T else 0
				while reveal_shown < kiln.results.size():
					var rr: Dictionary = kiln.results[reveal_shown]
					if rr["cracked"]:
						_reveal_one(reveal_shown)   # 깨진 인형은 카드 없이 아래 줄에 센다
						reveal_shown += 1
						continue
					if _cards_before(reveal_shown) >= due:
						break
					var gg: String = PD.ROLE_GRADE.get(rr["role"], "common")
					if not rr.get("refire", false) and GFX_TAPS.has(gg) and not gfx_done.has(reveal_shown):
						gfx = {"i": reveal_shown, "grade": gg, "need": GFX_TAPS[gg], "taps": 0, "phase": "tap", "t": 0, "rays": _crack_rays(reveal_shown * 37 + t)}
						banner = {}
						floats.clear()
						break
					_reveal_one(reveal_shown)
					reveal_shown += 1
			if reveal_shown >= kiln.results.size() and not bet_told and not run.last_bet.is_empty():
				bet_told = true
				var bk: String = run.last_bet["key"]
				var good: bool = bk != "bust"
				show_banner("가마신: %s!" % run.last_bet["name"], run.last_bet["desc"], C["accent"] if good else C["danger"], 110)
				sfx("reveal_legend" if bk == "jackpot" else ("coin" if good else "deny"))
				do_flash(C["accent"] if good else C["danger"], 16 if bk == "jackpot" else 8)
				shake = maxf(shake, 10.0 if bk == "jackpot" else 4.0)
				burst(Vector2(320, 200), C["accent"] if good else C["dim"], 40 if bk == "jackpot" else 16, 4.0, 3.0)
			if reveal_shown >= kiln.results.size() and (pressed(KEY_ENTER) or pressed(KEY_KP_ENTER) or clicked("fight")):
				state = "gacha"   # 구운 뒤에도 가마 앞에 그대로 (2026-11-28 사용자 요청)
				banner = {}
		"deploy":
			_deploy_input()
		"battle":
			if battle.pending != "":
				_pending_input()
			else:
				_tip_input()
			step_battle()
			if int(opt["speed"]) >= 2 and battle.pending == "" and not battle.done:
				step_battle()   # 환경설정: 전투 속도 ×2
			if battle.done:
				var stars_before: int = run.embers_earned
				run.end_night(battle)
				# 불씨: ★3 으로 넘긴 밤마다 1개, 바로 전술 강화에 쌓인다
				last_embers = run.embers_earned - stars_before
				meta.embers += last_embers
				state = "battle_end"
				end_wait = 48
				music("")
				sfx("lose" if run.state == "lost" else ("chapter_clear" if (run.chapter_cleared or run.state == "won") else "win"))
				banner = {}
				last_rank = -1
				if run.chapter_cleared or run.state == "won":
					last_rank = meta.add_record(fought.x, run.last_chapter_time, "%d명" % run.army.size())
				if run.state in ["lost", "won"]:
					KilnRun.clear_save()
					meta.lord_exp += run.nights_cleared   # 군주 단계: 넘긴 밤만큼
					new_best = meta.note_run(fought.x, fought.y, run.total_kills, run.state == "won")
				meta.save()
		"battle_end":
			end_wait -= 1
			if end_wait <= 0:
				state = "night_end"
				cutin = {}
				end_t = 0
				floats.clear()
		"night_end":
			end_t += 1
			if end_t == 20:
				shake = maxf(shake, 9.0)
			if end_t < 56:
				pass
			elif pressed(KEY_ENTER) or pressed(KEY_KP_ENTER) or clicked("next"):
				if run.state == "prep":
					state = "prep"
					battle = null
					selected = -1
					_save_run()   # 아침마다 저장
				else:
					battle = null
					KilnRun.clear_save()   # 판이 끝났다
					state = "title"
			elif clicked("to_meta2"):
				battle = null
				meta_from = "title"
				state = "meta"
	draw_flash = maxi(0, draw_flash - 1)
	tick_fx()
	queue_redraw()
	end_input()


## 전술 강화: 왼쪽 가마터에서 시작해 오른쪽으로 (가지마다 한 줄)
const META_ROW := {"core": 78.0, "army": 123.0, "supply": 168.0, "unit": 213.0, "shop": 258.0, "kiln": 303.0, "combo": 348.0}
const META_W := 88.0
## 칸 자리: 가지마다 왼쪽부터 NODES 순서대로 (94px 간격)
static func _meta_pos() -> Dictionary:
	var out := {"core": Vector2(62, 213)}
	var n_in := {}
	for id in Meta.NODES:
		var br: String = Meta.NODES[id]["branch"]
		if id == "core":
			continue
		var k: int = n_in.get(br, 0)
		n_in[br] = k + 1
		out[id] = Vector2(190 + k * 94, META_ROW[br])
	return out
var META_POS: Dictionary = _meta_pos()
const META_ICON := {"core": "clay", "wall": "armor", "repair": "scroll", "beacon": "fire", "command": "ticket", "recruit": "scroll", "drill": "scroll", "mend": "gourd", "bulwark": "armor",
	"night_clay": "clay", "hunter": "pearl", "aura": "shard", "c_heal": "gourd", "clay": "clay", "ticket": "ticket", "night_pearl": "pearl", "bounty": "ticket",
	"purse": "pearl", "reroll": "scale", "haggle": "pearl", "train": "blade", "tough": "armor", "swift": "whetstone", "eagle": "charm", "focus": "scroll",
	"fire": "fire", "glaze": "gourd", "shard": "shard", "favor": "bell", "c_pow": "fire", "c_cd": "bell", "c_first": "ember"}


func _meta_input() -> void:
	if clicked("back") or pressed(KEY_ESCAPE):
		state = meta_from
		return
	for id in META_POS:
		if clicked("node_" + id):
			if meta.buy(id):
				meta.save()
				burst(META_POS[id], C["accent"], 20, 3.0, 2.0)
				shake = 3.0
			else:
				float_text(META_POS[id] + Vector2(-30, -30), "불씨 부족" if meta.cost(id) > meta.embers else ("최대" if meta.cost(id) < 0 else "앞 칸 먼저"), C["danger"])


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
	if clicked("go_gacha"):
		state = "gacha"
		return
	if clicked("go_combo"):
		state = "combo"
		return
	if clicked("go_codex"):
		codex_from = "prep"
		state = "codex"
		return
	if clicked("rd_merge") and not run.merge_groups().is_empty():
		var g0: Array = run.merge_groups()[0]
		var pick: int = g0[0]
		for id in g0:
			if run.in_army(id):
				pick = id
				break
		if run.in_army(pick):
			selected = pick
			army_page = run.army.find(run.soldier(pick)) / 18
		else:
			state = "barracks"   # 대기실에 있는 병사들 → 대기실에서 모두 합치기
		return
	if clicked("rd_promo") and not _promo_ready().is_empty():
		var pid: int = _promo_ready()[0]
		if run.in_army(pid):
			selected = pid
			promo_pick = true
			army_page = run.army.find(run.soldier(pid)) / 18
		else:
			state = "barracks"
		return
	if clicked("go_barracks"):
		state = "barracks"
		res_pick = -1
		return
	if clicked("go_meta"):
		meta_from = "prep"
		state = "meta"
		return
	if clicked("go_shop"):
		state = "shop"
		return
	if clicked("go_equip"):
		state = "equip"
		_tut_done("equip")
		return
	if clicked("lobby") or (state != "prep" and pressed(KEY_ESCAPE)):
		state = "prep"
		return
	if state == "shop" and shop_pick >= 0:
		# 누구에게 줄지 고르는 창
		if clicked("pick_cancel") or pressed(KEY_ESCAPE):
			shop_pick = -1
			return
		for sd in run.army:
			if clicked("card%d" % sd["id"]):
				var key: String = run.shop[shop_pick]
				if run.buy(shop_pick, sd["id"]):
					sfx("coin")
					float_text(Vector2(250, 120), "%s → %s" % [PD.SHOP_ITEMS[key]["name"], sd["name"]], C["accent"])
					burst(Vector2(320, 200), UI["gold"], 18, 2.5, 2.0)
					shake = 2.0
				else:
					float_text(Vector2(250, 120), "진주 부족" if run.pearls < run.price(key) else "더 못 올림", C["danger"])
				shop_pick = -1
				return
		return
	if state == "shop" and shop_table:
		if clicked("table_close") or clicked("shop_table") or pressed(KEY_ESCAPE):
			shop_table = false
		return
	if state == "shop":
		if clicked("shop_table"):
			shop_table = true
			return
		if clicked("reroll"):
			run.reroll_shop()
		for i in run.shop.size():
			if clicked("shop%d" % i) and run.shop[i] != "":
				var it: Dictionary = PD.SHOP_ITEMS[run.shop[i]]
				if it["stat"] != "ticket" and it["stat"] != "equip":
					if run.pearls < run.price(run.shop[i]):
						float_text(Vector2(360, 120), "진주 부족", C["danger"])
					else:
						shop_pick = i
				elif run.buy(i, -1):
					sfx("coin")
					float_text(Vector2(440, 150), ("%s → 가방" % KilnRun.equip_name(run.last_bought)) if it["stat"] == "equip" else "%s!" % it["name"], C["accent"])
					burst(Vector2(470, 180), UI["gold"], 16, 2.5, 2.0)
					shake = 2.0
				else:
					float_text(Vector2(440, 150), "진주 부족" if run.pearls < run.price(run.shop[i]) else "더 못 올림", C["danger"])
	if state == "equip":
		if clicked("inv_prev"):
			inv_page = maxi(0, inv_page - 1)
		if clicked("inv_next"):
			inv_page += 1
	if state == "equip" and selected >= 0:
		if clicked("uneq"):
			run.unequip(selected)
		for i in run.inventory.size():
			if clicked("eq%d" % i):
				run.equip(selected, run.inventory[i]["id"])
				sfx("equip")
				shake = 2.0
				break
	if selected >= 0 and clicked("promo"):
		promo_pick = not promo_pick
	for s in run.army:
		if clicked("card%d" % s["id"]):
			if promo_pick and run.can_promote(selected, s["id"]):
				var m: Dictionary = run.promote(selected, s["id"])
				sfx("reveal_legend")
				show_banner("전직! %s" % m["name"], "흡수한 스킬: %s" % PD.skill_name(m["promo"], m["element"]), C["accent"], 100)
				do_flash(C["accent"], 14)
				shake = 6.0
				promo_pick = false
				return
			promo_pick = false
			release_armed = -1
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
				sfx("star_up")
				float_text(Vector2(150, 150), "합치기! %s %s" % [m["name"], "★".repeat(m["star"])], C["accent"], 24)
				shake = 4.0
			break
	if state == "gacha":
		for d2 in [["draw1", 1], ["draw10", 10], ["drawall", 999]]:
			if clicked(d2[0]):
				_do_draws(mini(d2[1], run.draws_left()))
				_tut_done("draw")
	if clicked("pg_prev"):
		army_page = maxi(0, army_page - 1)
	if clicked("pg_next"):
		army_page += 1
	if selected >= 0 and clicked("release"):
		if release_armed == selected:
			var rs: Dictionary = run.soldier(selected)
			if run.release(selected):
				float_text(Vector2(150, 300), "%s 돌려보냄 · 흙 +%d" % [rs["name"], PD.CLAY_SMASH_BACK], UI["muted"])
				selected = -1
			release_armed = -1
		else:
			release_armed = selected
		return
	if clicked("uq_last") and not run.queue.is_empty():
		run.unqueue(run.queue.size() - 1)
		drawn_at.clear()
		popped.clear()
	for i in run.queue.size():
		if clicked("uq%d" % i):
			run.unqueue(i)
			drawn_at.clear()
			popped.clear()
			break
	if not run.queue.is_empty() and (clicked("fire_go") or pressed(KEY_SPACE)):
		state = "load"
		load_t = 0
		banner = {}
		_tut_done("fire")
	elif state == "prep" and run.can_start_night() and (clicked("night_go") or pressed(KEY_ENTER) or pressed(KEY_KP_ENTER)):
		_tut_done("full")
		_open_deploy()


## 배치 화면 열기: 전장에 병사를 미리 세워 두고 끌어서 옮긴다 (전투는 아직 안 돈다)
func _open_deploy() -> void:
	cutin = {}
	battle = run.start_night()
	run.state = "prep"
	_map_units()
	uv.clear()
	tip_sid = -1
	drag_id = -1
	state = "deploy"


func _map_units() -> void:
	unit_sid.clear()
	var allies: Array = battle.units.filter(func(u): return u.team == "ally")
	for i in mini(allies.size(), run.army.size()):
		unit_sid[allies[i].id] = run.army[i]["id"]


func _unit_at(fp: Vector2):
	var best = null
	var bd := 22.0
	for u in battle.units:
		if u.alive and u.team == "ally" and u.pos.distance_to(fp + Vector2(0, 6)) < bd:
			bd = u.pos.distance_to(fp + Vector2(0, 6))
			best = u
	return best


func _deploy_input() -> void:
	var mp: Vector2 = get_local_mouse_position() - FIELD_OFFSET
	var down: bool = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	if down and not mouse_was:
		var u = _unit_at(mp)
		if u != null:
			drag_id = u.id
			drag_from = mp
	if down and drag_id >= 0:
		for u in battle.units:
			if u.id == drag_id:
				var r: Rect2 = battle.DEPLOY
				u.pos = Vector2(clampf(mp.x, r.position.x, r.end.x), clampf(mp.y, r.position.y, r.end.y))
				u.home = u.pos
	if not down and mouse_was and drag_id >= 0:
		var sid: int = unit_sid.get(drag_id, -1)
		if mp.distance_to(drag_from) < 4.0:
			tip_sid = sid if tip_sid != sid else -1      # 그냥 누르면 정보창
		else:
			for u in battle.units:
				if u.id == drag_id:
					run.set_home(sid, u.pos)
			shake = 1.0
		drag_id = -1
	elif not down and mouse_was and drag_id < 0 and not buttons.any(func(b): return b["rect"].has_point(get_local_mouse_position())):
		tip_sid = -1
	mouse_was = down
	if clicked("auto"):
		for sd in run.army:
			run.set_home(sd["id"], null)
		_open_deploy()
	if clicked("deploy_back"):
		battle = null
		state = "prep"
	elif clicked("go") or pressed(KEY_ENTER) or pressed(KEY_KP_ENTER):
		_start_battle()


func _start_battle() -> void:
	_save_run()   # 밤 직전에 저장: 전투 중에 나가면 이 밤의 아침(배치까지)부터 다시
	fought = Vector2i(run.chapter, run.night)
	battle = run.start_night()
	_map_units()
	boss_seen.clear()
	uv.clear()
	tip_sid = -1
	state = "battle"
	var ci: Dictionary = run.chapter_info()
	if run.night == 1:
		var nw: String = ci["new"]
		show_banner("챕터 %d · %s" % [run.chapter, ci["name"]], ("새 적: %s · " % PD.ENEMIES[nw]["name"] if nw != "" else "") + "다섯째 밤에 %s" % PD.ENEMIES[ci["boss"]]["name"], C["accent"], 110)


## 전투 중 끌기: 병사에서 손가락까지 점선 + 도착 표시, 이동 중인 병사의 목적지
func _draw_move_hint() -> void:
	for u in battle.units:
		if u.team == "ally" and u.alive and u.move_t > 0:
			var hp: Vector2 = u.home + FIELD_OFFSET
			draw_arc(hp, 6.0, 0.0, TAU, 16, Color(1.0, 0.85, 0.4, 0.6), 1.0)
	if drag_id < 0:
		return
	var mp: Vector2 = get_local_mouse_position()
	if (mp - FIELD_OFFSET).distance_to(drag_from) < 6.0:
		return
	for u in battle.units:
		if u.id == drag_id:
			var a: Vector2 = u.pos + FIELD_OFFSET
			var n := int(a.distance_to(mp) / 6.0)
			for i in n:
				if i % 2 == 0:
					draw_line(a.lerp(mp, float(i) / n), a.lerp(mp, float(i + 1) / n), UI["gold"], 1.0)
			draw_arc(mp, 8.0 + sin(t * 0.3), 0.0, TAU, 20, UI["gold"], 1.5)
			text(mp + Vector2(10, -6), "이동", UI["gold"])


## 등장 연출 진행: 두드리기(누르기·스페이스) → 빛기둥 → 등장 → 누르면 다음
func _gfx_tick() -> void:
	gfx["t"] += 1
	var tap: bool = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not mouse_was or pressed(KEY_SPACE) or pressed(KEY_ENTER)
	mouse_was = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	var gc: Color = GRADE_COL[gfx["grade"]]
	var c := GFX_C
	match gfx["phase"]:
		"tap":
			if tap and gfx["t"] > 8:
				gfx["taps"] += 1
				gfx["t"] = 0
				sfx("clay_crack_%d" % mini(3, gfx["taps"]), 1.0, 0.04)
				shake = maxf(shake, 3.0 + gfx["taps"] * 2.5)
				# 금이 간 자리에서 흙 부스러기가 떨어진다
				var rays: Array = gfx["rays"]
				for ri in _rays_shown(gfx["taps"]):
					var ray: Array = rays[ri]
					for j in range(1, ray.size()):
						fx.append({"pos": ray[j], "vel": Vector2(randf_range(-1.0, 1.0), randf_range(-1.5, 0.5)), "t": 30, "life": 30, "color": CLAY_TONES[randi() % 3], "size": randf_range(2.0, 4.0)})
				if gfx["taps"] >= gfx["need"]:
					gfx["phase"] = "burst"
					gfx["t"] = 0
					gfx["shards"] = _make_shards(gfx["rays"])
					sfx("reveal_boom")
					do_flash(NEUTRAL, 22)
					shake = maxf(shake, 14.0)
					hitstop = 0
					burst(c, CLAY_TONES[2], 40, 5.5, 3.0)
					burst(c, CLAY_TONES[1], 24, 4.0, 3.5)
		"burst":
			if gfx["t"] == 14:
				sfx("reveal_" + {"hero": "hero", "legendary": "legend", "mythic": "mythic"}.get(gfx["grade"], "rare"))
				burst(c, gc.lightened(0.3), 40, 5.0, 2.5)   # 겉흙이 다 떨어진 뒤에야 등급 빛
			if gfx["t"] > 44:
				gfx["phase"] = "show"
				gfx["t"] = 0
		"show":
			if tap and gfx["t"] > 20:
				var i: int = gfx["i"]
				gfx_done[i] = true
				_reveal_one(i)
				reveal_shown = i + 1
				reveal_t = OPEN_T + CARD_GAP * _cards_before(reveal_shown) - 10
				gfx = {}


const GFX_C := Vector2(320, 176)
const CLAY_C := Vector2(320, 186)    # 큰 흙덩이(×5) 가운데
const CLAY_R := Vector2(40, 52)      # 흙덩이 둘레 (타원 반지름)


## 희귀 이상 등장: 흙 인형의 겉흙에 금이 가고(등급 색 없이 흰빛), 다 깨지면 그제야 등급 빛과 함께 병사가 드러난다
func _draw_gfx() -> void:
	var gc: Color = GRADE_COL[gfx["grade"]]
	var r: Dictionary = kiln.results[gfx["i"]]
	var c := GFX_C
	var gt: int = gfx["t"]
	draw_rect(Rect2(Vector2.ZERO, VIEW), Color(0.02, 0.015, 0.03, 0.95))
	match gfx["phase"]:
		"tap":
			var k: float = float(gfx["taps"]) / gfx["need"]
			var jit := Vector2(sin(t * 2.1) * maxf(0.0, 8.0 - gt) * 0.5, 0)
			glow(self, c + Vector2(0, 20), 80.0 + 50.0 * k, Color(NEUTRAL.r, NEUTRAL.g, NEUTRAL.b, 0.08 + 0.18 * k))
			glow(self, c + Vector2(0, 66), 50.0, Color(0, 0, 0, 0.5), 0.25)
			draw_clay(c + Vector2(0, 2) + jit, r["role"], 5.0)
			# 금 (2026-12-01 "진짜 흙이 갈라지듯"): 가운데서 갈라져 나가는 틈. 틈은 안쪽이 어둡고, 한쪽 턱은 밝게 깨진 단면,
			# 두드릴수록 틈이 벌어지고 그 사이로 빛이 샌다
			var shown: Array = _rays_shown(gfx["taps"])
			var open_k: float = float(gfx["taps"]) / gfx["need"]
			for ri in shown:
				var ray: Array = gfx["rays"][ri]
				for j in ray.size() - 1:
					var a0: Vector2 = ray[j] + jit
					var a1: Vector2 = ray[j + 1] + jit
					var wd: float = lerpf(6.0, 1.5, float(j) / (ray.size() - 1)) * (0.7 + 0.6 * open_k)
					var nrm: Vector2 = (a1 - a0).normalized().orthogonal()
					draw_line(a0 + nrm * wd * 0.6, a1 + nrm * wd * 0.6, CLAY_TONES[3].lightened(0.15), maxf(1.0, wd * 0.5))   # 깨진 턱 (밝은 단면)
					draw_line(a0, a1, Color("1a0f08"), wd)                                                                  # 틈 (어둠)
					draw_line(a0, a1, Color(NEUTRAL.r, NEUTRAL.g, NEUTRAL.b, 0.25 + 0.6 * open_k), maxf(1.0, wd * 0.35))   # 새는 빛
				glow(self, ray[1] + jit, 14.0 + 16.0 * open_k, Color(NEUTRAL.r, NEUTRAL.g, NEUTRAL.b, 0.18 + 0.25 * open_k))
			if not shown.is_empty():
				glow(self, gfx["rays"][0][0] + jit, 20.0 + 30.0 * open_k, Color(NEUTRAL.r, NEUTRAL.g, NEUTRAL.b, 0.3 + 0.3 * open_k))
			var msg := "두드려서 겉흙을 깨세요"
			text(Vector2(0, 318), msg, NEUTRAL, 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
			for i in gfx["need"]:
				var dp := Vector2(320 + (i - (gfx["need"] - 1) / 2.0) * 14.0, 332)
				draw_circle(dp, 3.5, NEUTRAL if i < gfx["taps"] else Color(1, 1, 1, 0.18))
		"burst":
			var k2: float = clampf((gt - 10) / 30.0, 0.0, 1.0)
			if gt < 8:
				draw_rect(Rect2(Vector2.ZERO, VIEW), Color(1.0, 0.95, 0.86, 0.9 * (1.0 - gt / 8.0)))
			_draw_rays(c, gc, 0.16 * k2)
			glow(self, c, 60.0 + 110.0 * k2, Color(gc.r, gc.g, gc.b, 0.45 * k2))
			# 두둥: 병사가 살짝 커졌다 자리 잡는다
			var pop: float = 1.0 + 0.25 * maxf(0.0, 1.0 - gt / 10.0)
			draw_ally_shape(c + Vector2(0, 4), r["role"], r["element"], r["tier"], 4.0 * pop, gt < 18)
			_draw_shards(gfx.get("shards", []), gt)
		"show":
			var k3: float = clampf(gt / 16.0, 0.0, 1.0)
			_draw_rays(c, gc, 0.11)
			glow(self, c, 150.0, Color(gc.r, gc.g, gc.b, 0.28))
			glow(self, c + Vector2(0, 58), 46.0, Color(0, 0, 0, 0.5), 0.25)
			draw_ally_shape(c + Vector2(0, 4 + sin(t * 0.08) * 2.0), r["role"], r["element"], r["tier"], 4.0)
			var card := Rect2(180, 252 + (1.0 - _ease_back(k3)) * 24.0, 280, 72)
			rrect(Rect2(card.position + Vector2(0, 3), card.size), Color(0, 0, 0, 0.5))
			if not nine("card_9", card, 6, Color.WHITE.lerp(gc, 0.6)):
				rrect(card, UI["lacquer"])
				rline(card, gc)
			text(card.position + Vector2(0, 18), PD.GRADE_NAME[gfx["grade"]], gc, 12, card.size.x, HORIZONTAL_ALIGNMENT_CENTER)
			text(card.position + Vector2(0, 44), r["name"], gc, 24, card.size.x, HORIZONTAL_ALIGNMENT_CENTER)
			text(card.position + Vector2(0, 62), fit("%s — %s" % [PD.skill_name(r["role"], r["element"]), PD.skill_info(r["role"], r["element"], 0)["desc"]], 260.0), C["text"], 12, card.size.x, HORIZONTAL_ALIGNMENT_CENTER)
			if gt > 20:
				text(Vector2(0, 350), "눌러서 계속", UI["muted"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	# 위아래 검은 띠 (영화처럼)
	draw_rect(Rect2(0, 0, 640, 26), Color(0, 0, 0, 0.9))
	draw_rect(Rect2(0, 374, 640, 26), Color(0, 0, 0, 0.9))


func _draw_rays(c: Vector2, col: Color, a: float) -> void:
	if a <= 0.0:
		return
	for i in 14:
		var ang: float = i * TAU / 14.0 + t * 0.006
		var w: float = 0.05 + 0.03 * sin(i * 2.3)
		draw_colored_polygon(PackedVector2Array([c, c + Vector2.from_angle(ang - w) * 460.0, c + Vector2.from_angle(ang + w) * 460.0]), Color(col.r, col.g, col.b, a))


## 흙 껍질이 갈라지는 길: 가운데 한 점에서 8갈래로 꺾이며 뻗는다. 이 갈래들이 그대로 조각의 경계가 된다
func _crack_rays(seed_n: int) -> Array:
	var rng := RandomNumberGenerator.new()
	rng.seed = seed_n
	var cc := GFX_C + Vector2(rng.randf_range(-6, 6), rng.randf_range(-14, 6))
	var rays: Array = []
	var n := 8
	for i in n:
		var ang: float = i * TAU / n + rng.randf_range(-0.25, 0.25)
		var p := cc
		var pts := [cc]
		for j in 6:
			ang += rng.randf_range(-0.35, 0.35)
			p += Vector2.from_angle(ang) * rng.randf_range(9, 13)
			# 흙덩이 둘레(타원) 밖으로는 나가지 않는다 — 마지막 점은 둘레에 붙인다
			var q: Vector2 = (p - CLAY_C) / CLAY_R
			if q.length() > 0.97:
				p = CLAY_C + q.normalized() * 0.97 * CLAY_R
				pts.append(p)
				break
			pts.append(p)
		while pts.size() < 3:
			pts.append(pts[pts.size() - 1] + Vector2.from_angle(ang) * 2.0)
		rays.append(pts)
	return rays


## 두드린 횟수만큼 보이는 갈래 (1번: 3갈래 · 2번: 6갈래 · 3번: 전부)
func _rays_shown(taps: int) -> Array:
	var order := [0, 3, 6, 1, 4, 7, 2, 5]
	return order.slice(0, mini(8, [0, 3, 6, 8][clampi(taps, 0, 3)]))


## 조각: 이웃한 두 갈래 사이 = 흙 그림 한 조각 (그림 그대로 잘라 날린다)
func _make_shards(rays: Array) -> Array:
	var out: Array = []
	for i in rays.size():
		var a: Array = rays[i]
		var b: Array = rays[(i + 1) % rays.size()]
		var poly: Array = [a[0]]
		for j in range(1, a.size()):
			poly.append(a[j])
		var ae: Vector2 = a[a.size() - 1]
		var be: Vector2 = b[b.size() - 1]
		poly.append(ae + (ae - a[0]).normalized() * 40.0)
		poly.append((ae + be) / 2.0 + ((ae + be) / 2.0 - a[0]).normalized() * 50.0)
		poly.append(be + (be - b[0]).normalized() * 40.0)
		for j in range(b.size() - 1, 0, -1):
			poly.append(b[j])
		var mid: Vector2 = (a[2] + b[2]) / 2.0
		var dir: Vector2 = (mid - a[0]).normalized()
		out.append({"poly": poly, "pivot": mid, "vel": dir * randf_range(4.0, 7.0) + Vector2(0, -2.5), "spin": randf_range(-0.12, 0.12)})
	return out


func _draw_shards(shards: Array, gt: int) -> void:
	var tx := clay_tex("")
	if tx == null or shards.is_empty() or gt > 40:
		return
	var sz: Vector2 = tx.get_size() * 5.0
	var rect := Rect2(GFX_C + Vector2(0, 2) + Vector2(-sz.x / 2.0, 12.8 * 5.0 - sz.y), sz)
	var a: float = clampf(1.0 - (gt - 24) / 16.0, 0.0, 1.0)
	for sh in shards:
		var off: Vector2 = sh["vel"] * gt + Vector2(0, 0.35 * gt * gt)
		var rot: float = sh["spin"] * gt
		var pts := PackedVector2Array()
		var uvs := PackedVector2Array()
		for q in sh["poly"]:
			uvs.append((q - rect.position) / rect.size)
			pts.append(sh["pivot"] + (q - sh["pivot"]).rotated(rot) + off)
		var cols := PackedColorArray()
		for q2 in pts:
			cols.append(Color(1, 1, 1, a))
		draw_polygon(pts, cols, uvs, tx)


## 금 한 줄: 몸통 가운데 근처에서 시작해 꺾이며 뻗는다 (같은 번호면 같은 모양)
func _crack_pts(seed_n: int, c: Vector2) -> Array:
	var rng := RandomNumberGenerator.new()
	rng.seed = seed_n
	var p := c + Vector2(rng.randf_range(-14, 14), rng.randf_range(-40, 30))
	var ang := rng.randf_range(0, TAU)
	var pts := [p]
	for j in 5:
		ang += rng.randf_range(-0.9, 0.9)
		p += Vector2.from_angle(ang) * rng.randf_range(7, 12)
		p = Vector2(clampf(p.x, c.x - 26, c.x + 26), clampf(p.y, c.y - 56, c.y + 56))
		pts.append(p)
	return pts


## 전투 중 병사를 누르면 정보창 (잠깐 뒤 닫힘)
func _tip_input() -> void:
	tip_t = maxi(0, tip_t - 1)
	if tip_t == 0:
		tip_sid = -1
	var mp: Vector2 = get_local_mouse_position() - FIELD_OFFSET
	var down: bool = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	if down and not mouse_was and battle != null:
		var u = _unit_at(mp)
		drag_id = u.id if u != null else -1
		drag_from = mp
		if u == null:
			tip_sid = -1
	if not down and mouse_was and drag_id >= 0 and battle != null:
		if mp.distance_to(drag_from) < 6.0:
			tip_sid = unit_sid.get(drag_id, -1)
			tip_t = 300
		elif battle.order_move(drag_id, mp):
			rings.append({"pos": mp, "r0": 2.0, "r1": 16.0, "t": 0, "life": 16, "color": UI["gold"]})
		drag_id = -1
	mouse_was = down


## 뽑기: 흙 인형이 작업대에 하나씩 선다. 무엇이 될지는 구워야 안다 (등급을 미리 알리지 않는다)
func _do_draws(n: int) -> void:
	var made := 0
	for k in n:
		var d: Dictionary = run.draw()
		if d.is_empty():
			break
		drawn_at[run.queue.size() - 1] = t + made * (7 if n <= 10 else 3)
		made += 1
	if made > 0:
		draw_flash = 30


## 결과 i 앞에 카드가 몇 장 나왔나 (깨진 인형은 카드가 없다)
func _cards_before(n: int) -> int:
	var c := 0
	for i in mini(n, kiln.results.size()):
		if not kiln.results[i]["cracked"]:
			c += 1
	return c


func _survivors() -> Array:
	var out := []
	for i in kiln.results.size():
		if not kiln.results[i]["cracked"]:
			out.append(i)
	return out


## 카드 자리: 4장까지 한 줄, 넘으면 두 줄
func _card_pos(j: int, n: int) -> Vector2:
	if n > 8:
		# 9명 넘게: 작은 카드, 한 줄 10장까지 (최대 30명 → 3줄)
		var rows: int = (n + 9) / 10
		var per: int = (n + rows - 1) / rows
		var row2: int = j / per
		var in_row2: int = mini(per, n - row2 * per)
		return Vector2(320 + (j % per - (in_row2 - 1) / 2.0) * 62.0, 94 + row2 * 88)
	if n <= 4:
		return Vector2(320 + (j - (n - 1) / 2.0) * 128.0, 176)
	var row := j / 4
	var in_row: int = mini(4, n - row * 4)
	return Vector2(320 + (j % 4 - (in_row - 1) / 2.0) * 128.0, 114 + row * 134)


func _reveal_one(i: int) -> void:
	var r: Dictionary = kiln.results[i]
	card_at[i] = t
	if r["cracked"]:
		burst(Vector2(320, 330), CLAY_TONES[2], 10, 2.0, 2.0)
		sfx("crack", 0.6)
		return
	var surv := _survivors()
	var p := _card_pos(surv.find(i), surv.size())
	var gc: Color = GRADE_COL[PD.ROLE_GRADE.get(r["role"], "common")]
	var g1: String = PD.ROLE_GRADE.get(r["role"], "common")
	sfx({"common": "reveal_common", "uncommon": "reveal_uncommon", "rare": "reveal_rare", "hero": "reveal_hero", "legendary": "reveal_legend", "mythic": "reveal_mythic"}.get(g1, "reveal_common"), 0.9)
	if r["tier"] == "legend" and r.get("before", "") != "legend":
		sfx("reveal_legend")
		burst(p, C["accent"], 40, 4.5, 3.0)
		do_flash(C["accent"], 18)
		shake = maxf(shake, 9.0)
		show_banner("요변!", "%s — 불이 우연히 만든 귀한 빛깔 · 힘 2.6배" % r["name"], C["accent"], 90)
	elif r["tier"] == "fine" and r.get("before", "") != "fine":
		burst(p, C[r["element"]].lightened(0.4), 16, 2.5)
	else:
		burst(p, gc.lightened(0.2), 8, 1.8)


# ---------------- 그리기 ----------------
func _draw() -> void:
	buttons.clear()
	draw_screen_bg()
	match state:
		"title":
			_draw_title()
		"meta":
			_draw_meta()
		"records":
			_draw_records()
		"settings":
			_draw_settings()
		"naming":
			_draw_naming()
		"prep":
			_draw_prep()
		"barracks":
			_draw_barracks()
		"combo":
			if preview.is_empty():
				_draw_combo_pick()
			else:
				_draw_preview()
		"codex":
			if preview.is_empty():
				_draw_codex()
			else:
				_draw_preview()
		"gacha":
			_draw_gacha()
		"shop":
			_draw_shop()
		"equip":
			_draw_equip()
		"fire":
			_draw_fire()
		"load":
			_draw_fire()
			_draw_loading()
		"reveal":
			_draw_reveal()
		"deploy":
			draw_battle()
			_draw_deploy()
		"battle", "night_end", "battle_end":
			draw_battle()
			draw_battle_hud("챕터 %d %s — 밤 %d / %d" % [fought.x, PD.CHAPTERS[fought.x - 1]["name"], fought.y, PD.KILN_NIGHTS])
			if state == "night_end":
				_draw_night_end()
			elif tip_sid >= 0:
				_draw_tip_for_unit()
			if state == "battle":
				_draw_move_hint()
				if battle.pending == "draft":
					_draw_draft()
				elif battle.pending == "reinforce":
					_draw_reinforce()
	if paused:
		_draw_pause()
	if state == "title" and start_ask:
		_draw_start_ask()
	draw_fx()


## 시작 화면: 살짝 움직이는 소개 배경 (밤 · 마을 · 가마 · 행군하는 병사 · 다가오는 도깨비) + 소개 문장
const INTRO := [
	"밤마다 도깨비 떼가 마을을 덮친다.",
	"가마에서 빚어 구운 도자기 병사가 마을을 지킨다.",
	"불을 세게 올리면 요변이 — 운이 좋으면 신화가 나온다.",
	"같은 병사 셋을 합쳐 별을 올리고, 진영을 맞춰라.",
	"다섯 밤을 버티면 다음 챕터로.",
]


func _draw_title() -> void:
	# 표지 그림 (Codex, 지시서 10): 세 겹(먼 하늘·산 / 마을·가마 언덕 / 앞쪽 병사들)이 있으면 천천히 서로 다르게 흐른다
	var far := tex("ui/title_far")
	if far != null:
		var sway: float = sin(t * 0.004)
		_draw_layer_fit(far, Vector2(sway * 12.0, 0))
		var mid := tex("ui/title_mid")
		if mid != null:
			_draw_layer_fit(mid, Vector2(sway * 24.0, sin(t * 0.006) * 1.5))
		# 가마 불빛이 숨 쉬듯
		glow(self, Vector2(470 + sway * 24.0, 230), 70.0 + 8.0 * sin(t * 0.09), Color(1.0, 0.55, 0.2, 0.10 + 0.04 * sin(t * 0.13)))
		var front := tex("ui/title_front")
		if front != null:
			_draw_layer_fit(front, Vector2(sway * 40.0, 0))
		_draw_title_front(false)
		return
	var tbg := tex("ui/title_bg")
	if tbg != null:
		draw_texture_rect(tbg, Rect2(Vector2.ZERO, VIEW), false)
	for i in (0 if tbg != null else 10):
		draw_rect(Rect2(0, i * 30, 640, 30), Color("0b0a14").lerp(Color("2a1a30"), i / 10.0))
	if tbg != null:
		_draw_title_front(false)
		return
	var moon := Vector2(470, 64)
	glow(self, moon, 90.0, Color(0.9, 0.85, 0.7, 0.10))
	draw_circle(moon, 18.0, Color("efe6c8"))
	draw_circle(moon + Vector2(6, -4), 16.0, Color("e2d6b4"))
	for i in 30:
		var sp := Vector2(fmod(i * 97.0, 640.0), fmod(i * 53.0, 170.0))
		draw_rect(Rect2(sp, Vector2(1, 1)), Color(1, 1, 1, 0.3 + 0.3 * sin(t * 0.05 + i)))
	# 먼 산 (천천히 흐름)
	for layer in 2:
		var pts := PackedVector2Array()
		var off: float = fmod(t * (0.05 + layer * 0.08), 640.0)
		for k in 34:
			var x: float = k * 20.0 - off
			pts.append(Vector2(x, 220 - layer * 10 - absf(sin(x * 0.012 + layer)) * (50 - layer * 16) - sin(x * 0.04) * 6))
		pts.append(Vector2(700, 400))
		pts.append(Vector2(-20, 400))
		draw_colored_polygon(pts, Color("15121e") if layer == 0 else Color("1c1622"))
	# 땅
	draw_rect(Rect2(0, 262, 640, 138), Color("16130f"))
	draw_rect(Rect2(0, 262, 640, 2), Color("2a2418"))
	# 왼쪽 마을 (창문 불빛)
	for i in 4:
		var hp := Vector2(26 + i * 42, 248 - (i % 2) * 8)
		if not draw_sprite("field/house", hp, 1.4, Color(0.45, 0.4, 0.45)):
			draw_rect(Rect2(hp - Vector2(16, 12), Vector2(32, 22)), Color("221c24"))
		glow(self, hp + Vector2(4, 2), 14.0, Color(1.0, 0.65, 0.3, 0.35 + 0.1 * sin(t * 0.2 + i)))
	# 오른쪽 언덕 위 가마 (불길·연기)
	var kp := Vector2(560, 236)
	draw_colored_polygon(PackedVector2Array([Vector2(480, 262), Vector2(520, 222), Vector2(600, 214), Vector2(640, 240), Vector2(640, 262)]), Color("1a1510"))
	var kt := tex("kiln/kiln_body")
	if kt != null:
		draw_texture_rect(kt, Rect2(kp - Vector2(36, 62), Vector2(72, 72)), false, Color(0.75, 0.68, 0.62))
	else:
		draw_circle(kp - Vector2(0, 20), 26.0, Color("4a3c30"))
	glow(self, kp + Vector2(0, -12), 34.0 + 6.0 * sin(t * 0.3), Color(1.0, 0.5, 0.15, 0.5))
	for i in 5:
		var ph: float = fmod(t * 0.006 + i * 0.2, 1.0)
		glow(self, kp + Vector2(-6 + ph * 30.0, -70 - ph * 110.0), 12.0 + ph * 26.0, Color(0.5, 0.45, 0.5, 0.25 * (1.0 - ph)))
	_draw_title_front(false)   # 도트 병사 행렬은 빼 둔다 (사용자: "기본 도트 병사를 그대로 보여줬는데" → 표지 그림이 대신)


## 시작 화면 앞쪽: 행군하는 병사 · 도깨비 눈빛 · 반딧불 · 제목 · 버튼 · 소개 문장
## 표지 한 겹: 화면 높이에 맞추고 가운데 정렬 (넓은 그림은 좌우로 흐를 여유가 된다)
func _draw_layer_fit(tx: Texture2D, off: Vector2) -> void:
	var k: float = VIEW.y / tx.get_height()
	var sz: Vector2 = tx.get_size() * k
	draw_texture_rect(tx, Rect2(Vector2((VIEW.x - sz.x) / 2.0, VIEW.y - sz.y) + off, sz), false)


func _draw_title_front(marchers := true) -> void:
	# 표지 그림이 없을 때만: 언덕 위 실루엣 병사들 (도트 인형을 그대로 보이지 않게 어둡게)
	var roles := ["shield", "spear", "spear", "archer", "axe", "general", "cavalry", "healer", "dragon"]
	var els := ["earth", "fire", "water", "water", "fire", "fire", "earth", "water", "water"]
	for i in (roles.size() if marchers else 0):
		var x: float = fmod(t * 0.45 + i * 34.0, 760.0) - 60.0
		var bob: float = absf(sin(t * 0.18 + i)) * 2.0
		var nm := soldier_sprite(roles[i], els[i])
		if not draw_sprite(nm, Vector2(x, 296 - bob), 1.5, Color(0.16, 0.13, 0.18)):
			draw_ally_shape(Vector2(x, 296 - bob), roles[i], els[i], "normal", 1.5)
	# 멀리서 다가오는 도깨비 눈빛
	for i in 6:
		var gx: float = 640.0 - fmod(t * 0.12 + i * 40.0, 200.0)
		var gy: float = 240.0 + (i % 3) * 6.0
		var blink: float = 1.0 if fmod(t * 0.02 + i, 3.0) > 0.15 else 0.0
		draw_rect(Rect2(gx, gy, 2, 1), Color(1.0, 0.85, 0.2, 0.8 * blink))
		draw_rect(Rect2(gx + 5, gy, 2, 1), Color(1.0, 0.85, 0.2, 0.8 * blink))
	# 반딧불·불티
	for i in 16:
		var fp := Vector2(fmod(i * 61.0 + t * 0.2 * (1 + i % 3), 640.0), 180.0 + fmod(i * 23.0 - t * 0.15, 160.0))
		var fa: float = maxf(0.0, sin(t * 0.07 + i))
		glow(self, fp, 5.0, Color(1.0, 0.8, 0.4, 0.5 * fa))
	# 제목
	var title := "KILNBORN"   # 게임 이름 (2026-11-28 사용자: "KILNBORN 이거만 해서 이름 정하자")
	glow(self, Vector2(320, 92), 120.0, Color(1.0, 0.75, 0.35, 0.12))
	var logo := tex("ui/logo")
	if logo != null:
		# 로고 그림 (Codex, 지시서 11): 320×80 자리에 원래 크기로, 불빛이 살짝 숨 쉰다
		glow(self, Vector2(320, 80), 90.0 + 6.0 * sin(t * 0.05), Color(1.0, 0.6, 0.25, 0.10))
		draw_texture_rect(logo, Rect2(Vector2(320, 76) - logo.get_size() / 2.0, logo.get_size()), false)
	else:
		var w: float = font_bold.get_string_size(title, HORIZONTAL_ALIGNMENT_LEFT, -1, 36).x
		for oo in [Vector2(-2, 0), Vector2(2, 0), Vector2(0, -2), Vector2(0, 3)]:
			draw_string(font_bold, Vector2(320 - w / 2.0, 104).round() + oo, title, HORIZONTAL_ALIGNMENT_LEFT, -1, 36, Color("1a1208"))
		draw_string(font_bold, Vector2(320 - w / 2.0, 104).round(), title, HORIZONTAL_ALIGNMENT_LEFT, -1, 36, UI["gold"])
	var sub := "도자기 병사로 마을을 지키는 로그라이트 디펜스"
	text(Vector2(320 - font.get_string_size(sub, HORIZONTAL_ALIGNMENT_LEFT, -1, 12).x / 2.0, 124), sub, Color("e8dcc0"))
	# 버튼
	_draw_lord_badge(Rect2(8, 8, 170, 44), true)
	button(Rect2(240, 142, 160, 30), "게임 시작  (Enter)", "start", UI["gold"], true, true)
	button(Rect2(240, 177, 160, 24), "랭킹", "to_records", UI["gold"])
	button(Rect2(240, 205, 160, 24), "환경설정", "to_settings", UI["gold"])
	if PD.DEMO:
		text(Vector2(0, 396), "DEMO v%s" % PD.VERSION, Color(0.9, 0.85, 0.7, 0.55), 12, 632.0, HORIZONTAL_ALIGNMENT_RIGHT)
	# 소개 문장 (4초마다 바뀌며 스며듦)
	var idx: int = (t / 240) % INTRO.size()
	var ph2: float = fmod(t, 240.0) / 240.0
	var al: float = minf(1.0, minf(ph2 * 6.0, (1.0 - ph2) * 6.0))
	var line: String = INTRO[idx]
	var lw: float = font.get_string_size(line, HORIZONTAL_ALIGNMENT_LEFT, -1, 12).x
	if tex("ui/title_front") != null:
		# 표지 그림이 있으면 아래는 병사들 자리 → 소개 문장은 불씨 칩 아래, 마을 지붕 위에 옅은 띠로
		draw_rect(Rect2(320 - lw / 2.0 - 14, 240, lw + 28, 20), Color(0, 0, 0, 0.5 * al))
		text(Vector2(320 - lw / 2.0, 254), line, Color(0.95, 0.9, 0.8, al))
	else:
		draw_rect(Rect2(0, 352, 640, 30), Color(0, 0, 0, 0.45))
		text(Vector2(320 - lw / 2.0, 372), line, Color(0.95, 0.9, 0.8, al))


func _draw_meta() -> void:
	panel(Rect2(6, 4, 628, 40))
	button(Rect2(14, 13, 70, 22), "‹ 로비" if meta_from == "prep" else "‹ 처음 화면", "back", UI["gold"])
	text(Vector2(94, 34), "전술 강화", UI["gold"], 24)
	text(Vector2(214, 31), fit("불씨는 아침·밤을 ★3 으로 넘길 때마다 1개 · 다음 판부터 적용", 306.0), UI["muted"])
	var er := Rect2(530, 13, 96, 22)
	chip(er, "불씨 %d" % meta.embers, UI["gold"])
	draw_icon("ember", er.position + Vector2(4, 4), 1.0)
	# 줄기: 가마터 → 세로 줄 → 가지마다 오른쪽으로
	var gold_dim := Color(0.66, 0.53, 0.2)
	draw_rect(Rect2(98, 212, 22, 2), gold_dim)
	draw_rect(Rect2(119, 78, 2, 271), gold_dim)
	for br in META_ROW:
		var yy: float = META_ROW[br]
		draw_rect(Rect2(119, yy - 1, 24, 2), gold_dim)
		text(Vector2(122, yy - 22), Meta.BRANCH_NAME[br], UI["muted"])
	for id in Meta.NODES:
		var need: String = Meta.NODES[id]["need"]
		if need != "" and need != "core":
			var a2: Vector2 = META_POS[need]
			var b2: Vector2 = META_POS[id]
			var lit: bool = meta.level(id) > 0
			var lc: Color = UI["gold"] if lit else Color("3a3346")
			if absf(a2.y - b2.y) < 1.0:
				draw_rect(Rect2(a2.x + META_W / 2.0, a2.y - 1, b2.x - a2.x - META_W, 2), lc)
			else:
				draw_rect(Rect2(a2.x, a2.y + 18, 2, b2.y - a2.y - 36), lc)
	# 가마터
	var cr := Rect2(24, 183, 76, 60)
	rrect(cr, Color("2e2616"))
	rline(cr, UI["gold"])
	draw_icon("clay", cr.position + Vector2(26, 8), 2.0)
	text(Vector2(cr.position.x + 16, cr.end.y - 8), "가마터", UI["gold"])
	meta_hover = ""
	for id in META_POS:
		if id == "core":
			continue
		var c: Vector2 = META_POS[id]
		var r := Rect2(c - Vector2(META_W / 2.0, 18), Vector2(META_W, 36))
		buttons.append({"rect": r, "id": "node_" + id})
		var lv: int = meta.level(id)
		var mx: int = Meta.NODES[id]["max"]
		var can: bool = meta.can_buy(id)
		var hov: bool = r.has_point(get_local_mouse_position())
		var edge: Color = UI["gold"] if lv > 0 else (Color(1.0, 0.85, 0.4, 0.55 + 0.45 * sin(t * 0.15)) if can else Color("4a4458"))
		rrect(Rect2(r.position + Vector2(0, 2), r.size), Color(0, 0, 0, 0.4))
		rrect(r, (Color("2e2616") if lv > 0 else UI["lacquer"]).lightened(0.06 if hov else 0.0))
		rline(r, edge)
		draw_icon(META_ICON[id], r.position + Vector2(4, 4), 1.0)
		text(r.position + Vector2(20, 15), fit(Meta.NODES[id]["name"], META_W - 24.0), UI["gold"] if lv > 0 or can else UI["muted"])
		var cst: int = meta.cost(id)
		text(r.position + Vector2(6, 31), "최대" if cst < 0 else "불씨 %d" % cst, C["good"] if cst < 0 else (UI["gold"] if can else Color("6b6478")))
		for k in mx:
			draw_rect(Rect2(r.end.x - 6 - (mx - k) * 7, r.end.y - 9, 5, 4), UI["gold"] if k < lv else Color("3a3346"))
		if hov:
			meta_hover = id
	if meta_hover != "":
		var n: Dictionary = Meta.NODES[meta_hover]
		var c2: Vector2 = META_POS[meta_hover]
		var tr := Rect2(c2 + Vector2(-100, 22), Vector2(200, 58))
		tr.position.x = clampf(tr.position.x, 6.0, 634.0 - tr.size.x)
		if tr.end.y > 396.0:
			tr.position.y = c2.y - 22 - tr.size.y
		panel(tr)
		text(tr.position + Vector2(10, 17), fit("%s  %d/%d" % [n["name"], meta.level(meta_hover), n["max"]], 180.0), UI["gold"])
		text(tr.position + Vector2(10, 33), fit(n["desc"], 180.0), C["text"])
		if n["need"] != "" and meta.level(n["need"]) == 0:
			text(tr.position + Vector2(10, 49), fit("먼저: " + Meta.NODES[n["need"]]["name"], 180.0), C["danger"])


func _fmt_time(sec: float) -> String:
	return "%d:%04.1f" % [int(sec) / 60, fmod(sec, 60.0)]


func _draw_records() -> void:
	_draw_title_bg_only()
	draw_rect(Rect2(Vector2.ZERO, VIEW), Color(0, 0, 0, 0.6))
	button(Rect2(10, 10, 70, 22), "‹ 뒤로", "back", UI["gold"])
	text(Vector2(0, 34), "랭킹", UI["gold"], 24, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	_draw_lord_badge(Rect2(470, 6, 164, 40), false)
	# 가장 멀리 간 판
	var br := Rect2(150, 46, 340, 34)
	panel(br)
	if meta.best.is_empty():
		text(Vector2(br.position.x, br.position.y + 22), "가장 멀리 간 판: 아직 없음", C["dim"], 12, br.size.x, HORIZONTAL_ALIGNMENT_CENTER)
	else:
		var bb: Dictionary = meta.best
		var reach: String = ("데모 클리어! (챕터 %d)" % bb["chapter"] if PD.DEMO else "모든 챕터 클리어!") if bb.get("all", false) else "챕터 %d · 밤 %d" % [bb["chapter"], bb["night"]]
		text(Vector2(br.position.x, br.position.y + 22), "가장 멀리 간 판: %s  ·  처치 %d  ·  %s" % [reach, bb["kills"], str(bb["date"]).substr(5)], UI["gold"], 12, br.size.x, HORIZONTAL_ALIGNMENT_CENTER)
	text(Vector2(0, 100), "챕터별 가장 빠른 클리어 (밤 전투 시간 합)", UI["muted"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	for c in PD.CHAPTERS.size():
		var x: float = 14.0 + (c % 3) * 206.0 + (103.0 if c >= 3 else 0.0)
		var y: float = 108.0 + (c / 3) * 140.0
		panel(Rect2(x, y, 198, 132))
		text(Vector2(x + 8, y + 18), "챕터 %d · %s" % [c + 1, PD.CHAPTERS[c]["name"]], UI["gold"])
		var list: Array = meta.records.get(str(c + 1), [])
		if PD.DEMO and c + 1 > PD.DEMO_LAST_CHAPTER:
			text(Vector2(x + 8, y + 42), "정식판에서 열립니다", C["dim"])
			draw_rect(Rect2(x, y, 198, 132), Color(0, 0, 0, 0.35))
			continue
		if list.is_empty():
			text(Vector2(x + 8, y + 42), "아직 기록 없음", C["dim"])
		for i in mini(5, list.size()):
			var rec: Dictionary = list[i]
			var yy: float = y + 40 + i * 18
			text(Vector2(x + 8, yy), "%d위" % (i + 1), UI["gold"] if i == 0 else C["text"])
			text(Vector2(x + 40, yy), _fmt_time(rec["time"]), C["text"])
			text(Vector2(x + 110, yy), str(rec["date"]).substr(5), C["dim"])
	text(Vector2(0, 394), "이 컴퓨터의 기록입니다 (온라인 순위는 서버가 필요해 데모에는 없습니다)", C["dim"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)


func _power(s: Dictionary) -> float:
	return PD.TIER_MUL[s["tier"]] * PD.STAR_MUL[s["star"]]


## 위쪽 띠: 챕터·아침, 마을, 오늘 밤, 자원 알약, 도움말
func _draw_topbar(title := "", back := false) -> void:
	panel(Rect2(6, 4, 628, 44))
	var ci: Dictionary = run.chapter_info()
	if back:
		button(Rect2(14, 14, 62, 24), "‹ 로비", "lobby", UI["gold"])
		text(Vector2(86, 36), title, UI["gold"], 24)
	else:
		# 왼쪽 위: 군주 도장 + 이름, 그 아래 챕터·아침
		_draw_lord_seal(Vector2(12, 9), 30.0)
		text(Vector2(48, 20), fit(meta.lord_name if meta.lord_name != "" else "이름 없는 군주", 104.0), UI["gold"])
		text(Vector2(48, 40), fit("챕터 %d · 아침 %d/%d" % [run.chapter, run.night, PD.KILN_NIGHTS], 106.0), C["text"])
		text(Vector2(160, 19), "마을", UI["muted"])
		draw_rect(Rect2(190, 11, 110, 8), Color("3a2430"))
		draw_rect(Rect2(190, 11, 110 * clampf(run.village_hp / PD.VILLAGE_HP, 0.0, 1.0), 8), C["good"])
		var boss_night: bool = run.night >= PD.KILN_NIGHTS
		var warn := "오늘 밤 도깨비 ×%.1f" % (ci["hp"] * (1.0 + PD.NIGHT_HP_GROWTH * (run.night - 1)))
		if boss_night:
			warn += " · " + PD.ENEMIES[ci["boss"]]["name"]
		text(Vector2(160, 38), fit(warn, 136.0), C["danger"] if boss_night else Color("ff9a7a"))
	var cx0 := 364.0 if back else 300.0
	if not back:
		button(Rect2(534, 15, 30, 22), "도감", "go_codex", UI["gold"])
		button(Rect2(566, 15, 30, 22), "전술", "go_meta", UI["gold"])
	var chips := [["ticket", "%d" % run.tickets, UI["gold"]], ["clay", "%d" % run.clay, C["clay"].lightened(0.35)],
		["pearl", "%d" % run.pearls, Color("e8eef5")], ["shard", "%d/%d" % [kiln.shards, kiln.shard_need], UI["muted"]]]
	# 칩에 마우스를 올리면 무엇인지 설명 (2026-11-28 "도감 옆에 있는 아이콘은 뭘 가리키는 거야?")
	var chip_tip := {"ticket": "뽑기권 — 흙 없이 뽑기 1번", "clay": "흙 — 뽑기 %d · 다시 굽기에 쓴다" % PD.CLAY_DRAW, "pearl": "진주 — 진주 상점에서 쓴다",
		"shard": "가마 파편 — 깨진 흙 인형 조각. %d개 모이면 다음 굽기에 요변 1개 확정" % kiln.shard_need}
	var hover_chip := ""
	for i in chips.size():
		var r := Rect2(cx0 + i * 58, 15, 54, 22)
		chip(r, chips[i][1], chips[i][2])
		draw_icon(chips[i][0], r.position + Vector2(4, 4), 1.0)
		if r.has_point(get_local_mouse_position()):
			hover_chip = chips[i][0]
	button(Rect2(600, 15, 26, 22), "?", "help", UI["gold"])
	if hover_chip != "":
		var tip: String = chip_tip[hover_chip]
		var tw: float = font.get_string_size(tip, HORIZONTAL_ALIGNMENT_LEFT, -1, 12).x + 20.0
		var tr := Rect2(clampf(get_local_mouse_position().x - tw / 2.0, 4.0, 636.0 - tw), 42, tw, 22)
		rrect(tr, Color(0.05, 0.04, 0.07, 0.97))
		rline(tr, UI["gold"])
		text(tr.position + Vector2(10, 15), tip, C["text"])


## 부대 칸: 6칸 × 3줄 카드 (로비·상점·장비가 함께 쓴다)
func _draw_army_grid(origin: Vector2, title: String) -> void:
	panel(Rect2(origin, Vector2(404, 244)), title)
	var cw := 62.0
	var ch := 72.0
	var cells: int = maxi(run.cap(), run.army.size())
	var pages: int = (cells + 17) / 18
	army_page = clampi(army_page, 0, pages - 1)
	if pages > 1:
		button(Rect2(origin.x + 318, origin.y - 8, 22, 16), "◀", "pg_prev", UI["gold"], army_page > 0)
		text(Vector2(origin.x + 340, origin.y + 5), "%d/%d" % [army_page + 1, pages], UI["gold"], 12, 40.0, HORIZONTAL_ALIGNMENT_CENTER)
		button(Rect2(origin.x + 380, origin.y - 8, 22, 16), "▶", "pg_next", UI["gold"], army_page < pages - 1)
	for li in mini(18, cells - army_page * 18):
		var i: int = army_page * 18 + li
		var x: float = origin.x + 8.0 + (li % 6) * (cw + 3.0)
		var y: float = origin.y + 12.0 + (li / 6) * (ch + 4.0)
		var r := Rect2(x, y, cw, ch)
		if i >= run.cap() and i < run.army.size():
			rrect(r.grow(2), Color(C["danger"].r, C["danger"].g, C["danger"].b, 0.35))   # 자리 초과
		if i >= run.army.size():
			rrect(r, UI["deep"])
			rline(r, UI["line"])
			continue
		var s: Dictionary = run.army[i]
		var queued: bool = run.is_queued(s["id"])
		buttons.append({"rect": r, "id": "card%d" % s["id"]})
		var rc: Color = GRADE_COL[PD.ROLE_GRADE[s["role"]]]
		var hov: bool = r.has_point(get_local_mouse_position())
		var framed: bool = nine("card_9", r, 6, Color.WHITE.lerp(rc, 0.6).lightened(0.08 if hov else 0.0))
		if not framed:
			rrect(r, Color("221b29").lightened(0.06 if hov else 0.0))
			draw_rect(Rect2(x + 2, y + ch - 20, cw - 4, 18), Color(0, 0, 0, 0.25))
		if s["tier"] == "legend":
			glow(self, Vector2(x + cw / 2.0, y + 30), 30.0, Color(1.0, 0.95, 0.8, 0.14))
		if not framed or selected == s["id"]:
			rline(r, rc if selected != s["id"] else UI["gold"])
		if selected == s["id"]:
			rline(r.grow(1), UI["gold"])
		var stx := tex(soldier_sprite(s["role"], s["element"]))
		var sk: float = 1.25 if stx == null else minf(1.25, 40.0 / stx.get_height())
		draw_ally_shape(Vector2(x + cw / 2.0, y + 47 - 12.8 * sk), s["role"], s["element"], s["tier"], sk, false, s["star"], s.get("promo", "") != "")
		if s["tier"] != "normal":
			text(Vector2(x + 4, y + 13), PD.TIER_NAME_KILN[s["tier"]], UI["gold"] if s["tier"] == "legend" else C["text"])
		var mp: Vector2i = run.merge_progress(s)
		if s["star"] < PD.MAX_STAR and mp.x >= 2:
			var mt := "%d/%d" % [mini(mp.x, mp.y), mp.y]
			text(Vector2(x + cw - 4 - font.get_string_size(mt, HORIZONTAL_ALIGNMENT_LEFT, -1, 12).x, y + 13), mt, C["good"] if mp.x >= mp.y else UI["muted"])
		if not s.get("equip", {}).is_empty():
			draw_icon(s["equip"]["type"], Vector2(x + 3, y + 36), 1.0)
		if s.get("promo", "") != "":
			text(Vector2(x + 4, y + 27), "전직", UI["gold"])
		elif s["star"] >= PD.PROMO_STAR and not run.promo_partners(s["id"]).is_empty():
			# 전직할 수 있음: 오른쪽 가운데에 깜빡이는 표시
			var pc := Vector2(x + cw - 9, y + 30)
			draw_circle(pc, 6.0, Color(1.0, 0.75, 0.3, 0.35 + 0.25 * sin(t * 0.2)))
			text(pc + Vector2(-6, 4), "↑", UI["gold"], 12, 12.0, HORIZONTAL_ALIGNMENT_CENTER)
		var nm: String = fit(PD.ROLE_NAME_KILN[s["role"]], cw - 4.0)
		var nw: float = font.get_string_size(nm, HORIZONTAL_ALIGNMENT_LEFT, -1, 12).x
		text(Vector2(x + (cw - nw) / 2.0, y + ch - 10), nm, rc)
		_draw_stars(Vector2(x + cw / 2.0, y + ch - 3), s["star"])
		if queued:
			rrect(r, Color(0.05, 0.03, 0.02, 0.65))
			text(Vector2(x + 13, y + 40), "가마 안", C["fire"].lightened(0.3))
		if promo_pick and selected >= 0:
			if run.can_promote(selected, s["id"]):
				rline(r.grow(2), Color(1.0, 0.85, 0.3, 0.5 + 0.4 * sin(t * 0.2)))
			elif s["id"] != selected:
				rrect(r, Color(0, 0, 0, 0.55))


## 로비 (아침 준비) — 시안 1
func _draw_prep() -> void:
	_draw_topbar()
	_draw_army_grid(Vector2(6, 58), "부대 %d / %d" % [run.army.size(), run.cap()])
	# 고른 병사 띠
	panel(Rect2(6, 306, 404, 34))
	var sel: Dictionary = run.soldier(selected) if selected >= 0 else {}
	if sel.is_empty():
		# 할 수 있는 것을 바로 보여 준다 (2026-11-28 "전직이 가능하거나 합성이 가능한 게 있으면 활성화됐다는 표시")
		var ng: int = run.merge_groups().size()
		var np: int = _promo_ready().size()
		text(Vector2(16, 328), fit("병사를 누르면 정보 · 다시 굽기 · 보내기", 180.0), UI["muted"])
		_ready_chip(Rect2(200, 312, 100, 22), "합치기 %d" % ng, "rd_merge", ng > 0)
		_ready_chip(Rect2(304, 312, 100, 22), "전직 %d" % np, "rd_promo", np > 0)
	else:
		var gcol: Color = GRADE_COL[PD.ROLE_GRADE[sel["role"]]]
		text(Vector2(16, 320), fit("%s ★%d · %s" % [sel["name"], sel["star"], PD.TIER_NAME_KILN[sel["tier"]]], 176.0), gcol)
		var mp2: Vector2i = run.merge_progress(sel)
		text(Vector2(16, 334), fit("같은 병사 ★%d %d/%d → ★%d" % [sel["star"], mini(mp2.x, mp2.y), mp2.y, sel["star"] + 1] if sel["star"] < PD.MAX_STAR else "별 최고 ★5", 176.0), UI["muted"])
		var bx := 196.0
		var why := "" if run.can_refire(selected) else "x"
		button(Rect2(bx, 311, 58, 24), "다시 굽기", "refire", C["fire"].lightened(0.3), why == "")
		button(Rect2(bx + 159, 311, 50, 24), "정말?" if release_armed == selected else "보내기", "release", C["danger"] if release_armed == selected else UI["muted"], not run.is_queued(selected))
		var groups: Array = run.merge_groups()
		var mine: Array = groups.filter(func(g2): return g2.has(selected))
		var gi: int = groups.find(mine[0]) if not mine.is_empty() else (0 if not groups.is_empty() else -1)
		button(Rect2(bx + 61, 311, 50, 24), "합치기", "merge%d" % max(0, gi), UI["gold"], gi >= 0)
		var can_promo: bool = not run.promo_partners(selected).is_empty()
		button(Rect2(bx + 114, 311, 42, 24), "고르기" if promo_pick else "전직", "promo", Color(1.0, 0.75, 0.35), can_promo)
	# 오른쪽: 들어가는 메뉴 판 — 가마 뽑기 · 진주 상점 · 장비
	var tiles := [["go_gacha", "가마 뽑기", "뽑기권 %d · 확률·천장" % run.tickets, UI["gold"], "ticket", true],
		["go_barracks", "대기실", "병사 %d명 · 골라서 부대로" % run.reserve.size(), Color("f0b27a"), "scroll", true],
		["go_shop", "진주 상점", "진주 %d · 병사 강화" % run.pearls, Color("dfe6ee"), "pearl", true],
		["go_equip", "장비", ("가방 %d개" % run.inventory.size()) if run.equip_unlocked() else "챕터 3부터 열림", Color("8fd88a"), "blade", run.equip_unlocked()]]
	for i in tiles.size():
		var tl: Array = tiles[i]
		var r := Rect2(416, 56 + i * 43, 218, 40)
		var on: bool = tl[5]
		var hov: bool = on and r.has_point(get_local_mouse_position())
		if on:
			buttons.append({"rect": r, "id": tl[0]})
		rrect(Rect2(r.position + Vector2(0, 2), r.size), Color(0, 0, 0, 0.4))
		rrect(r, UI["lacquer"].lerp(tl[3], 0.1 if hov else 0.0))
		rline(r, tl[3] if on else Color("4a4458"))
		rrect(Rect2(r.position + Vector2(6, 5), Vector2(30, 30)), UI["deep"])
		draw_icon(tl[4], r.position + Vector2(9, 8), 2.0)
		text(r.position + Vector2(44, 20), tl[1], tl[3] if on else Color("6b6478"), 20)
		text(r.position + Vector2(44, 34), fit(tl[2], 154.0), UI["muted"])
		text(r.position + Vector2(202, 26), "›", tl[3] if on else Color("6b6478"))
	# 가마 안 (작게)
	panel(Rect2(416, 232, 218, 50), "가마 %d / %d" % [run.queue.size(), PD.KILN_SLOTS], C["fire"].lightened(0.2))
	if run.queue.is_empty():
		text(Vector2(426, 262), "비어 있음 — 가마 뽑기에서", UI["muted"])
	else:
		for i in mini(run.queue.size(), 8):
			var q: Dictionary = run.queue[i]
			var qp := Vector2(430 + i * 14.0, 262)
			if q["kind"] == "new":
				draw_clay(qp, q["role"], 0.6)
			else:
				draw_ally_shape(qp, q["role"], q["element"], run.soldier(q["id"]).get("tier", "normal"), 0.5)
		text(Vector2(426, 276), "흙 인형 %d" % run.queue.size(), UI["muted"])
		button(Rect2(548, 262, 80, 16), "하나 빼기", "uq_last", UI["muted"])
	# 합동 기술 (하나만 고른다)
	var cid: String = run.combo
	var ctone: Color = C[PD.COMBOS[cid]["element"]].lightened(0.3) if cid != "" else UI["muted"]
	panel(Rect2(416, 290, 218, 50), "합동 기술", ctone)
	if cid == "":
		text(Vector2(426, 318), "고르지 않음", UI["muted"])
	else:
		text(Vector2(426, 314), fit(PD.COMBOS[cid]["name"], 120.0), ctone)
		var ok: bool = run.combo_ready(cid)
		text(Vector2(426, 330), "쓸 수 있음" if ok else "병사 부족", C["good"] if ok else C["danger"])
	var any_ready: bool = PD.COMBOS.keys().any(func(k): return run.combo_ready(k))
	button(Rect2(552, 306, 76, 24), "고르기", "go_combo", UI["gold"] if any_ready or cid != "" else UI["muted"], true, cid == "" and any_ready)
	# 아래 큰 버튼
	button(Rect2(6, 348, 310, 30), "가마에 불 지피기  (스페이스)", "fire_go", Color("ff9a6a"), not run.queue.is_empty())
	var night_lab := "밤 맞이하기 → 배치  (Enter)"
	if not run.queue.is_empty():
		night_lab = "가마를 먼저 여세요"
	elif run.over_cap() > 0:
		night_lab = "자리 초과 %d — 합치거나 돌려보내기" % run.over_cap()
	button(Rect2(324, 348, 310, 30), night_lab, "night_go", UI["gold"], run.can_start_night(), true)
	if show_help:
		_draw_help()
	elif tut_now != "":
		_draw_tutorial(tut_now)
	elif not sel.is_empty() and not promo_pick:
		var idx: int = run.army.find(sel)
		var cx: float = 14.0 + (idx % 6) * 65.0
		var cy: float = 70.0 + (idx / 6) * 76.0
		var ty: float = minf(cy, 296.0 - 172.0)   # 정보창이 아래 버튼을 가리지 않게
		draw_unit_tip(sel, Vector2(cx + 66.0, ty) if idx % 6 < 3 else Vector2(cx - 212.0, ty))


## 가마 뽑기 화면 — 시안 2
func _draw_gacha() -> void:
	_draw_topbar("가마 뽑기", true)
	panel(Rect2(6, 56, 330, 284))
	_draw_kiln_body(Vector2(1, 4), 0.0)
	_draw_bench()
	text(Vector2(14, 358), fit("뽑은 흙 인형은 구워야 정체가 드러납니다", 322.0), UI["gold"])
	# 등급 확률
	panel(Rect2(344, 56, 290, 120), "등급 확률")
	var y := 76.0
	for g in PD.GRADES:
		var pct: float = PD.GRADE_ODDS[g] * 100.0
		text(Vector2(354, y), PD.GRADE_NAME[g], GRADE_COL[g])
		text(Vector2(386, y), ("%.1f%%" % pct) if pct < 10.0 else ("%d%%" % roundi(pct)), GRADE_COL[g])
		text(Vector2(428, y), fit(" · ".join(PD.grade_roles(g).map(func(r2): return PD.ROLE_NAME_KILN[r2])), 200.0), C["text"] if g != "common" else UI["muted"])
		y += 16.0
	# 천장
	panel(Rect2(344, 184, 290, 96), "천장 — 운이 나빠도 반드시")
	var pg: String = run.pity_grade()
	var yy := 204.0
	for g2 in ["rare", "hero", "legendary"]:
		var left: int = run.pity_left(g2)
		text(Vector2(354, yy), PD.GRADE_NAME[g2] + " 이상", GRADE_COL[g2])
		text(Vector2(560, yy), "확정!" if pg == g2 else "%d번 남음" % left, GRADE_COL[g2] if pg == g2 else UI["muted"])
		var k: float = 1.0 - float(left) / PD.PITY[g2]
		draw_rect(Rect2(420, yy - 7, 130, 5), Color("2a2236"))
		draw_rect(Rect2(420, yy - 7, 130 * clampf(k, 0.0, 1.0), 5), GRADE_COL[g2])
		yy += 18.0
	text(Vector2(354, yy + 2), "신화 조각", GRADE_COL["mythic"])
	for i in PD.MYTH_SHARDS:
		var dp := Vector2(420 + i * 11, yy - 2)
		draw_colored_polygon(PackedVector2Array([dp + Vector2(0, -4), dp + Vector2(4, 0), dp + Vector2(0, 4), dp + Vector2(-4, 0)]), GRADE_COL["mythic"] if i < run.myth_shards else Color("3a2a36"))
	text(Vector2(484, yy + 2), "전설 %d번 → 신화" % PD.MYTH_SHARDS, UI["muted"])
	# 뽑기 버튼
	var dwhy := "" if run.can_draw() else ("흙·뽑기권 부족" if run.clay < PD.CLAY_DRAW and run.tickets == 0 else "가마가 가득 참 (%d칸)" % PD.KILN_SLOTS)
	var left: int = run.draws_left()
	button(Rect2(344, 288, 92, 30), "1번 뽑기", "draw1", UI["gold"], left >= 1)
	button(Rect2(443, 288, 92, 30), "10번 뽑기", "draw10", UI["gold"], left >= 10)
	button(Rect2(542, 288, 92, 30), "전부 %d번" % left if left > 0 else "전부", "drawall", UI["gold"], left >= 1, true)
	text(Vector2(344, 336), fit(dwhy if dwhy != "" else "뽑기권 먼저, 없으면 흙 %d · 가마 %d/%d" % [PD.CLAY_DRAW, run.queue.size(), PD.KILN_SLOTS], 290.0), UI["muted"], 12, 290.0, HORIZONTAL_ALIGNMENT_CENTER)
	button(Rect2(344, 348, 290, 30), "가마에 넣고 불 지피기 (%d)" % run.queue.size(), "fire_go", Color("ff9a6a"), not run.queue.is_empty())
	text(Vector2(14, 374), fit("유약: 청자·진사·흑유 각 33%", 322.0), UI["muted"])


## 진주 상점 화면 — 상점만 따로: 왼쪽 상인, 오른쪽 진열대. 강화 아이템은 사면 '누구에게?' 창
func _draw_shop() -> void:
	_draw_topbar("진주 상점", true)
	# 상인
	panel(Rect2(6, 58, 250, 282))
	var mtx := tex("ui/merchant")
	glow(self, Vector2(130, 170), 90.0, Color(1.0, 0.8, 0.5, 0.08))
	if mtx != null:
		draw_texture_rect(mtx, Rect2(Vector2(82, 76), Vector2(96, 128)), false)
	else:
		draw_sprite(soldier_sprite("healer", "earth"), Vector2(130, 170), 3.0)
	var bub := Rect2(18, 222, 226, 106)
	rrect(bub, UI["deep"])
	rline(bub, UI["bronze"])
	draw_colored_polygon(PackedVector2Array([Vector2(118, 222), Vector2(130, 210), Vector2(142, 222)]), UI["bronze"])
	var lines := ["\"어서 오시오, 장군.", "물건을 고르면", "누구에게 줄지 여쭙겠소.", "진열이 마음에 안 들면", "진주 하나에 다시 꺼내 드리지.\""]
	for i in lines.size():
		text(Vector2(30, 244 + i * 16), lines[i], C["text"] if i == 0 else Color("d8cfc0"))
	# 진열대
	panel(Rect2(264, 58, 370, 244), "오늘의 물건")
	for i in run.shop.size():
		var r := Rect2(276 + (i % 2) * 176, 74 + (i / 2) * 112, 170, 104)
		var key: String = run.shop[i]
		if key == "":
			rrect(r, UI["deep"])
			rline(r, UI["line"])
			text(r.position + Vector2(70, 58), "팔림", UI["muted"])
			continue
		var it: Dictionary = PD.SHOP_ITEMS[key]
		buttons.append({"rect": r, "id": "shop%d" % i})
		var hov: bool = r.has_point(get_local_mouse_position())
		var afford: bool = run.pearls >= run.price(key)
		rrect(Rect2(r.position + Vector2(0, 2), r.size), Color(0, 0, 0, 0.4))
		rrect(r, UI["lacquer"].lightened(0.07 if hov else 0.0))
		rline(r, UI["gold"] if hov and afford else UI["bronze"])
		var ib := Rect2(r.position + Vector2(10, 12), Vector2(44, 44))
		rrect(ib, UI["deep"])
		rline(ib, UI["line"])
		draw_icon(_shop_icon(key), ib.position + Vector2(8, 8), 2.0)
		draw_string(font_bold, (r.position + Vector2(64, 30)).round(), it["name"], HORIZONTAL_ALIGNMENT_LEFT, -1, 12, UI["gold"])
		text(r.position + Vector2(64, 48), fit(it["desc"], 100.0), C["text"])
		var pr := Rect2(r.position + Vector2(10, 70), Vector2(150, 24))
		rrect(pr, UI["deep"])
		draw_icon("pearl", pr.position + Vector2(8, 6), 1.0)
		text(pr.position + Vector2(24, 17), "진주 %d" % run.price(key), Color("e8eef5") if afford else C["danger"])
		if key == "ticket5":
			text(pr.position + Vector2(96, 17), "드묾!", C["accent"])
	# 다시 진열: 물건 칸과 같은 모양으로 '진주 아이콘 + 값' (2026-11-28)
	var rr := Rect2(264, 310, 180, 30)
	var can_rr: bool = run.free_rerolls > 0 or run.pearls >= PD.SHOP_REROLL
	button(rr, "", "reroll", Color("dfe6ee"), can_rr)
	var rtc: Color = _readable_on(Color(0.75, 0.78, 0.82) if can_rr else Color(0.2, 0.19, 0.22), Color(0, 0, 0, 0), 4.5)
	draw_string(font_bold, (rr.position + Vector2(18, 20)).round(), "다시 진열", HORIZONTAL_ALIGNMENT_LEFT, -1, 12, rtc)
	var pb := Rect2(rr.position + Vector2(100, 5), Vector2(70, 20))
	rrect(pb, UI["deep"])
	if run.free_rerolls > 0:
		text(pb.position + Vector2(0, 15), "공짜 %d번" % run.free_rerolls, C["good"], 12, pb.size.x, HORIZONTAL_ALIGNMENT_CENTER)
	else:
		draw_icon("pearl", pb.position + Vector2(10, 3), 1.0)
		text(pb.position + Vector2(28, 15), "%d" % PD.SHOP_REROLL, Color("e8eef5") if run.pearls >= PD.SHOP_REROLL else C["danger"])
	button(Rect2(450, 310, 90, 30), "목록·확률", "shop_table", UI["gold"])
	text(Vector2(546, 322), fit("진주: 처치 %d마리당 1" % PD.PEARL_PER_KILLS, 88.0), UI["muted"])
	text(Vector2(546, 336), fit("대장 %d" % PD.PEARL_BOSS, 88.0), UI["muted"])
	button(Rect2(6, 348, 628, 30), "다 샀어요 — 로비로", "lobby", UI["gold"], true, true)
	if shop_table:
		_draw_shop_table()
	if shop_pick >= 0:
		draw_rect(Rect2(Vector2.ZERO, VIEW), Color(0, 0, 0, 0.6))
		var key2: String = run.shop[shop_pick]
		_draw_army_grid(Vector2(118, 70), "누구에게 줄까요 — %s (%s)" % [PD.SHOP_ITEMS[key2]["name"], PD.SHOP_ITEMS[key2]["desc"]])
		button(Rect2(270, 322, 100, 26), "그만두기", "pick_cancel", UI["muted"])


## 장비 화면 (챕터 3부터)
func _draw_equip() -> void:
	_draw_topbar("장비", true)
	_draw_army_grid(Vector2(6, 58), "장비를 끼울 병사 고르기")
	var sel: Dictionary = run.soldier(selected) if selected >= 0 else {}
	panel(Rect2(416, 58, 218, 282), "장비 (병사 한 명에 하나)")
	var y := 80.0
	if sel.is_empty():
		text(Vector2(426, y), "왼쪽에서 병사를 고르세요", UI["muted"])
	else:
		var it: Dictionary = sel.get("equip", {})
		text(Vector2(426, y), fit(sel["name"], 150.0), GRADE_COL[PD.ROLE_GRADE[sel["role"]]])
		if not it.is_empty():
			button(Rect2(584, y - 13, 42, 18), "빼기", "uneq", UI["muted"])
		y += 18.0
		if it.is_empty():
			text(Vector2(426, y), "끼운 장비 없음", UI["muted"])
		else:
			draw_icon(it["type"], Vector2(426, y - 11), 1.0)
			text(Vector2(442, y), fit("%s · %s" % [KilnRun.equip_name(it), _equip_effect(it)], 184.0), C["text"])
	y += 22.0
	text(Vector2(426, y), "가방 — 눌러서 끼우기", UI["muted"])
	y += 6.0
	var ipages: int = maxi(1, (run.inventory.size() + 11) / 12)
	inv_page = clampi(inv_page, 0, ipages - 1)
	if ipages > 1:
		button(Rect2(560, y - 18, 20, 16), "◀", "inv_prev", UI["gold"], inv_page > 0)
		text(Vector2(580, y - 6), "%d/%d" % [inv_page + 1, ipages], UI["gold"], 12, 26.0, HORIZONTAL_ALIGNMENT_CENTER)
		button(Rect2(606, y - 18, 20, 16), "▶", "inv_next", UI["gold"], inv_page < ipages - 1)
	for li in mini(12, run.inventory.size() - inv_page * 12):
		var i: int = inv_page * 12 + li
		var it2: Dictionary = run.inventory[i]
		var r := Rect2(424, y + li * 19, 202, 17)
		rrect(r, UI["deep"].lightened(0.06 if r.has_point(get_local_mouse_position()) else 0.0))
		draw_icon(it2["type"], r.position + Vector2(3, 2), 1.0)
		text(r.position + Vector2(20, 13), fit("%s  %s" % [KilnRun.equip_name(it2), _equip_effect(it2)], 178.0), C["text"] if not sel.is_empty() else UI["muted"])
		buttons.append({"rect": r, "id": "eq%d" % i})
	if run.inventory.is_empty():
		text(Vector2(426, y + 16), "밤을 넘기면 전리품으로 얻습니다", UI["muted"])
	button(Rect2(6, 348, 628, 30), "로비로", "lobby", UI["gold"], true, true)


## 병사 정보창: 능력치·진영·스킬(별 강화)·전직·강화·장비 (첨부 그림처럼)
func draw_unit_tip(sd: Dictionary, pos: Vector2) -> void:
	var st: Dictionary = run.soldier_stats(sd)
	var g: String = PD.ROLE_GRADE[sd["role"]]
	var f: String = PD.faction_of(sd["role"])
	var fc: Dictionary = run.faction_counts()
	var fl: Dictionary = run.faction_levels()
	var w := 236.0
	var extra: Array = []
	for k in sd.get("upg", {}):
		extra.append({"atk": "공격", "hp": "체력", "skill": "스킬", "cdr": "재사용"}.get(k, k) + " +%d%%" % roundi(sd["upg"][k] * 100.0))
	if not sd.get("equip", {}).is_empty():
		extra.append(KilnRun.equip_name(sd["equip"]))
	var skh: float = skill_box_height(sd["role"], sd["element"], st["skill_lv"], w - 12.0)
	var prh: float = skill_box_height(sd["promo"], sd["element"], st["skill_lv"], w - 12.0) + 4.0 if sd.get("promo", "") != "" else 0.0
	var h: float = 66.0 + skh + prh + (16.0 if not extra.is_empty() else 0.0) + 6.0
	pos.x = clampf(pos.x, 2.0, 640.0 - w - 2.0)
	pos.y = clampf(pos.y, 44.0, 398.0 - h)
	var r := Rect2(pos, Vector2(w, h))
	rrect(Rect2(r.position + Vector2(0, 3), r.size), Color(0, 0, 0, 0.5))
	rrect(r, Color(0.05, 0.04, 0.07, 0.97))
	rline(r, GRADE_COL[g])
	var y: float = pos.y + 17.0
	var x: float = pos.x + 8.0
	text(Vector2(x, y), fit(sd["name"], 150.0), GRADE_COL[g])
	_draw_stars(Vector2(pos.x + w - 32.0, y - 4.0), sd["star"])
	y += 15.0
	var fd: Dictionary = PD.FACTIONS[f]
	text(Vector2(x, y), fit("%s · %s · %s %d/%d종%s" % [PD.GRADE_NAME[g], PD.TIER_NAME_KILN[sd["tier"]], fd["name"], fc[f], fd["tiers"][-1], (" · %d단계" % (fl[f] + 1)) if fl[f] >= 0 else ""], w - 16.0), C["dim"])
	y += 16.0
	text(Vector2(x, y), "♥ %d" % st["hp"] + ("  (+%d)" % st["shield"] if st["shield"] > 0 else ""), Color("ff8a8a"))
	text(Vector2(x + 112, y), "공격 %d" % st["atk"], Color("ffd36a"))
	y += 13.0
	text(Vector2(x, y), "공속 %.1f/초" % st["aps"], UI["muted"])
	text(Vector2(x + 112, y), "사거리 %d" % st["range"], UI["muted"])
	y += 7.0
	draw_skill_box(Vector2(pos.x + 6, y), w - 12.0, sd["role"], sd["element"], st["skill_lv"], "스킬")
	y += skh
	if prh > 0.0:
		y += 4.0
		draw_skill_box(Vector2(pos.x + 6, y), w - 12.0, sd["promo"], sd["element"], st["skill_lv"], "전직 스킬")
		y += prh - 4.0
	if not extra.is_empty():
		y += 14.0
		text(Vector2(x, y), fit("강화 · " + ", ".join(extra), w - 16.0), Color("e8eef5"))


## 스킬 칸: 아이콘(스킬 이펙트 그림의 한 장면) + 이름·재사용 시간 + 설명 + ★3·★4·★5 강화 (지금 단계는 밝게)
func skill_box_height(role: String, element: String, lv: int, w: float) -> float:
	if role == "" or not PD.SKILLS.has(role):
		return 0.0
	var info: Dictionary = PD.skill_info(role, element, lv)
	return 40.0 + (wrap_lines(info["desc"], w - 12.0).size() + wrap_lines(info["elem"], w - 12.0).size()) * 13.0 + 3.0 * 13.0 + 6.0


func draw_skill_box(p: Vector2, w: float, role: String, element: String, lv: int, label: String) -> void:
	var info: Dictionary = PD.skill_info(role, element, lv)
	var h: float = skill_box_height(role, element, lv, w)
	var r := Rect2(p, Vector2(w, h))
	rrect(r, Color("1a1420"))
	rline(r, Color(C["accent"].r, C["accent"].g, C["accent"].b, 0.55))
	# 아이콘
	var ib := Rect2(p + Vector2(5, 5), Vector2(30, 30))
	rrect(ib, Color("0d0a10"))
	var fxt := tex("fx/skill_" + role)
	if fxt != null:
		var n: int = maxi(1, int(fxt.get_width() / fxt.get_height()))
		var fh: float = fxt.get_height()
		var fr: int = clampi(int(n * 0.45), 0, n - 1)
		draw_texture_rect_region(fxt, ib.grow(-1), Rect2(fr * fh, 0, fh, fh), C[element].lightened(0.3) if element != "" else Color.WHITE)
	else:
		draw_circle(ib.get_center(), 9.0, C["accent"].darkened(0.3))
	rline(ib, C[element] if element != "" else C["accent"].darkened(0.2))
	text(p + Vector2(41, 15), label, UI["muted"])
	text(p + Vector2(41, 30), fit(info["name"], w - 110.0), C["accent"])
	text(p + Vector2(0, 30), "재사용 %.0f초" % (info["cd"] / float(PD.FPS)), UI["muted"], 12, w - 6.0, HORIZONTAL_ALIGNMENT_RIGHT)
	var y: float = p.y + 51.0
	for ln in wrap_lines(info["desc"], w - 12.0):
		text(Vector2(p.x + 6, y), ln, C["text"])
		y += 13.0
	for ln in wrap_lines(info["elem"], w - 12.0):
		text(Vector2(p.x + 6, y), ln, C[element].lightened(0.35) if element != "" else C["text"])
		y += 13.0
	for i in 3:
		var on: bool = lv >= i + 1
		if lv == i + 1:
			draw_rect(Rect2(p.x + 3, y - 10, w - 6, 12), Color(C["good"].r, C["good"].g, C["good"].b, 0.14))
		text(Vector2(p.x + 6, y), fit("★%d  %s" % [i + 3, info["up"][i]], w - 12.0), C["good"] if on else Color("766e84"))
		y += 13.0


## 글을 너비에 맞게 여러 줄로 (띄어쓰기 기준, 너무 긴 낱말은 글자 단위)
func wrap_lines(s: String, width: float) -> Array:
	var out: Array = []
	var line := ""
	for word in s.split(" "):
		var cand: String = word if line == "" else line + " " + word
		if font.get_string_size(cand, HORIZONTAL_ALIGNMENT_LEFT, -1, 12).x <= width:
			line = cand
		else:
			if line != "":
				out.append(line)
			line = word
			while font.get_string_size(line, HORIZONTAL_ALIGNMENT_LEFT, -1, 12).x > width and line.length() > 1:
				var cut := line.length() - 1
				while cut > 1 and font.get_string_size(line.substr(0, cut), HORIZONTAL_ALIGNMENT_LEFT, -1, 12).x > width:
					cut -= 1
				out.append(line.substr(0, cut))
				line = line.substr(cut)
	if line != "":
		out.append(line)
	return out


func _draw_tip_for_unit() -> void:
	var sd: Dictionary = run.soldier(tip_sid)
	if sd.is_empty():
		return
	for u in battle.units:
		if unit_sid.get(u.id, -1) == tip_sid:
			var tp: Vector2 = u.pos + FIELD_OFFSET + Vector2(26, -60)
			if state == "deploy" and tp.x + 212.0 > 440.0:
				tp.x = u.pos.x + FIELD_OFFSET.x - 236.0   # 진영 시너지 칸을 가리지 않게
			draw_unit_tip(sd, tp)
			return
	draw_unit_tip(sd, Vector2(214, 120))


## 배치 화면: 둘 수 있는 곳 · 진영 시너지 · 버튼
func _draw_deploy() -> void:
	text(Vector2(10, 20), "병사 배치 — 끌어서 옮기고, 누르면 정보", C["accent"])
	text(Vector2(10, 40), "챕터 %d · 밤 %d — 전장 어디든 끌어다 둘 수 있습니다" % [run.chapter, run.night], C["dim"])
	_draw_factions(Vector2(452, 74))
	if tip_sid >= 0 and drag_id < 0:
		_draw_tip_for_unit()
	button(Rect2(10, 344, 140, 30), "자동 배치", "auto", C["dim"])
	button(Rect2(160, 344, 140, 30), "뒤로", "deploy_back", C["dim"])
	button(Rect2(330, 344, 300, 30), "전투 시작  (Enter)", "go", C["accent"])


## 진영 시너지 목록 (첨부 그림처럼): 이름 · n/최대종 · 단계 막대, 마우스를 올리면 단계별 효과
func _draw_factions(pos: Vector2) -> void:
	var fc: Dictionary = run.faction_counts()
	var fl: Dictionary = run.faction_levels()
	var w := 182.0
	var rows: Array = PD.FACTIONS.keys()
	panel(Rect2(pos - Vector2(6, 20), Vector2(w + 12, 26 + rows.size() * 30)))
	text(pos + Vector2(0, -4), "진영 시너지", C["accent"])
	var hover := ""
	for i in rows.size():
		var f: String = rows[i]
		var fd: Dictionary = PD.FACTIONS[f]
		var y: float = pos.y + 8 + i * 30
		var row := Rect2(pos.x - 2, y - 4, w + 4, 28)
		if row.has_point(get_local_mouse_position()):
			hover = f
			draw_rect(row, Color(1, 1, 1, 0.05))
		var on: bool = fl[f] >= 0
		text(Vector2(pos.x, y + 10), fd["name"], C["accent"] if on else C["dim"])
		text(Vector2(pos.x + 56, y + 10), "%d/%d종" % [fc[f], fd["tiers"][-1]], C["text"] if fc[f] > 0 else C["dim"])
		var tiers: Array = fd["tiers"]
		for k in tiers.size():
			var lit: bool = fl[f] >= k
			draw_rect(Rect2(pos.x + 112 + k * 22, y + 3, 18, 7), C["accent"] if lit else Color("3a3346"))
		var cur: String = (fd["desc"] % roundi(fd["vals"][max(0, fl[f])] * 100.0))
		text(Vector2(pos.x, y + 23), fit(cur, w), C["text"] if on else C["dim"].darkened(0.3))
	if hover != "":
		var fd2: Dictionary = PD.FACTIONS[hover]
		var tr := Rect2(pos.x - 214, pos.y, 204, 40 + fd2["tiers"].size() * 14 + 16)
		draw_rect(tr, Color(0.04, 0.03, 0.06, 0.96))
		draw_rect(tr, C["accent"], false, 1.0)
		text(tr.position + Vector2(8, 15), "%s  %d/%d종" % [fd2["name"], fc[hover], fd2["tiers"][-1]], C["accent"])
		text(tr.position + Vector2(8, 30), fit(", ".join(fd2["roles"].map(func(r2): return PD.ROLE_NAME_KILN[r2])), 188.0), C["dim"])
		for k in fd2["tiers"].size():
			var lit2: bool = fl[hover] >= k
			text(tr.position + Vector2(8, 46 + k * 14), "%d종  %s" % [fd2["tiers"][k], fd2["desc"] % roundi(fd2["vals"][k] * 100.0)], C["text"] if lit2 else C["dim"])


func _draw_stars(c: Vector2, n: int) -> void:
	var w := 7.0
	for i in n:
		var p := c + Vector2((i - (n - 1) / 2.0) * w, 0)
		draw_colored_polygon(PackedVector2Array([p + Vector2(0, -3.5), p + Vector2(1, -1), p + Vector2(3.5, -1), p + Vector2(1.5, 0.8),
			p + Vector2(2.2, 3.5), p + Vector2(0, 2), p + Vector2(-2.2, 3.5), p + Vector2(-1.5, 0.8), p + Vector2(-3.5, -1), p + Vector2(-1, -1)]), C["accent"])


func _equip_effect(it: Dictionary) -> String:
	var m: Dictionary = PD.equip_mods(it)
	var e: Dictionary = PD.EQUIPS[it["type"]]
	var v: float = m.values()[0]
	if e.has("regen"):
		return "%s %.1f%%" % [e["desc"], v * 100.0]
	return "%s +%d%%" % [e["desc"], roundi(v * 100.0)]


## 작은 도트 아이콘: 뽑기권·흙·장비 4종. pos = 왼쪽 위, k = 배율 (1 = 12px 안팎)
## 아이콘: Codex 그림 assets/sprites/ui/icon_<이름>.png (16×16) 이 있으면 그것을, 없으면 코드 도형
func draw_icon(kind: String, pos: Vector2, k: float) -> void:
	var itx := tex("ui/icon_" + kind)
	if itx != null:
		draw_texture_rect(itx, Rect2(pos - Vector2(2, 2) * k, Vector2(16, 16) * k), false)
		return
	var o := Color("282322")
	match kind:
		"shard", "ember", "fire":
			var cc: Color = {"shard": Color("c9a0d8"), "ember": Color("ff9a3c"), "fire": Color("ff6a3c")}[kind]
			draw_colored_polygon(PackedVector2Array([pos + Vector2(6, 0) * k, pos + Vector2(11, 7) * k, pos + Vector2(6, 13) * k, pos + Vector2(1, 7) * k]), o)
			draw_colored_polygon(PackedVector2Array([pos + Vector2(6, 2) * k, pos + Vector2(9, 7) * k, pos + Vector2(6, 11) * k, pos + Vector2(3, 7) * k]), cc)
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
		"pearl":
			draw_circle(pos + Vector2(6, 6) * k, 5.0 * k, o)
			draw_circle(pos + Vector2(6, 6) * k, 4.0 * k, Color("dfe6ee"))
			draw_circle(pos + Vector2(5, 5) * k, 1.5 * k, Color.WHITE)
		"whetstone":
			draw_rect(Rect2(pos + Vector2(1, 4) * k, Vector2(11, 6) * k), o)
			draw_rect(Rect2(pos + Vector2(2, 5) * k, Vector2(9, 4) * k), Color("8f8a80"))
			draw_rect(Rect2(pos + Vector2(2, 5) * k, Vector2(9, 1) * k), Color("c9c4b8"))
		"scale":
			for i in 3:
				draw_circle(pos + Vector2(3 + i * 3, 5 + (i % 2) * 3) * k, 2.6 * k, o)
				draw_circle(pos + Vector2(3 + i * 3, 5 + (i % 2) * 3) * k, 1.8 * k, Color("b0b8c0"))
		"scroll":
			draw_rect(Rect2(pos + Vector2(1, 2) * k, Vector2(11, 9) * k), o)
			draw_rect(Rect2(pos + Vector2(2, 3) * k, Vector2(9, 7) * k), Color("e8dcb8"))
			draw_rect(Rect2(pos + Vector2(4, 5) * k, Vector2(5, 1) * k), Color("6b4a32"))
			draw_rect(Rect2(pos + Vector2(4, 7) * k, Vector2(4, 1) * k), Color("6b4a32"))
		"bell":
			draw_circle(pos + Vector2(6, 7) * k, 4.5 * k, o)
			draw_circle(pos + Vector2(6, 7) * k, 3.5 * k, Color("e8c35a"))
			draw_rect(Rect2(pos + Vector2(5, 1) * k, Vector2(2, 3) * k), Color("b8463a"))
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
	"draw": ["병사 뽑기", "'가마 뽑기'에 들어가 흙 인형을 뽑습니다 (1번 · 10번 · 전부).\n등급은 6단계 — 일반부터 신화까지, 화면의 확률 그대로.\n천장이 있어서 운이 나빠도 정해진 횟수 안에 반드시 나옵니다.", Rect2(416, 58, 218, 50)],
	"fire": ["가마에 굽기", "뽑은 흙 인형은 가마에서 구워야 병사가 됩니다 — 무엇이 될지는 구워 봐야 압니다.\n불을 세게 올릴수록 상품·요변(힘 ×1.5·×2.6)이 잘 나오고,\n불 4까지는 절대 깨지지 않습니다.", Rect2(6, 348, 310, 30)],
	"star": ["별 올리기", "같은 병사·같은 별 3명을 합치면 별이 오릅니다 (확정).\n★1 → ★2 → … → ★5 까지, 단계마다 3명씩.\n유약은 달라도 되지만, 요변은 요변끼리만 합칩니다.", Rect2(218, 309, 188, 28)],
	"full": ["자리가 꽉 찼습니다", "이제부터는 숫자보다 '키우기'입니다.\n· 같은 병사 3명 합치기 → 별 +1   · 다시 굽기 → 요변을 노림\n카드 오른쪽 위 2/3 표시가 합치기까지 모인 수입니다.", Rect2(6, 58, 404, 244)],
	"equip": ["장비", "챕터 3부터 밤을 넘기면 장비를 얻습니다.\n'장비'에 들어가 병사를 고르고 눌러 끼우세요.\n칼날 공격력 · 갑옷 체력 · 부적 공격 속도 · 호리병 회복", Rect2(416, 170, 218, 50)],
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
	rline(hl.grow(2), Color(1.0, 0.85, 0.35, pulse))
	# 상자 높이는 글 길이에 맞춘다 (글이 상자 밖으로 안 나가게)
	var bw := 360.0
	var th: float = font.get_multiline_string_size(info[1], HORIZONTAL_ALIGNMENT_LEFT, bw - 24.0, 12).y
	var bh: float = 52.0 + th
	var bx: float = clampf(hl.get_center().x - bw / 2.0, 8.0, 632.0 - bw)
	var by: float = hl.end.y + 14.0 if hl.end.y + 14.0 + bh < 396.0 else hl.position.y - 14.0 - bh
	if hl.size.y > 200:
		by = 396.0 - bh
		bx = 140.0
	var box := Rect2(bx, maxf(4.0, by), bw, bh)
	panel(box, "도움말 · " + info[0])
	draw_multiline_string(font, (box.position + Vector2(12, 26)).round(), info[1], HORIZONTAL_ALIGNMENT_LEFT, bw - 24.0, 12, -1, C["text"])
	button(Rect2(box.end.x - 88, box.end.y - 26, 78, 20), "알겠어요", "tut_ok", UI["gold"], true, true)
	if hl.size.y < 100:
		var from := box.get_center()
		var to := hl.get_center()
		var dir := (to - from).normalized()
		var tip := Vector2(to.x, hl.end.y + 4.0) if box.position.y > hl.end.y else Vector2(to.x, hl.position.y - 4.0)
		var bob := dir * sin(t * 0.2) * 3.0
		var d2 := Vector2(0, -1) if box.position.y > hl.end.y else Vector2(0, 1)
		draw_colored_polygon(PackedVector2Array([tip + bob, tip + bob - d2 * -8.0 + Vector2(-6, 0) - d2 * 0, tip + bob + Vector2(6, 0) - d2 * -8.0]), UI["gold"])

## 안내 창: 별 올리기와 등급
func _draw_help() -> void:
	draw_rect(Rect2(0, 0, 640, 400), Color(0, 0, 0, 0.6))
	var r := Rect2(40, 14, 560, 372)
	panel(r, "안내")
	button(Rect2(r.end.x - 70, r.position.y + 8, 60, 20), "닫기", "help_close", UI["gold"])
	text(Vector2(56, 44), "별 올리기 (운 없이 확정)", UI["gold"])
	var y := 62.0
	for st in range(1, PD.MAX_STAR + 1):
		_draw_stars(Vector2(78, y - 4), st)
		text(Vector2(120, y), "뽑으면 ★1" if st == 1 else "같은 병사 ★%d %d명" % [st - 1, PD.merge_need(st - 1)], C["text"])
		text(Vector2(280, y), "힘 ×%.1f" % PD.STAR_MUL[st], C["good"])
		y += 15.0
	text(Vector2(56, y + 2), "유약은 달라도 됩니다 · 요변은 요변끼리만 합칩니다", UI["muted"])
	text(Vector2(360, 44), "천장", UI["gold"])
	text(Vector2(360, 62), "희귀↑ %d번 · 영웅↑ %d번 안에" % [PD.PITY["rare"], PD.PITY["hero"]], C["text"])
	text(Vector2(360, 77), "전설↑ %d번 안에 반드시" % PD.PITY["legendary"], C["text"])
	text(Vector2(360, 92), "전설 %d번 → 신화 확정" % PD.MYTH_SHARDS, GRADE_COL["mythic"])
	# 등급: 두 단 (일반·고급·희귀 | 영웅·전설·신화)
	y = 172.0
	text(Vector2(56, y - 12), "등급 · 뽑기 확률 · 병사", UI["gold"])
	var cols := [["common", "uncommon", "rare"], ["hero", "legendary", "mythic"]]
	for ci in 2:
		var x: float = 56.0 + ci * 270.0
		var yy := y + 6.0
		for g in cols[ci]:
			text(Vector2(x, yy), "%s %s" % [PD.GRADE_NAME[g], ("%.1f%%" % (PD.GRADE_ODDS[g] * 100.0))], GRADE_COL[g])
			yy += 15.0
			for r2 in PD.grade_roles(g):
				text(Vector2(x + 10, yy), PD.ROLE_NAME_KILN[r2], C["text"])
				text(Vector2(x + 76, yy), fit(PD.ROLE_DESC[r2], 180.0), UI["muted"])
				yy += 14.0
			yy += 4.0


## 밤 결과 창 — 시안 5: 어두워짐 → 창이 위에서 떨어져 튕기며 쿵 → 제목 판 → 별 → 전리품이 하나씩
static func _ease_back(x: float) -> float:
	var c1 := 1.70158
	var c3 := c1 + 1.0
	var k := clampf(x, 0.0, 1.0) - 1.0
	return 1.0 + c3 * k * k * k + c1 * k * k


func _draw_night_end() -> void:
	var lost: bool = run.state == "lost"
	var tone: Color = C["danger"] if lost else UI["gold"]
	draw_rect(Rect2(Vector2.ZERO, VIEW), Color(0, 0, 0, 0.55 * clampf(end_t / 10.0, 0.0, 1.0)))
	var py: float = lerpf(-260.0, 92.0, _ease_back((end_t - 4) / 16.0))
	var pr := Rect2(150, py, 340, 228)
	panel(pr, "", tone)
	# 제목 판 (도장처럼 펼쳐짐)
	var title := ""
	var sub := ""
	if run.state == "won" and run.last_chapter < PD.CHAPTERS.size():
		title = "데모 클리어! 챕터 %d 최종 보스 격파" % run.last_chapter
		sub = "데모는 여기까지입니다 — 챕터 %d부터는 정식판에서" % (run.last_chapter + 1)
	elif run.state == "won":
		title = "모든 챕터를 지켰다!"
	elif lost:
		title = "마을이 무너졌다"
		sub = "챕터 %d · 밤 %d" % [fought.x, fought.y]
	elif run.chapter_cleared:
		title = "챕터 %d 최종 보스 클리어" % fought.x
		sub = "다음: 챕터 %d · %s" % [run.chapter, run.chapter_info()["name"]]
	elif battle != null and battle.result == "hold":
		title = "밤 %d — 간신히 버텼다" % fought.y
		sub = "병사가 모두 쓰러져 마을이 약탈당했다 · 다음 밤에 다시"
	else:
		title = "밤 %d 클리어" % fought.y
		sub = "챕터 %d · %s" % [fought.x, PD.CHAPTERS[fought.x - 1]["name"]]
	if run.chapter_cleared and run.state == "prep":
		sub = "시간 %s%s · %s" % [_fmt_time(run.last_chapter_time), (" · %d위!" % last_rank) if last_rank > 0 else "", sub]
	if last_embers > 0:
		sub += "  ·  ★3 불씨 +%d" % last_embers
	var tw: float = font_bold.get_string_size(title, HORIZONTAL_ALIGNMENT_LEFT, -1, 24).x + 40.0
	var pk: float = clampf((end_t - 18) / 8.0, 0.0, 1.0)
	var plate := Rect2(320 - tw * pk / 2.0, py - 16, tw * pk, 34)
	if pk > 0.0:
		rrect(Rect2(plate.position + Vector2(0, 3), plate.size), (tone.darkened(0.4)))
		rrect(plate, tone)
	if pk >= 1.0:
		draw_string(font_bold, Vector2(320 - (tw - 40.0) / 2.0, py + 9).round(), title, HORIZONTAL_ALIGNMENT_LEFT, -1, 24, UI["lacquer"])
	if end_t > 24 and sub != "":
		var sw: String = fit(sub, 320.0)
		text(Vector2(320 - font.get_string_size(sw, HORIZONTAL_ALIGNMENT_LEFT, -1, 12).x / 2.0, py + 40), sw, UI["muted"])
	# 별: 마을이 얼마나 멀쩡한지 (3 = 거의 그대로)
	if not lost:
		var vk: float = clampf(battle.village_hp / PD.VILLAGE_HP, 0.0, 1.0)
		var n_st: int = run.last_loot.get("stars", PD.night_stars(vk))
		for i in 3:
			var st_t: int = 28 + i * 6
			if end_t < st_t:
				continue
			var pop: float = 1.0 + 0.6 * maxf(0.0, 1.0 - (end_t - st_t) / 6.0)
			var sc := Vector2(290 + i * 30, py + 62)
			var on: bool = i < n_st
			draw_set_transform(sc, 0.0, Vector2(pop, pop) * 2.0)
			_draw_stars(Vector2.ZERO, 1) if on else draw_colored_polygon(PackedVector2Array([Vector2(0, -3.5), Vector2(3.5, 0), Vector2(0, 3.5), Vector2(-3.5, 0)]), Color("4a3e2a"))
			draw_set_transform(Vector2.ZERO)
	# 전리품
	if not lost and not run.last_loot.is_empty() and end_t > 42:
		var vk2: int = roundi(clampf(battle.village_hp / PD.VILLAGE_HP, 0.0, 1.0) * 100.0)
		var rule: String = ["진주만", "흙 · 진주", "흙 · 진주", "뽑기권 · 흙 · 진주"][clampi(run.last_loot.get("stars", 3), 0, 3)]
		text(Vector2(0, py + 94), "전리품 — 마을 %d%% · %s" % [vk2, rule], tone, 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
		var items: Array = []
		if run.last_loot["tickets"] > 0:
			items.append(["ticket", "뽑기권", run.last_loot["tickets"]])
		if run.last_loot["clay"] + run.last_loot.get("chapter_clay", 0) > 0:
			items.append(["clay", "흙", run.last_loot["clay"] + run.last_loot.get("chapter_clay", 0)])
		if run.last_loot.get("pearls", 0) > 0:
			items.append(["pearl", "진주", run.last_loot["pearls"]])
		for it in run.last_loot["equip"]:
			items.append([it["type"], KilnRun.equip_name(it), 1])
		var w := 70.0
		var x0: float = 320.0 - items.size() * w / 2.0
		for i in items.size():
			var it_t: int = 46 + i * 7
			if end_t < it_t:
				continue
			var bounce: float = -10.0 * maxf(0.0, sin(minf(1.0, (end_t - it_t) / 10.0) * PI))
			var cx: float = x0 + i * w + w / 2.0
			var br := Rect2(cx - 22, py + 104 + bounce, 44, 44)
			rrect(br, UI["deep"])
			rline(br, UI["gold"] if i == 0 else UI["bronze"])
			draw_icon(items[i][0], br.position + Vector2(9, 9), 2.0)
			if items[i][2] > 1:
				text(br.position + Vector2(26, 42), "×%d" % items[i][2], C["text"])
			var nm: String = fit(items[i][1], w - 4.0)
			text(Vector2(cx - font.get_string_size(nm, HORIZONTAL_ALIGNMENT_LEFT, -1, 12).x / 2.0, py + 164), nm, C["text"])
	if end_t >= 56:
		if run.state == "prep":
			button(Rect2(220, py + 184, 200, 30), "다음 챕터로  (Enter)" if run.chapter_cleared else "다음 아침  (Enter)", "next", UI["gold"], true, true)
		else:
			button(Rect2(160, py + 184, 150, 30), "처음 화면  (Enter)", "next", UI["gold"], true, true)
			button(Rect2(330, py + 184, 150, 30), "전술 강화", "to_meta2", UI["gold"])


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
const KILN_BODY_RECT := Rect2(50, 60, 240, 240)   # 가마 그림(160px)을 1.5배로 — 화면에서 한 점이 3px 로 고르게 (o 기준)
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
const FIRE_O := Vector2(0, 44)


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
	if state != "fire" and state != "load":
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
	_draw_kiln_body(FIRE_O, 0.0)
	text(Vector2(0, 30), "불 올리기", C["accent"], 24, 340.0, HORIZONTAL_ALIGNMENT_CENTER)
	if state == "fire":
		text(Vector2(0, 390), "불을 올릴수록 요변이 나올 확률도, 깨질 확률도 오른다", C["dim"], 12, 340.0, HORIZONTAL_ALIGNMENT_CENTER)
	panel(Rect2(350, 14, 280, 372))
	var x := 364.0
	text(Vector2(x, 34), "불 세기  %d / %d" % [kiln.heat, PD.KILN_MAX_HEAT], C["text"], 12)
	for i in PD.KILN_MAX_HEAT:
		var zc: Color = C["good"] if i < PD.KILN_SAFE_HEAT else C["accent"] if i < 7 else C["danger"]
		draw_rect(Rect2(x + i * 25, 42, 21, 12), zc if i < kiln.heat else zc.darkened(0.7))
	var zone := "안전 — 절대 안 깨짐" if kiln.heat <= PD.KILN_SAFE_HEAT else "위험" if kiln.heat < 8 else "도박!"
	text(Vector2(x, 72), zone, C["good"] if kiln.heat <= PD.KILN_SAFE_HEAT else C["accent"] if kiln.heat < 8 else C["danger"], 12)
	var o: Dictionary = kiln.odds()
	text(Vector2(x + 120, 72), "병사 한 명마다", C["dim"])
	# 넷을 더하면 꼭 100% (깨짐 → 요변 → 상품 순서로 굴린 실제 몫)
	var pc: Dictionary = PD.percent_100(PD.kiln_shares(o))
	text(Vector2(x, 88), "요변 %d%%" % pc["legend"], C["accent"])
	text(Vector2(x + 70, 88), "귀한 빛깔 · 힘 2.6배 · 특수기", C["dim"])
	text(Vector2(x, 101), "상품 %d%%" % pc["fine"], C["text"])
	text(Vector2(x + 70, 101), "잘 구워짐 · 힘 1.5배", C["dim"])
	text(Vector2(x, 114), "보통 %d%%" % pc["normal"], UI["muted"])
	text(Vector2(x + 70, 114), "그냥 구워짐", C["dim"])
	text(Vector2(x, 127), "깨짐 %d%%" % pc["crack"], C["danger"] if pc["crack"] > 0 else C["dim"])
	text(Vector2(x + 70, 127), fit("파편 %d/%d — 다 모으면 요변 확정" % [kiln.shards, kiln.shard_need] if not kiln.guaranteed_legend() else "이번 가마: 요변 1개 확정!", 180.0), C["dim"] if not kiln.guaranteed_legend() else C["accent"])
	# 가마신과 내기
	var br := Rect2(358, 136, 264, 156)
	draw_rect(br, C["card"].darkened(0.2))
	draw_rect(br, C["accent"] if bet_on else C["dim"].darkened(0.3), false, 1.0)
	text(br.position + Vector2(8, 16), "가마신과 내기", C["accent"])
	text(br.position + Vector2(8, 16), "꽝 %d/%d → 대박 확정" % [run.bet_busts, run.bet_pity()], C["dim"], 12, br.size.x - 16, HORIZONTAL_ALIGNMENT_RIGHT)
	for i in PD.BET_ODDS.size():
		var o2: Array = PD.BET_ODDS[i]
		var yy: float = br.position.y + 34 + i * 15
		text(Vector2(br.position.x + 8, yy), o2[1], C["danger"] if o2[0] == "bust" else C["text"])
		text(Vector2(br.position.x + 58, yy), "%d%%" % roundi(o2[2] * 100.0), C["dim"])
		text(Vector2(br.position.x + 92, yy), fit(o2[3], 166.0), C["dim"])
	button(Rect2(br.position.x + 8, br.end.y - 26, br.size.x - 16, 20), "내기 건다! (가마를 열 때)" if bet_on else "내기 안 함 — 눌러서 걸기", "bet", C["accent"] if bet_on else C["dim"])
	button(Rect2(358, 302, 264, 30), "불 올리기  (스페이스)", "heat", C["fire"].lightened(0.3), kiln.heat < PD.KILN_MAX_HEAT)
	button(Rect2(358, 342, 264, 30), "가마 열기  (Enter)", "open")


func _draw_reveal() -> void:
	draw_rect(Rect2(Vector2.ZERO, VIEW), C["bg"])
	if reveal_t < OPEN_T:
		_draw_kiln_open()
		return
	var surv := _survivors()
	var cracked: int = kiln.results.size() - surv.size()
	text(Vector2(0, 34), "가마에서 나온 병사" if not surv.is_empty() else "모두 깨졌습니다…", UI["gold"], 24, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	for j in surv.size():
		var i: int = surv[j]
		if i < reveal_shown and card_at.has(i):
			if surv.size() > 8:
				_draw_card_small(kiln.results[i], _card_pos(j, surv.size()), t - card_at[i])
			else:
				_draw_card(kiln.results[i], _card_pos(j, surv.size()), t - card_at[i])
	if reveal_shown >= kiln.results.size():
		var counts := {}
		for r2 in kiln.results:
			if not r2["cracked"]:
				counts[r2["element"]] = counts.get(r2["element"], 0) + 1
		var syn := []
		for e in counts:
			if counts[e] >= PD.SYNERGY_COUNT:
				syn.append(PD.SYNERGY_NAME[e])
		var parts := []
		if cracked > 0:
			parts.append("깨진 인형 %d · 파편 +%d" % [cracked, cracked])
		if run.combo != "":
			parts.append("합동 기술 %s: %s" % [PD.COMBOS[run.combo]["name"], "쓸 수 있음" if run.combo_ready(run.combo) else "병사 부족"])
		text(Vector2(0, 338), "   ·   ".join(parts), C["accent"] if not syn.is_empty() else C["dim"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
		button(Rect2(230, 348, 180, 30), "가마로  (Enter)", "fight", UI["gold"], true, true)
	if not gfx.is_empty():
		_draw_gfx()


## 꺼낸 병사 카드: 등급 색 테두리 + 둥근 도자 받침 위에 선 병사 + 이름·구움 상태. 살짝 튀어 오르며 나타난다
func _draw_card(r: Dictionary, p: Vector2, age: int) -> void:
	var k := clampf(age / 12.0, 0.0, 1.0)
	var sc: float = 0.8 + 0.2 * _ease_back(k)
	var g: String = PD.ROLE_GRADE.get(r["role"], "common")
	var gc: Color = GRADE_COL[g]
	var high: bool = GFX_TAPS.has(g)
	glow(self, p + Vector2(0, -6), 74.0 * sc, Color(gc.r, gc.g, gc.b, 0.16 if high else 0.05))
	draw_set_transform(p, 0.0, Vector2(sc, sc))
	var rect := Rect2(-58, -62, 116, 124)
	rrect(Rect2(rect.position + Vector2(0, 3), rect.size), Color(0, 0, 0, 0.45))
	if not nine("card_9", rect, 6, Color.WHITE.lerp(gc, 0.55)):
		rrect(rect, UI["lacquer"])
		rline(rect, gc)
	text(Vector2(-50, -44), PD.GRADE_NAME[g], gc)
	var tier_label: String = PD.TIER_NAME_KILN[r["tier"]]
	if r.get("refire", false):
		tier_label = ("%s→%s" % [PD.TIER_NAME_KILN[r["before"]], PD.TIER_NAME_KILN[r["tier"]]]) if r["before"] != r["tier"] else "그대로"
	var tc: Color = C["accent"] if r["tier"] == "legend" else C["text"] if r["tier"] == "fine" else UI["muted"]
	text(Vector2(-50, -44), tier_label, tc, 12, 100.0, HORIZONTAL_ALIGNMENT_RIGHT)
	# 둥근 도자 받침 (유약 색 테)
	var ec: Color = C[r["element"]]
	draw_set_transform(p + Vector2(0, 27) * sc, 0.0, Vector2(sc, sc * 0.3))
	draw_circle(Vector2(0, 8), 30.0, ec.darkened(0.7))
	draw_circle(Vector2.ZERO, 30.0, ec.darkened(0.35))
	draw_arc(Vector2.ZERO, 30.0, 0.0, TAU, 40, ec.lightened(0.25), 2.0)
	# 병사 그리기는 안에서 변환을 되돌리므로 화면 좌표로 바로 그린다
	draw_set_transform(Vector2.ZERO)
	draw_ally_shape(p + Vector2(0, -1) * sc, r["role"], r["element"], r["tier"], 2.0 * sc)
	draw_set_transform(p, 0.0, Vector2(sc, sc))
	text(Vector2(-58, 52), fit(r["name"], 106.0), gc, 12, 116.0, HORIZONTAL_ALIGNMENT_CENTER)
	draw_set_transform(Vector2.ZERO)


## 작은 카드 (많이 구웠을 때): 등급 색 테두리 + 병사 + 이름(역할만) + 요변·상품 표시
func _draw_card_small(r: Dictionary, p: Vector2, age: int) -> void:
	var k := clampf(age / 10.0, 0.0, 1.0)
	var sc: float = 0.8 + 0.2 * _ease_back(k)
	var g: String = PD.ROLE_GRADE.get(r["role"], "common")
	var gc: Color = GRADE_COL[g]
	if GFX_TAPS.has(g):
		glow(self, p, 44.0 * sc, Color(gc.r, gc.g, gc.b, 0.16))
	draw_set_transform(p, 0.0, Vector2(sc, sc))
	var rect := Rect2(-29, -42, 58, 84)
	rrect(Rect2(rect.position + Vector2(0, 2), rect.size), Color(0, 0, 0, 0.45))
	if not nine("card_9", rect, 6, Color.WHITE.lerp(gc, 0.55)):
		rrect(rect, UI["lacquer"])
		rline(rect, gc)
	if r["tier"] != "normal":
		text(Vector2(-27, -28), PD.TIER_NAME_KILN[r["tier"]], C["accent"] if r["tier"] == "legend" else C["text"], 12, 54.0, HORIZONTAL_ALIGNMENT_CENTER)
	var ec: Color = C[r["element"]]
	draw_set_transform(p + Vector2(0, 17) * sc, 0.0, Vector2(sc, sc * 0.3))
	draw_circle(Vector2.ZERO, 18.0, ec.darkened(0.35))
	draw_arc(Vector2.ZERO, 18.0, 0.0, TAU, 32, ec.lightened(0.25), 2.0)
	draw_set_transform(Vector2.ZERO)
	draw_ally_shape(p + Vector2(0, 2) * sc, r["role"], r["element"], r["tier"], 1.25 * sc)
	draw_set_transform(p, 0.0, Vector2(sc, sc))
	text(Vector2(-29, 36), fit(PD.ROLE_NAME_KILN[r["role"]], 56.0), gc, 12, 58.0, HORIZONTAL_ALIGNMENT_CENTER)
	draw_set_transform(Vector2.ZERO)


## 가마 문이 열린다: 문틈의 빛이 커지고 연기가 오르다 번쩍 (등급 색 없이)
func _draw_kiln_open() -> void:
	var k := clampf(float(reveal_t) / OPEN_T, 0.0, 1.0)
	var o := Vector2(150, 10)
	_draw_kiln_body(o, 0.0)
	var box := _door_screen_box(o + _shake_now)
	var dc := box.get_center()
	if door_mask != null:
		draw_texture_rect(door_mask, Rect2(o + _shake_now + KILN_BODY_RECT.position, KILN_BODY_RECT.size), false, Color(0.55, 0.3, 0.12, 0.35 + 0.4 * k))
	# 문 안쪽 빛: 바닥이 가장 밝고 위로 옅어진다 (평평하게 칠하지 않게 겹친 빛으로)
	glow(self, Vector2(dc.x, box.end.y - 10), box.size.x * (0.45 + 0.3 * k), Color(1.0, 0.82, 0.55, 0.25 + 0.55 * k), 0.6)
	glow(self, dc + Vector2(0, box.size.y * 0.1), box.size.x * (0.3 + 0.25 * k), Color(NEUTRAL.r, NEUTRAL.g, NEUTRAL.b, 0.15 + 0.5 * k))
	glow(self, dc, 40.0 + 170.0 * k * k, Color(NEUTRAL.r, NEUTRAL.g, NEUTRAL.b, 0.05 + 0.3 * k * k))
	for i in 9:
		var sp := Vector2(dc.x - 60 + i * 15, box.position.y - fmod(reveal_t * 1.2 + i * 17.0, 90.0))
		glow(self, sp, 14.0 + fmod(reveal_t * 0.4 + i * 5.0, 12.0), Color(0.8, 0.78, 0.76, 0.2 * (1.0 - k * 0.5)))
	text(Vector2(0, 352), "가마 문을 엽니다…", NEUTRAL, 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)


## 작업대: 뽑은 흙 인형이 가마 앞에 줄지어 선다 (아직 굽지 않은 흙빛)
func _bench_pos(i: int, n: int) -> Vector2:
	var row: int = i / 10
	var in_row: int = mini(10, n - row * 10)
	return Vector2(171 + (i % 10 - (in_row - 1) / 2.0) * 30.0, 318 - row * 14)


func _draw_bench() -> void:
	var n: int = run.queue.size()
	var order: Array = range(n)
	order.reverse()   # 뒷줄부터
	for i in order:
		var q: Dictionary = run.queue[i]
		var p := _bench_pos(i, n)
		var age: int = t - drawn_at.get(i, -999)
		if age < 0:
			continue
		var pop: float = _ease_back(clampf(age / 12.0, 0.0, 1.0))
		glow(self, p + Vector2(0, 13), 13.0, Color(0, 0, 0, 0.55), 0.3)
		if q["kind"] == "new":
			draw_clay(p + Vector2(0, (1.0 - pop) * 8.0), q["role"], maxf(0.2, pop))
		else:
			draw_ally_shape(p, q["role"], q["element"], run.soldier(q["id"]).get("tier", "normal"), 1.0)
			text(p + Vector2(-16, -20), "다시", UI["muted"], 12, 32.0, HORIZONTAL_ALIGNMENT_CENTER)
	if n == 0:
		text(Vector2(6, 322), "뽑으면 흙 인형이 여기 섭니다", UI["muted"], 12, 330.0, HORIZONTAL_ALIGNMENT_CENTER)


## 흙 인형이 하나씩 가마 문으로 뛰어든다
const LOAD_FLY := 22


func _load_start(i: int) -> int:
	var gap: int = clampi(90 / maxi(1, run.queue.size()), 3, 9)
	return 10 + maxi(0, i) * gap


func _draw_loading() -> void:
	var n: int = run.queue.size()
	var door := _door_screen_box(FIRE_O + _shake_now).get_center() + Vector2(0, 26)
	for i in n:
		var q: Dictionary = run.queue[i]
		var row: int = i / 10
		var in_row: int = mini(10, n - row * 10)
		var p0 := Vector2(170 + (i % 10 - (in_row - 1) / 2.0) * 26.0, 360 + row * 12)
		var k := clampf(float(load_t - _load_start(i)) / LOAD_FLY, 0.0, 1.0)
		if k >= 1.0:
			continue
		var e: float = k * k * (3.0 - 2.0 * k)
		var p := p0.lerp(door, e) + Vector2(0, -sin(k * PI) * 64.0)
		var sk: float = 1.0 - 0.6 * e
		if q["kind"] == "new":
			draw_clay(p, q["role"], sk)
		else:
			draw_ally_shape(p, q["role"], q["element"], run.soldier(q["id"]).get("tier", "normal"), sk)


## 굽기 전 흙 인형: 병사 그림의 밝기만 살려 흙빛 네 단계로 바꾼 그림 (유약 색·등급 색은 아직 없다)
var _clay_cache := {}


func clay_tex(_role := "") -> Texture2D:
	# 모든 흙 인형은 똑같은 흙덩이 (무엇이 될지 모양으로도 알 수 없게, 2026-11-28 사용자 요청)
	if _clay_cache.has("lump"):
		return _clay_cache["lump"]
	var w := 20
	var h := 24
	var img := Image.create(w, h, false, Image.FORMAT_RGBA8)
	var inside := func(x: int, y: int) -> bool:
		var bx: float = (x + 0.5 - 10.0) / 8.5
		var by: float = (y + 0.5 - 16.5) / 7.5
		var hx: float = (x + 0.5 - 10.0) / 4.8
		var hy: float = (y + 0.5 - 6.5) / 4.6
		return bx * bx + by * by <= 1.0 or hx * hx + hy * hy <= 1.0
	for y in h:
		for x in w:
			if not inside.call(x, y):
				continue
			var edge: bool = not (inside.call(x - 1, y) and inside.call(x + 1, y) and inside.call(x, y - 1) and inside.call(x, y + 1))
			# 왼쪽 위에서 빛: 왼쪽 위가 밝고 오른쪽 아래가 어둡다
			var head: bool = y < 11
			var cy: float = 6.5 if head else 16.5
			var lit: float = -(x - 10.0) / 9.0 * 0.6 - (y - cy) / 8.0 * 0.8
			var tone := 2
			if lit > 0.45:
				tone = 3
			elif lit < -0.35:
				tone = 1
			img.set_pixel(x, y, CLAY_TONES[0] if edge else CLAY_TONES[tone])
	# 목 자국과 손가락 자국 몇 점
	for q in [Vector2i(8, 11), Vector2i(9, 11), Vector2i(10, 11), Vector2i(11, 11), Vector2i(7, 16), Vector2i(12, 19), Vector2i(13, 15)]:
		img.set_pixelv(q, CLAY_TONES[1])
	var out := ImageTexture.create_from_image(img)
	_clay_cache["lump"] = out
	return out


## 흙 인형 그리기 (발바닥 기준은 draw_sprite 와 같다)
func draw_clay(pos: Vector2, role: String, scale_k := 1.0) -> void:
	var tx := clay_tex(role)
	if tx != null:
		var sz: Vector2 = tx.get_size() * scale_k
		draw_texture_rect(tx, Rect2(pos + Vector2(-sz.x / 2.0, 12.8 * scale_k - sz.y), sz), false)
		return
	draw_rect(Rect2(pos + Vector2(-6, -4) * scale_k, Vector2(12, 16) * scale_k), CLAY_TONES[2])
	draw_circle(pos + Vector2(0, -9) * scale_k, 5.0 * scale_k, CLAY_TONES[3])


# ---------------- 대기실 ----------------
## 대기실: 왼쪽 부대(자리 cap), 오른쪽 대기실(300칸, 45칸씩 쪽). 대기실 병사를 누르면 부대로 (자리가 없으면 골라 두고 부대 병사를 눌러 맞바꾼다)
const RES_COLS := 9
const RES_ROWS := 5
const MINI := Vector2(38, 46)


func _reserve_view() -> Array:
	var list: Array = run.reserve.duplicate()
	if res_sort == "grade":
		list.sort_custom(func(a, b):
			var ga: int = PD.GRADES.find(PD.ROLE_GRADE[a["role"]])
			var gb: int = PD.GRADES.find(PD.ROLE_GRADE[b["role"]])
			if ga != gb:
				return ga > gb
			if a["star"] != b["star"]:
				return a["star"] > b["star"]
			if a["role"] != b["role"]:
				return a["role"] < b["role"]
			return a["id"] < b["id"])
	else:
		list.reverse()
	return list


func _army_cell(i: int) -> Rect2:
	return Rect2(14 + (i % 6) * 40, 74 + (i / 6) * 48, MINI.x, MINI.y)


func _res_cell(li: int) -> Rect2:
	return Rect2(272 + (li % RES_COLS) * 40, 74 + (li / RES_COLS) * 48, MINI.x, MINI.y)


func _barracks_input() -> void:
	if clicked("lobby") or pressed(KEY_ESCAPE):
		state = "prep"
		res_pick = -1
		return
	if clicked("help"):
		show_help = not show_help
	if clicked("rs_prev"):
		res_page = maxi(0, res_page - 1)
	if clicked("rs_next"):
		res_page += 1
	if clicked("rs_sort"):
		res_sort = "new" if res_sort == "grade" else "grade"
	if clicked("merge_all"):
		var n := 0
		while not run.merge_groups().is_empty() and n < 200:
			if run.merge(run.merge_groups()[0]).is_empty():
				break
			n += 1
		if n > 0:
			float_text(Vector2(250, 200), "합치기 %d번!" % n, C["accent"], 24)
			burst(Vector2(320, 200), UI["gold"], 30, 3.5, 2.5)
			shake = 4.0
		res_pick = -1
		return
	if selected >= 0 and clicked("to_res"):
		run.to_reserve(selected)
		selected = -1
		return
	if res_pick >= 0 and clicked("to_army"):
		run.to_army(res_pick)
		res_pick = -1
		return
	var rel_id: int = res_pick if res_pick >= 0 else selected
	if rel_id >= 0 and clicked("release"):
		if release_armed == rel_id:
			run.release(rel_id)
			selected = -1
			res_pick = -1
			release_armed = -1
		else:
			release_armed = rel_id
		return
	for s in run.army:
		if clicked("bcard%d" % s["id"]):
			if res_pick >= 0:
				run.swap(s["id"], res_pick)
				res_pick = -1
				selected = -1
			else:
				selected = s["id"] if selected != s["id"] else -1
			release_armed = -1
			return
	for s in run.reserve:
		if clicked("rcard%d" % s["id"]):
			if res_pick == s["id"]:
				res_pick = -1
			elif run.army.size() < run.cap():
				run.to_army(s["id"])
				res_pick = -1
			else:
				res_pick = s["id"]
			selected = -1
			release_armed = -1
			return


## 작은 병사 칸 (대기실·부대 공용)
func _draw_mini(r: Rect2, s: Dictionary, picked: bool, id: String) -> void:
	buttons.append({"rect": r, "id": id})
	var gc: Color = GRADE_COL[PD.ROLE_GRADE[s["role"]]]
	var hov: bool = r.has_point(get_local_mouse_position())
	if hov:
		hover_sid = s["id"]
	if not nine("card_9", r, 5, Color.WHITE.lerp(gc, 0.6).lightened(0.1 if hov else 0.0)):
		rrect(r, UI["lacquer"])
		rline(r, gc)
	if picked:
		rline(r.grow(1), UI["gold"])
		rline(r.grow(2), Color(1.0, 0.85, 0.3, 0.5 + 0.4 * sin(t * 0.2)))
	if s["tier"] == "legend":
		glow(self, r.get_center(), 22.0, Color(1.0, 0.95, 0.8, 0.14))
	draw_ally_shape(Vector2(r.get_center().x, r.position.y + 25), s["role"], s["element"], s["tier"], 1.0, false, s["star"], s.get("promo", "") != "")
	_draw_stars(Vector2(r.get_center().x, r.end.y - 4), s["star"])
	if s["tier"] != "normal":
		draw_circle(r.position + Vector2(6, 6), 2.5, UI["gold"] if s["tier"] == "legend" else C["text"])
	if run.is_queued(s["id"]):
		rrect(r, Color(0.05, 0.03, 0.02, 0.65))


func _draw_barracks() -> void:
	hover_sid = -1
	_draw_topbar("대기실", true)
	# 부대
	panel(Rect2(6, 56, 252, 284), "부대 %d / %d" % [run.army.size(), run.cap()])
	for i in run.cap():
		var r := _army_cell(i)
		if r.end.y > 236:
			break
		if i < run.army.size():
			var s: Dictionary = run.army[i]
			_draw_mini(r, s, selected == s["id"], "bcard%d" % s["id"])
		else:
			rrect(r, UI["deep"])
			rline(r, UI["line"])
	# 고른 병사·할 일
	var info := Rect2(14, 240, 236, 92)
	rrect(info, UI["deep"])
	var cur: Dictionary = run.soldier(selected) if selected >= 0 else {}
	if res_pick >= 0:
		var rp: Dictionary = run.soldier(res_pick)
		text(info.position + Vector2(8, 16), fit(rp.get("name", ""), 220.0), GRADE_COL[PD.ROLE_GRADE[rp["role"]]])
		text(info.position + Vector2(8, 32), "부대 병사를 누르면 맞바꿉니다", UI["muted"])
		button(Rect2(info.position.x + 8, info.position.y + 40, 104, 22), "부대로", "to_army", UI["gold"], run.army.size() < run.cap(), true)
		button(Rect2(info.position.x + 118, info.position.y + 40, 104, 22), "정말?" if release_armed == res_pick else "돌려보내기", "release", C["danger"] if release_armed == res_pick else UI["muted"], not run.is_queued(res_pick))
	elif not cur.is_empty():
		text(info.position + Vector2(8, 16), fit(cur["name"], 220.0), GRADE_COL[PD.ROLE_GRADE[cur["role"]]])
		text(info.position + Vector2(8, 32), "대기실 병사를 고르면 맞바꿀 수 있어요", UI["muted"])
		button(Rect2(info.position.x + 8, info.position.y + 40, 104, 22), "대기실로", "to_res", UI["gold"], run.reserve.size() < PD.RESERVE_MAX)
		button(Rect2(info.position.x + 118, info.position.y + 40, 104, 22), "정말?" if release_armed == selected else "돌려보내기", "release", C["danger"] if release_armed == selected else UI["muted"], not run.is_queued(selected))
	else:
		text(info.position + Vector2(8, 16), "대기실 병사를 누르면 부대로 들어갑니다", C["text"])
		text(info.position + Vector2(8, 32), "자리가 없으면 골라 두고 부대 병사와 맞바꿔요", UI["muted"])
	var ng: int = run.merge_groups().size()
	button(Rect2(info.position.x + 8, info.position.y + 66, 214, 22), "같은 병사 3명 모두 합치기 (%d)" % ng, "merge_all", C["accent"], ng > 0)
	# 대기실
	var view := _reserve_view()
	var per: int = RES_COLS * RES_ROWS
	var pages: int = maxi(1, (view.size() + per - 1) / per)
	res_page = clampi(res_page, 0, pages - 1)
	panel(Rect2(264, 56, 370, 284), "대기실 %d / %d" % [run.reserve.size(), PD.RESERVE_MAX])
	if view.is_empty():
		text(Vector2(264, 190), "비어 있음 — 부대 자리를 넘게 구운 병사가 여기 모입니다", UI["muted"], 12, 370.0, HORIZONTAL_ALIGNMENT_CENTER)
	for li in mini(per, view.size() - res_page * per):
		var s2: Dictionary = view[res_page * per + li]
		_draw_mini(_res_cell(li), s2, res_pick == s2["id"], "rcard%d" % s2["id"])
	button(Rect2(272, 318, 70, 18), "등급순" if res_sort == "grade" else "최근순", "rs_sort", UI["muted"])
	if pages > 1:
		button(Rect2(500, 318, 26, 18), "◀", "rs_prev", UI["gold"], res_page > 0)
		text(Vector2(526, 332), "%d / %d" % [res_page + 1, pages], UI["gold"], 12, 72.0, HORIZONTAL_ALIGNMENT_CENTER)
		button(Rect2(600, 318, 26, 18), "▶", "rs_next", UI["gold"], res_page < pages - 1)
	button(Rect2(6, 348, 628, 30), "다 골랐어요 — 로비로", "lobby", UI["gold"], true, true)
	if hover_sid >= 0:
		var hs: Dictionary = run.soldier(hover_sid)
		if not hs.is_empty():
			var mp := get_local_mouse_position()
			draw_unit_tip(hs, mp + (Vector2(14, -40) if mp.x < 380 else Vector2(-250, -40)))
	if show_help:
		_draw_help()



## 합동 기술 고르기: 병사 조합마다 하나씩. 하나만 골라 쓴다 (2026-11-28)
func _draw_combo_pick() -> void:
	_draw_topbar("합동 기술 고르기", true)
	text(Vector2(14, 70), fit("부대에 필요한 병사가 모두 있으면, 고른 하나만 전투에서 %d초 뒤 첫 발동, 그 뒤 %d초마다" % [PD.SYNERGY_FIRST / PD.FPS, PD.SYNERGY_EVERY / PD.FPS], 612.0), UI["muted"])
	var have: Array = run.army_roles()
	var i := 0
	for id in PD.COMBOS:
		var c: Dictionary = PD.COMBOS[id]
		var r := Rect2(6 + (i % 2) * 316, 80 + (i / 2) * 66, 310, 60)
		var col: Color = C[c["element"]].lightened(0.3)
		var ok: bool = run.combo_ready(id)
		var sel: bool = run.combo == id
		var pvr := Rect2(r.end.x - 52, r.position.y + 24, 44, 16)
		buttons.append({"rect": pvr, "id": "pv_combo_" + id})
		buttons.append({"rect": r, "id": "cb_" + id})
		var hov: bool = r.has_point(get_local_mouse_position())
		rrect(Rect2(r.position + Vector2(0, 2), r.size), Color(0, 0, 0, 0.4))
		rrect(r, UI["lacquer"].lerp(col, 0.12 if hov or sel else 0.0))
		rline(r, UI["gold"] if sel else (col if ok else Color("4a4458")))
		if sel:
			rline(r.grow(1), Color(1.0, 0.85, 0.3, 0.5 + 0.4 * sin(t * 0.15)))
		draw_combo_icon(id, r.position + Vector2(8, 4), 26.0)
		text(r.position + Vector2(40, 18), c["name"], col)
		text(r.position + Vector2(10, 18), "고름 ✓" if sel else ("쓸 수 있음" if ok else "병사 부족"), UI["gold"] if sel else (C["good"] if ok else UI["muted"]), 12, r.size.x - 20.0, HORIZONTAL_ALIGNMENT_RIGHT)
		rrect(pvr, UI["deep"])
		rline(pvr, UI["gold"] if pvr.has_point(get_local_mouse_position()) else UI["bronze"])
		text(pvr.position + Vector2(0, 12), "▶ 영상", UI["gold"], 12, pvr.size.x, HORIZONTAL_ALIGNMENT_CENTER)
		# 필요한 병사: 있으면 밝게, 없으면 어둡게
		var x: float = r.position.x + 40.0
		for ni in c["needs"].size():
			var rr: String = c["needs"][ni]
			var nm: String = PD.ROLE_NAME_KILN[rr]
			text(Vector2(x, r.position.y + 35), nm, C["text"] if have.has(rr) else Color("6b6478"))
			x += font.get_string_size(nm, HORIZONTAL_ALIGNMENT_LEFT, -1, 12).x + 6.0
			if x > r.end.x - 70.0:
				break
			if ni < c["needs"].size() - 1 or c.has("any"):
				text(Vector2(x - 4, r.position.y + 35), "+", UI["muted"])
				x += 6.0
		if c.has("any"):
			var nm2: String = "%s 중 %d" % ["·".join(c["any"][0].map(func(z): return PD.ROLE_NAME_KILN[z])), c["any"][1]]
			text(Vector2(x, r.position.y + 35), fit(nm2, r.end.x - x - 60.0), C["text"] if ok else Color("6b6478"))
		var cp: Dictionary = run.combo_power(id)
		text(r.position + Vector2(10, 51), fit("공격력 합 × %d%%" % roundi(c["pct"] * 100.0), 160.0), C["accent"].lerp(C["text"], 0.4))
		text(r.position + Vector2(10, 51), ("지금 %d × %d%% = %d" % [roundi(cp["atk_sum"]), roundi(c["pct"] * 100.0), roundi(cp["dmg"])]) if cp["n"] > 0 else "-", C["good"] if ok else UI["muted"], 12, r.size.x - 20.0, HORIZONTAL_ALIGNMENT_RIGHT)
		i += 1
	button(Rect2(6, 348, 628, 30), "로비로" + ((" — %s" % PD.COMBOS[run.combo]["name"]) if run.combo != "" else ""), "lobby", UI["gold"], true, true)



func _shop_icon(key: String) -> String:
	var it: Dictionary = PD.SHOP_ITEMS[key]
	if it["stat"] == "ticket":
		return "ticket"
	if it["stat"] == "equip":
		return it["type"]
	return key


## 진주 상점 물건 목록·확률표 (이 챕터 기준. 장비는 챕터 3부터)
func _draw_shop_table() -> void:
	draw_rect(Rect2(Vector2.ZERO, VIEW), Color(0, 0, 0, 0.6))
	var r := Rect2(110, 46, 420, 300)
	panel(r, "오늘의 물건 — 목록·확률 (챕터 %d)" % run.chapter)
	var table: Array = PD.shop_table(run.chapter)
	var y: float = r.position.y + 26.0
	text(Vector2(r.position.x + 14, y), "물건", UI["muted"])
	text(Vector2(r.position.x + 150, y), "효과", UI["muted"])
	text(Vector2(r.position.x + 300, y), "값", UI["muted"])
	text(Vector2(r.position.x + 350, y), "한 칸 확률", UI["muted"])
	y += 6.0
	for k in PD.SHOP_ITEMS:
		var it: Dictionary = PD.SHOP_ITEMS[k]
		var row: Array = table.filter(func(x): return x[0] == k)
		var on: bool = not row.is_empty()
		y += 21.0
		draw_rect(Rect2(r.position.x + 8, y - 15, r.size.x - 16, 19), Color(1, 1, 1, 0.03 if int(y) % 2 == 0 else 0.0))
		draw_icon(_shop_icon(k), Vector2(r.position.x + 14, y - 12), 1.0)
		text(Vector2(r.position.x + 34, y), it["name"], UI["gold"] if on else Color("6b6478"))
		text(Vector2(r.position.x + 150, y), fit(it["desc"], 145.0), C["text"] if on else Color("6b6478"))
		text(Vector2(r.position.x + 300, y), "진주 %d" % run.price(k), C["text"] if on else Color("6b6478"))
		text(Vector2(r.position.x + 350, y), ("%.1f%%" % (row[0][1] * 100.0)) if on else "챕터 %d부터" % it.get("from", 1), C["accent"] if on else Color("6b6478"))
	text(Vector2(r.position.x + 14, r.end.y - 30), fit("진열 4칸 · 뽑기권은 하루 한 칸만 · 장비는 챕터 단계에 따라 + · ++ 가 나온다", r.size.x - 28.0), UI["muted"])
	button(Rect2(r.get_center().x - 50, r.end.y - 24, 100, 20), "닫기", "table_close", UI["gold"])



## 지금 전직할 수 있는 병사 (★3 이상 + 같은 진영 다른 병사가 있음). 부대 먼저
func _promo_ready() -> Array:
	var out: Array = []
	for sd in run.army + run.reserve:
		if not run.promo_partners(sd["id"]).is_empty():
			out.append(sd["id"])
	return out


## 할 수 있는 일 표시: 가능하면 금빛으로 깜빡이고 누를 수 있다
func _ready_chip(r: Rect2, label: String, id: String, on: bool) -> void:
	if on:
		buttons.append({"rect": r, "id": id})
		glow(self, r.get_center(), 40.0, Color(1.0, 0.8, 0.3, 0.10 + 0.06 * sin(t * 0.15)))
	rrect(r, Color("2e2616") if on else UI["deep"])
	rline(r, Color(1.0, 0.85, 0.35, 0.6 + 0.4 * sin(t * 0.15)) if on else Color("3a3346"))
	if on:
		draw_circle(r.position + Vector2(10, r.size.y / 2.0), 3.0, C["good"])
	text(r.position + Vector2(0, 16), label + (" ›" if on else ""), UI["gold"] if on else Color("6b6478"), 12, r.size.x, HORIZONTAL_ALIGNMENT_CENTER)



# ---------------- 도감 ----------------
## 도감: 병사 / 스킬 / 합동 기술 / 합치기·전직 (2026-11-28 "병사 도감 ... 조합도 어떻게 하면 되는지, 전직도 ... 스킬 도감도")
const CODEX_TABS := [["unit", "병사"], ["skill", "스킬"], ["combo", "합동 기술"], ["rule", "합치기 · 전직"]]


func _draw_codex() -> void:
	panel(Rect2(6, 4, 628, 40))
	button(Rect2(14, 13, 70, 22), "‹ 로비" if codex_from == "prep" else "‹ 처음 화면", "codex_back", UI["gold"])
	text(Vector2(94, 34), "도감", UI["gold"], 24)
	for i in CODEX_TABS.size():
		var tb: Array = CODEX_TABS[i]
		var on: bool = codex_tab == tb[0]
		button(Rect2(170 + i * 112, 13, 106, 22), tb[1], "ctab_" + tb[0], UI["gold"], true, on)
	match codex_tab:
		"unit", "skill":
			_draw_codex_roles()
			if codex_tab == "unit":
				_draw_codex_unit(codex_role)
			else:
				_draw_codex_skill(codex_role)
		"combo":
			_draw_codex_combos()
		"rule":
			_draw_codex_rules()


## 왼쪽: 등급별 병사 목록 (누르면 오른쪽에 자세히)
func _draw_codex_roles() -> void:
	panel(Rect2(6, 52, 204, 340))
	var y := 64.0
	for g in PD.GRADES:
		var roles: Array = PD.grade_roles(g)
		text(Vector2(14, y + 10), PD.GRADE_NAME[g], GRADE_COL[g])
		var x := 48.0
		for r in roles:
			var rr := Rect2(x, y, 38, 44)
			buttons.append({"rect": rr, "id": "crole_" + r})
			var on: bool = codex_role == r
			rrect(rr, Color("2e2616") if on else UI["deep"])
			rline(rr, UI["gold"] if on else Color(GRADE_COL[g].r, GRADE_COL[g].g, GRADE_COL[g].b, 0.5))
			draw_ally_shape(Vector2(rr.get_center().x, rr.position.y + 26), r, "water", "normal", 1.0)
			x += 40.0
		y += 54.0


func _draw_codex_unit(r: String) -> void:
	var g: String = PD.ROLE_GRADE[r]
	var gc: Color = GRADE_COL[g]
	var pr := Rect2(216, 52, 418, 340)
	panel(pr)
	var st: Dictionary = PD.ROLE_STATS[r]
	var f: String = PD.faction_of(r)
	# 머리: 큰 그림 + 이름·등급·진영·설명·기본 능력치, 오른쪽에 세 유약
	glow(self, Vector2(256, 104), 34.0, Color(gc.r, gc.g, gc.b, 0.14))
	draw_ally_shape(Vector2(256, 108), r, "water", "normal", 2.5)
	text(Vector2(296, 80), PD.ROLE_NAME_KILN[r], gc, 24)
	text(Vector2(296, 96), "%s · %s 진영 · 뽑힐 확률 %.2f%%" % [PD.GRADE_NAME[g], PD.FACTIONS[f]["name"], PD.GRADE_ODDS[g] * 100.0 / PD.grade_roles(g).size()], UI["muted"])
	text(Vector2(296, 111), fit(PD.ROLE_DESC[r], 220.0), C["text"])
	text(Vector2(296, 126), "♥ %d · 공격 %d · 사거리 %d · 공속 %.1f/초" % [roundi(st["hp"]), roundi(st["atk"]), roundi(st["range"]), 60.0 / st["cd"]], C["text"])
	for i in 3:
		var e: String = PD.ELEMENTS[i]
		draw_ally_shape(Vector2(540 + i * 30, 96), r, e, "normal", 1.0)
		text(Vector2(526 + i * 30, 126), PD.GLAZE_NAME[e], C[e].lightened(0.3), 12, 28.0, HORIZONTAL_ALIGNMENT_CENTER)
	# 별 (합치기): 같은 병사 3명 → 별 +1. 겉모습·능력치·스킬이 어떻게 바뀌나
	var y := 140.0
	draw_rect(Rect2(222, y, 406, 1), UI["line"])
	text(Vector2(226, y + 15), "합치기 — 같은 병사 · 같은 별 3명 → 별 +1", UI["gold"])
	for i in 5:
		var star: int = i + 1
		var cx: float = 262.0 + i * 82.0
		draw_ally_shape(Vector2(cx, y + 50), r, "water", "normal", 1.5, false, star)
		_draw_stars(Vector2(cx, y + 74), star)
		var mul: float = PD.STAR_MUL[star]
		text(Vector2(cx - 40, y + 90), "♥%d 공%d" % [roundi(st["hp"] * mul), roundi(st["atk"] * mul)], C["text"], 12, 80.0, HORIZONTAL_ALIGNMENT_CENTER)
		var lv: int = PD.skill_level(star)
		text(Vector2(cx - 40, y + 104), "스킬 기본" if lv == 0 else "스킬 ×%.1f" % (1.0 + 0.5 * lv), C["good"] if lv > 0 else UI["muted"], 12, 80.0, HORIZONTAL_ALIGNMENT_CENTER)
		if i < 4:
			text(Vector2(cx + 34, y + 54), "›", UI["muted"])
	# 전직: ★3 + 같은 진영 다른 병사 1명 → 칭호 깃발 · 능력치 +20% · 스킬 하나 더
	y = 254.0
	draw_rect(Rect2(222, y, 406, 1), UI["line"])
	text(Vector2(226, y + 15), "전직 — ★%d 이상 + 같은 진영 다른 병사 1명" % PD.PROMO_STAR, UI["gold"])
	var mates: Array = PD.FACTIONS[f]["roles"].filter(func(z): return z != r)
	var ing: String = mates[0] if not mates.is_empty() else r
	draw_ally_shape(Vector2(250, y + 62), r, "water", "normal", 1.5, false, 3)
	text(Vector2(230, y + 86), "전직 전", UI["muted"], 12, 40.0, HORIZONTAL_ALIGNMENT_CENTER)
	text(Vector2(272, y + 58), "+", UI["muted"])
	draw_ally_shape(Vector2(298, y + 62), ing, "water", "normal", 1.2)
	text(Vector2(278, y + 86), "재료", UI["muted"], 12, 40.0, HORIZONTAL_ALIGNMENT_CENTER)
	text(Vector2(318, y + 58), "→", UI["gold"])
	glow(self, Vector2(352, y + 56), 22.0, Color(1.0, 0.8, 0.35, 0.18))
	draw_ally_shape(Vector2(352, y + 62), r, "water", "normal", 1.5, false, 3, true)
	text(Vector2(332, y + 86), "전직 후", UI["gold"], 12, 40.0, HORIZONTAL_ALIGNMENT_CENTER)
	var m3: float = PD.STAR_MUL[3]
	var x := 384.0
	text(Vector2(x, y + 34), fit("%s %s %s" % [PD.GLAZE_NAME["water"], PD.PROMO_ADJ[ing], PD.ROLE_NAME_KILN[r]], 240.0), C["accent"])
	text(Vector2(x, y + 49), "♥ %d → %d · 공격 %d → %d" % [roundi(st["hp"] * m3), roundi(st["hp"] * m3 * (1.0 + PD.PROMO_BONUS)), roundi(st["atk"] * m3), roundi(st["atk"] * m3 * (1.0 + PD.PROMO_BONUS))], C["text"])
	text(Vector2(x, y + 64), fit("스킬: %s + %s" % [PD.skill_name(r, "water"), PD.skill_name(ing, "water")], 240.0), C["good"])
	text(Vector2(x, y + 79), fit("재료가 될 수 있는 병사: " + " · ".join(mates.map(func(z): return PD.ROLE_NAME_KILN[z])), 240.0), UI["muted"])
	# 합동 기술
	var combos: Array = PD.COMBOS.keys().filter(func(k): return PD.combo_roles(k).has(r))
	text(Vector2(226, 384), fit("들어가는 합동 기술: " + (", ".join(combos.map(func(k): return PD.COMBOS[k]["name"])) if not combos.is_empty() else "없음"), 400.0), C["text"])


func _draw_codex_skill(r: String) -> void:
	var pr := Rect2(216, 52, 418, 340)
	panel(pr)
	text(Vector2(226, 74), "%s 스킬 · 재사용 %.0f초" % [PD.ROLE_NAME_KILN[r], PD.SKILLS[r]["cd"] / float(PD.FPS)], GRADE_COL[PD.ROLE_GRADE[r]])
	var y := 82.0
	for e in PD.ELEMENTS:
		var h: float = skill_box_height(r, e, 0, 404.0) - 3.0 * 13.0
		var info: Dictionary = PD.skill_info(r, e, 0)
		var box := Rect2(224, y, 404, h - 4)
		buttons.append({"rect": box, "id": "pv_skill_" + e})
		var hovb: bool = box.has_point(get_local_mouse_position())
		rrect(box, Color("1a1420").lightened(0.05 if hovb else 0.0))
		rline(box, C[e])
		text(box.position + Vector2(0, 15), "▶ 영상 보기", UI["gold"] if hovb else UI["muted"], 12, box.size.x - 8.0, HORIZONTAL_ALIGNMENT_RIGHT)
		var fxt := tex("fx/skill_" + r)
		var ib := Rect2(box.position + Vector2(5, 5), Vector2(30, 30))
		rrect(ib, Color("0d0a10"))
		if fxt != null:
			var n: int = maxi(1, int(fxt.get_width() / fxt.get_height()))
			var fh: float = fxt.get_height()
			draw_texture_rect_region(fxt, ib.grow(-1), Rect2(clampi(int(n * 0.45), 0, n - 1) * fh, 0, fh, fh), C[e].lightened(0.3))
		text(box.position + Vector2(41, 15), PD.GLAZE_NAME[e], C[e].lightened(0.3))
		text(box.position + Vector2(41, 30), info["name"], C["accent"])
		var yy: float = box.position.y + 51.0
		for ln in wrap_lines(info["desc"], 390.0):
			text(Vector2(box.position.x + 6, yy), ln, C["text"])
			yy += 13.0
		for ln in wrap_lines(info["elem"], 390.0):
			text(Vector2(box.position.x + 6, yy), ln, C[e].lightened(0.35))
			yy += 13.0
		y += h + 2.0
	y += 4.0
	text(Vector2(226, y), "★3 · ★4 · ★5 에서 세진다", UI["gold"])
	for i in 3:
		y += 14.0
		text(Vector2(232, y), fit("★%d  %s" % [i + 3, PD.skill_info_short(r, i + 1)], 390.0), C["good"])


func _draw_codex_combos() -> void:
	text(Vector2(14, 64), fit("필요한 병사가 부대에 모두 있으면 쓸 수 있다 · 로비에서 하나만 고른다 · %d초 뒤 첫 발동, 그 뒤 %d초마다" % [PD.SYNERGY_FIRST / PD.FPS, PD.SYNERGY_EVERY / PD.FPS], 612.0), UI["muted"])
	var i := 0
	for id in PD.COMBOS:
		var c: Dictionary = PD.COMBOS[id]
		var r := Rect2(6 + (i % 2) * 316, 74 + (i / 2) * 78, 310, 72)
		var col: Color = C[c["element"]].lightened(0.3)
		buttons.append({"rect": r, "id": "pv_combo_" + id})
		var hovc: bool = r.has_point(get_local_mouse_position())
		rrect(r, UI["lacquer"].lightened(0.05 if hovc else 0.0))
		rline(r, col)
		draw_combo_icon(id, r.position + Vector2(r.size.x - 34, 26), 26.0)
		text(r.position + Vector2(r.size.x - 70, 66), "▶ 영상", UI["gold"] if hovc else UI["muted"], 12, 60.0, HORIZONTAL_ALIGNMENT_RIGHT)
		text(r.position + Vector2(10, 18), c["name"], col)
		text(r.position + Vector2(10, 18), "공격력 합 × %d%%" % roundi(c["pct"] * 100.0), C["accent"], 12, r.size.x - 50.0, HORIZONTAL_ALIGNMENT_RIGHT)
		text(r.position + Vector2(10, 36), fit("필요: " + PD.combo_need_text(id), r.size.x - 50.0), C["text"])
		text(r.position + Vector2(10, 52), fit(PD.combo_dmg_text(id), r.size.x - 50.0), C["accent"].lerp(C["text"], 0.4))
		text(r.position + Vector2(10, 66), fit(c["desc"], r.size.x - 80.0), UI["muted"])
		i += 1


func _draw_codex_rules() -> void:
	var l := Rect2(6, 52, 310, 340)
	var rp := Rect2(324, 52, 310, 340)
	panel(l, "합치기 (별 올리기)")
	var lines := [
		["같은 병사 · 같은 별 3명 → 별 +1 (확정)", C["text"]],
		["★1 → ★2 → ★3 → ★4 → ★5, 단계마다 3명씩", C["text"]],
		["유약(색)은 달라도 된다 → 가장 좋은 품질의 유약", UI["muted"]],
		["요변은 요변끼리만 합친다", C["accent"]],
		["부대·대기실 병사를 모두 센다", UI["muted"]],
		["끼고 있던 장비는 가방으로 돌아온다", UI["muted"]],
		["별이 오르면 힘 ×1 · ×1.6 · ×2.5 · ×3.8 · ×5.6", C["text"]],
		["★3부터 스킬이 세진다 (★3 · ★4 · ★5)", C["good"]],
		["", C["text"]],
		["로비 아래 '합치기 N' 이 밝으면 합칠 수 있다", UI["gold"]],
		["대기실의 '같은 병사 3명 모두 합치기' 로 한 번에", UI["gold"]],
	]
	var y: float = l.position.y + 26.0
	for ln in lines:
		text(Vector2(l.position.x + 12, y), fit(ln[0], 290.0), ln[1])
		y += 17.0
	panel(rp, "전직 (스킬 하나 더)")
	var lines2 := [
		["★%d 이상 병사 + 같은 진영의 다른 병사 1명" % PD.PROMO_STAR, C["text"]],
		["→ 재료 병사는 사라지고, 그 스킬을 하나 더 얻는다", C["text"]],
		["체력·공격력 +%d%%, 이름에 칭호가 붙는다" % roundi(PD.PROMO_BONUS * 100.0), C["text"]],
		["한 병사는 한 번만 전직한다", UI["muted"]],
		["재료의 장비는 가방으로 돌아온다", UI["muted"]],
		["", C["text"]],
		["진영 (같은 진영끼리 전직 재료가 된다)", UI["gold"]],
	]
	y = rp.position.y + 26.0
	for ln in lines2:
		text(Vector2(rp.position.x + 12, y), fit(ln[0], 290.0), ln[1])
		y += 17.0
	for f in PD.FACTIONS:
		text(Vector2(rp.position.x + 12, y), PD.FACTIONS[f]["name"], UI["gold"])
		text(Vector2(rp.position.x + 62, y), fit(" · ".join(PD.FACTIONS[f]["roles"].map(func(z): return PD.ROLE_NAME_KILN[z])), 236.0), C["text"])
		y += 16.0
	y += 4.0
	text(Vector2(rp.position.x + 12, y), fit("로비 아래 '전직 N' 이 밝거나 병사 카드에 ↑ 가 보이면 전직할 수 있다", 290.0), UI["gold"])



# ---------------- 스킬·합동 기술 영상 ----------------
## 합동 기술 아이콘: 유약 빛 원 + 조합 병사 둘 (2026-11-28 "합동 기술 아이콘")
func draw_combo_icon(id: String, p: Vector2, sz: float) -> void:
	var c: Dictionary = PD.COMBOS[id]
	var col: Color = C[c["element"]]
	var r := Rect2(p, Vector2(sz, sz))
	rrect(r, Color("0d0a10"))
	glow(self, r.get_center(), sz * 0.7, Color(col.r, col.g, col.b, 0.45))
	var roles: Array = PD.combo_roles(id)
	var k: float = sz / 32.0
	draw_ally_shape(r.get_center() + Vector2(-5, 2) * k * 1.4, roles[0], c["element"], "normal", 0.65 * k * 1.4)
	if roles.size() > 1:
		draw_ally_shape(r.get_center() + Vector2(5, 3) * k * 1.4, roles[1], c["element"], "normal", 0.65 * k * 1.4)
	rline(r, col)


## 영상 시작: 실제 전투 규칙으로 작은 판을 만들어 되풀이한다 (그림·효과·컷신이 실제 게임과 같다)
func _preview_start(kind: String, role: String, element: String, combo: String) -> void:
	var Battle = load("res://src/proto/battle.gd")
	var b = Battle.new(77, [])
	b.spawn_queue = []
	b.no_rout = true
	b.village_hp = 99999.0
	if kind == "skill":
		var u = b.add_ally(role, element, "normal", PD.skill_name(role, element), PD.STAR_MUL[3], {"star": 3}, Vector2(230, 130))
		u.max_hp = 1000000.0
		u.hp = u.max_hp
		if PD.SKILLS[role]["kind"] == "support":
			for i in 3:
				var a = b.add_ally("spear", "water", "normal", "창병", 1.0, {}, Vector2(270, 90 + i * 40))
				a.max_hp = 1000000.0
				a.hp = a.max_hp * 0.4
	else:
		b.combo_id = combo
		var roles: Array = PD.COMBOS[combo]["needs"].duplicate()
		if PD.COMBOS[combo].has("any"):
			roles += PD.COMBOS[combo]["any"][0].slice(0, PD.COMBOS[combo]["any"][1])
		for i in roles.size():
			var a2 = b.add_ally(roles[i], PD.COMBOS[combo]["element"], "normal", roles[i], PD.STAR_MUL[3], {"star": 3}, Vector2(200 + (i % 2) * 40, 70 + i * 40))
			a2.max_hp = 1000000.0
			a2.hp = a2.max_hp
	_preview_enemies(b)
	preview = {"kind": kind, "role": role, "element": element, "combo": combo, "t": 0, "back": battle}
	battle = b
	cutin = {}
	floats.clear()
	banner = {}


func _preview_enemies(b) -> void:
	for t2 in b.units:
		if t2.team == "enemy":
			t2.alive = false
	for i in 8:
		var e = b.add_enemy("goblin" if i % 3 else "brute", 130.0)
		e.max_hp = 100000.0
		e.hp = e.max_hp
		e.speed = 0.0
		e.atk = 0.0
		e.pos = Vector2(330 + (i % 4) * 34, 70 + (i / 4) * 70 + (i % 2) * 14)


func pv_close_now() -> void:
	if preview.is_empty():
		return
	battle = preview["back"]
	preview = {}
	cutin = {}
	floats.clear()
	banner = {}


func _preview_tick() -> void:
	preview["t"] += 1
	if clicked("pv_close") or pressed(KEY_ESCAPE) or clicked("pv_back"):
		pv_close_now()
		return
	var pt: int = preview["t"]
	# 3초마다 스킬을 쓰게 하고, 적은 제자리로 (맞아도 쓰러지지 않는다)
	for u in battle.units:
		if u.team == "enemy" and u.alive and u.hp < u.max_hp * 0.3:
			u.hp = u.max_hp
		if u.team == "ally" and preview["kind"] == "skill" and pt % 180 == 20 and u.kind == preview["role"]:
			for i in u.skill_t.size():
				u.skill_t[i] = 0
	if preview["kind"] == "combo" and pt % 300 == 20:
		battle.synergy_t[preview["combo"]] = 1
	if battle._count("enemy") < 4:
		_preview_enemies(battle)
	battle.done = false
	step_battle()


func _draw_preview() -> void:
	draw_battle()   # 설명 띠는 맨 위 층(draw_top_ui)에서 — 안개·빛 층에 가리지 않게
	_draw_preview_buttons()


## 영상 설명 띠: 맨 위 층에 그린다 (ci 에 직접)
func draw_top_ui(ci: CanvasItem) -> void:
	if preview.is_empty() or (state != "codex" and state != "combo"):
		return
	var bars := [Rect2(6, 4, 628, 52), Rect2(6, 330, 628, 64)]
	for br in bars:
		rrect(Rect2(br.position + Vector2(0, 3), br.size), Color(0, 0, 0, 0.45), ci)
		if not nine("panel_9", br, 8, Color.WHITE, ci):
			rrect(br, UI["lacquer"], ci)
	var lines: Array = []   # [pos, 글, 색, 크기]
	if preview["kind"] == "skill":
		var r: String = preview["role"]
		var e: String = preview["element"]
		var info: Dictionary = PD.skill_info(r, e, 1)
		lines = [[Vector2(96, 26), "%s %s · ★3" % [PD.GLAZE_NAME[e], PD.ROLE_NAME_KILN[r]], C[e].lightened(0.3), 12],
			[Vector2(96, 46), info["name"], C["accent"], 20],
			[Vector2(16, 350), fit(info["desc"], 530.0), C["text"], 12],
			[Vector2(16, 366), fit(info["elem"], 530.0), C[e].lightened(0.35), 12],
			[Vector2(16, 382), "3초마다 되풀이 · 재사용 %.0f초 (실제 전투 규칙)" % (info["cd"] / float(PD.FPS)), UI["muted"], 12]]
	else:
		var id: String = preview["combo"]
		var c: Dictionary = PD.COMBOS[id]
		var ic := Rect2(96, 14, 34, 34)
		rrect(ic, Color("0d0a10"), ci)
		glow(ci, ic.get_center(), 24.0, Color(C[c["element"]].r, C[c["element"]].g, C[c["element"]].b, 0.5))
		lines = [[Vector2(138, 30), c["name"], C[c["element"]].lightened(0.3), 20],
			[Vector2(138, 48), fit("필요: " + PD.combo_need_text(id), 480.0), UI["muted"], 12],
			[Vector2(16, 350), fit(PD.combo_dmg_text(id), 530.0), C["accent"], 12],
			[Vector2(16, 366), fit(c["desc"], 530.0), C["text"], 12],
			[Vector2(16, 382), "5초마다 되풀이 (★3 병사들로)", UI["muted"], 12]]
	for ln in lines:
		var f: Font = font_head if ln[3] >= 20 else font
		ci.draw_string(f, ln[0].round(), ln[1], HORIZONTAL_ALIGNMENT_LEFT, -1, ln[3], ln[2])
	# 버튼 모양 (누르기는 아래 기본층 버튼이 받는다)
	for bt in [[Rect2(14, 16, 70, 24), "‹ 돌아가기"], [Rect2(560, 362, 66, 24), "닫기"]]:
		rrect(bt[0], UI["gold"], ci)
		var w: float = font_bold.get_string_size(bt[1], HORIZONTAL_ALIGNMENT_LEFT, -1, 12).x
		ci.draw_string(font_bold, (bt[0].position + Vector2((bt[0].size.x - w) / 2.0, 17)).round(), bt[1], HORIZONTAL_ALIGNMENT_LEFT, -1, 12, UI["lacquer"])


func _draw_preview_buttons() -> void:
	buttons.append({"rect": Rect2(14, 16, 70, 24), "id": "pv_back"})
	buttons.append({"rect": Rect2(560, 362, 66, 24), "id": "pv_close"})



# ---------------- 전술 뽑기 · 원군 (전투가 멈춘 동안) ----------------
const RARE_COL := {"common": Color("cfc6b4"), "rare": Color("6fa8ff"), "hero": Color("c58bff")}


func _pending_input() -> void:
	cutin = {}
	floats.clear()
	if battle.pending == "draft":
		if run.draft_offer.is_empty():
			run.roll_draft()
			draft_shown_t = t
			sfx("draft")
		if clicked("tc_reroll"):
			if not run.reroll_draft():
				float_text(Vector2(300, 330), "진주 부족", C["danger"])
			else:
				draft_shown_t = t
				sfx("draft")
			return
		for i in run.draft_offer.size():
			if clicked("tc%d" % i) or pressed(KEY_1 + i):
				var id: String = run.draft_offer[i]
				run.pick_tactic(id, battle)
				sfx("card_pick")
				show_banner("전술: %s" % PD.TACTICS[id]["name"], PD.TACTICS[id]["desc"], RARE_COL[PD.TACTICS[id]["rare"]], 80)
				do_flash(RARE_COL[PD.TACTICS[id]["rare"]], 10)
				return
	elif battle.pending == "reinforce":
		for sd in run.reserve:
			if clicked("rf_%d" % sd["id"]):
				if rf_pick.has(sd["id"]):
					rf_pick.erase(sd["id"])
				elif rf_pick.size() < run.reinforce_max():
					rf_pick.append(sd["id"])
				else:
					float_text(Vector2(300, 270), "흙이 모자라요" if rf_pick.size() < PD.REINFORCE_COUNT else "최대 %d명" % PD.REINFORCE_COUNT, C["danger"])
				return
		if clicked("rf_auto"):
			rf_pick = run.best_reserve(run.reinforce_max())
			return
		if clicked("rf_no"):
			rf_pick = []
			run.decline_reinforce(battle)
			return
		if clicked("rf_go") and not rf_pick.is_empty():
			var got: Array = run.reinforce(battle, rf_pick)
			for g in got:
				unit_sid[g[0].id] = g[1]
			rf_pick = []
			sfx("reinforce")
			show_banner("원군 도착!", "대기실 병사 %d명이 마을 앞에 섰다" % got.size(), UI["gold"], 90)
			shake = maxf(shake, 6.0)


## 전술 뽑기 (2026-11-28 새 디자인): 가운데 불빛 · 리본 제목 · 세로로 긴 카드 3장이 차례로 솟아오른다
## 카드: 등급 색 겹테두리 · 모서리 장식 · 등급 리본 · 둥근 메달 아이콘 · 이름 · 효과 · 숫자 키
## 마우스를 올리면 살짝 떠오르고 빛줄기가 스친다. 영웅 카드는 테두리가 반짝인다
const DRAFT_CARD := Vector2(150, 206)

func _draw_draft() -> void:
	var dt: int = t - draft_shown_t
	# 뒷배경: 어둡게 + 가운데 따뜻한 불빛 (둥근 층)
	draw_rect(Rect2(Vector2.ZERO, VIEW), Color(0.02, 0.01, 0.04, 0.72))
	for i in 6:
		draw_circle(Vector2(320, 210), 250.0 - i * 36.0, Color(1.0, 0.62, 0.25, 0.025))
	# 떠오르는 불티
	for i in 22:
		var ph: float = fmod(t * 0.004 + i * 0.137, 1.0)
		var fp := Vector2(40.0 + fmod(i * 173.0, 560.0) + sin(t * 0.02 + i) * 8.0, 380.0 - ph * 340.0)
		draw_circle(fp, 1.2 + (i % 3) * 0.5, Color(1.0, 0.75, 0.35, 0.55 * sin(ph * PI)))
	var boss: bool = battle.boss_stage
	# 제목 리본
	var rib := Rect2(196, 40, 248, 38)
	var rp := PackedVector2Array([rib.position + Vector2(-18, 4), rib.position, rib.end - Vector2(0, rib.size.y), rib.end + Vector2(18, -rib.size.y + 4),
		rib.end + Vector2(6, -rib.size.y / 2.0), rib.end + Vector2(18, -4), rib.end, Vector2(rib.position.x, rib.end.y), Vector2(rib.position.x - 18, rib.end.y - 4), Vector2(rib.position.x - 6, rib.position.y + rib.size.y / 2.0)])
	draw_colored_polygon(rp, Color("3a1418"))
	draw_polyline(rp + PackedVector2Array([rp[0]]), UI["gold_dk"], 1.5)
	draw_rect(Rect2(rib.position + Vector2(4, 4), rib.size - Vector2(8, 8)), Color("5a1c22"))
	draw_rect(Rect2(rib.position + Vector2(4, 4), Vector2(rib.size.x - 8, 2)), Color(1, 0.8, 0.5, 0.25))
	var tw: float = font_head.get_string_size("전술 뽑기", HORIZONTAL_ALIGNMENT_LEFT, -1, 26).x
	for oo in [Vector2(0, 2)]:
		draw_string(font_head, Vector2(320 - tw / 2.0, 69) + oo, "전술 뽑기", HORIZONTAL_ALIGNMENT_LEFT, -1, 26, Color(0, 0, 0, 0.6))
	draw_string(font_head, Vector2(320 - tw / 2.0, 69), "전술 뽑기", HORIZONTAL_ALIGNMENT_LEFT, -1, 26, UI["gold"])
	for sx in [-1.0, 1.0]:
		var dp := Vector2(320 + sx * (tw / 2.0 + 16), 60)
		draw_colored_polygon(PackedVector2Array([dp + Vector2(0, -5), dp + Vector2(5, 0), dp + Vector2(0, 5), dp + Vector2(-5, 0)]), UI["gold"])
	var sub: String = "보스 체력이 절반 아래로!  하나를 고르세요" if boss else "도깨비 %d마리를 물리쳤다!  하나를 고르세요" % (battle.draft_next - PD.DRAFT_KILLS)
	text(Vector2(0, 98), sub, Color("f2e8d6"), 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	text(Vector2(0, 113), "이번 밤에만 효과가 있습니다", UI["muted"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	# 카드
	var offer: Array = run.draft_offer
	var mouse := get_local_mouse_position()
	for i in offer.size():
		var c: Dictionary = PD.TACTICS[offer[i]]
		var rc: Color = RARE_COL[c["rare"]]
		var gap := 168.0
		var base := Rect2(Vector2(320 - (offer.size() - 1) * gap / 2.0 - DRAFT_CARD.x / 2.0 + i * gap, 126), DRAFT_CARD)
		# 차례로 솟아오르기 (한 장에 12프레임씩 늦게)
		var k: float = clampf((dt - i * 8) / 18.0, 0.0, 1.0)
		var ek: float = 1.0 - pow(1.0 - k, 3.0)
		if k <= 0.0:
			continue
		var hov: bool = base.has_point(mouse) and k >= 1.0
		var lift: float = (1.0 - ek) * 40.0 - (6.0 if hov else 0.0)
		var r := Rect2(base.position + Vector2(0, lift), base.size)
		buttons.append({"rect": base, "id": "tc%d" % i})
		var al: float = ek
		# 그림자 · 뒤 빛
		rrect(Rect2(r.position + Vector2(3, 6), r.size), Color(0, 0, 0, 0.45 * al))
		if hov or c["rare"] == "hero":
			for g in 3:
				rrect(r.grow(3 + g * 3), Color(rc.r, rc.g, rc.b, (0.10 if hov else 0.06) * al))
		# 카드 바탕: 위는 짙은 밤색, 아래로 갈수록 등급 빛
		var top := Color("1b1524")
		var bot: Color = top.lerp(rc, 0.28)
		draw_polygon(PackedVector2Array([r.position, Vector2(r.end.x, r.position.y), r.end, Vector2(r.position.x, r.end.y)]),
			PackedColorArray([top, top, bot, bot]))
		# 겹테두리: 바깥 등급 색 · 안쪽 금빛 가는 선
		var bc: Color = rc
		if c["rare"] == "hero":
			bc = rc.lerp(Color.WHITE, 0.3 + 0.3 * sin(t * 0.15))
		draw_rect(r, Color(bc.r, bc.g, bc.b, al), false, 2.0)
		draw_rect(r.grow(-5), Color(UI["gold_dk"].r, UI["gold_dk"].g, UI["gold_dk"].b, 0.8 * al), false, 1.0)
		# 모서리 장식 (ㄱ자 금빛)
		for cx in [0, 1]:
			for cy in [0, 1]:
				var cp := Vector2(r.position.x + 5 + cx * (r.size.x - 10), r.position.y + 5 + cy * (r.size.y - 10))
				var sx2: float = 1.0 if cx == 0 else -1.0
				var sy2: float = 1.0 if cy == 0 else -1.0
				draw_line(cp, cp + Vector2(10 * sx2, 0), UI["gold"], 2.0)
				draw_line(cp, cp + Vector2(0, 10 * sy2), UI["gold"], 2.0)
				draw_circle(cp + Vector2(3 * sx2, 3 * sy2), 1.5, UI["gold"])
		# 등급 리본 (위)
		var rn: String = PD.TACTIC_RARE_NAME[c["rare"]]
		var rbr := Rect2(r.get_center().x - 30, r.position.y - 7, 60, 16)
		draw_colored_polygon(PackedVector2Array([rbr.position, Vector2(rbr.end.x, rbr.position.y), Vector2(rbr.end.x - 5, rbr.end.y), Vector2(rbr.position.x + 5, rbr.end.y)]), rc.darkened(0.45))
		draw_rect(rbr, rc, false, 1.0)
		text(Vector2(rbr.position.x, rbr.position.y + 12), rn, rc.lightened(0.5), 12, rbr.size.x, HORIZONTAL_ALIGNMENT_CENTER)
		# 메달 아이콘
		var mc := Vector2(r.get_center().x, r.position.y + 60)
		for g2 in 4:
			draw_circle(mc, 36.0 - g2 * 4.0, Color(rc.r, rc.g, rc.b, 0.07))
		draw_circle(mc, 26.0, Color("0d0a10"))
		draw_arc(mc, 26.0, 0.0, TAU, 40, rc, 2.0)
		draw_arc(mc, 22.0, 0.0, TAU, 40, Color(UI["gold_dk"].r, UI["gold_dk"].g, UI["gold_dk"].b, 0.8), 1.0)
		for sp in 8:   # 메달 둘레 점
			var an: float = sp * TAU / 8.0 + t * 0.01
			draw_circle(mc + Vector2(cos(an), sin(an)) * 30.0, 1.2, rc.lightened(0.3))
		draw_icon(c["icon"], mc - Vector2(12, 12), 3.0)
		# 이름
		var nm: String = c["name"]
		var nw: float = font_head.get_string_size(nm, HORIZONTAL_ALIGNMENT_LEFT, -1, 20).x
		draw_string(font_head, Vector2(r.get_center().x - nw / 2.0, r.position.y + 118).round() + Vector2(0, 1), nm, HORIZONTAL_ALIGNMENT_LEFT, -1, 20, Color(0, 0, 0, 0.6))
		draw_string(font_head, Vector2(r.get_center().x - nw / 2.0, r.position.y + 118).round(), nm, HORIZONTAL_ALIGNMENT_LEFT, -1, 20, Color("fff4dc"))
		# 구분선 + 마름모
		var ly: float = r.position.y + 128
		draw_line(Vector2(r.position.x + 18, ly), Vector2(r.end.x - 18, ly), Color(rc.r, rc.g, rc.b, 0.6), 1.0)
		var dm := Vector2(r.get_center().x, ly)
		draw_colored_polygon(PackedVector2Array([dm + Vector2(0, -3), dm + Vector2(3, 0), dm + Vector2(0, 3), dm + Vector2(-3, 0)]), rc)
		# 효과
		var y: float = r.position.y + 146.0
		for ln in wrap_lines(c["desc"], r.size.x - 24.0):
			text(Vector2(r.position.x, y), ln, Color("ece4d4"), 12, r.size.x, HORIZONTAL_ALIGNMENT_CENTER)
			y += 15.0
		# 숫자 키
		var kc := Vector2(r.get_center().x, r.end.y - 14)
		draw_circle(kc, 8.0, Color(0, 0, 0, 0.5))
		draw_arc(kc, 8.0, 0.0, TAU, 20, rc, 1.0)
		text(Vector2(kc.x - 8, kc.y + 4.5), str(i + 1), Color.WHITE, 12, 16.0, HORIZONTAL_ALIGNMENT_CENTER)
		# 빛줄기 (올렸을 때 스친다)
		if hov:
			var sh: float = fmod(t * 0.03, 1.6) - 0.3
			var x0: float = r.position.x + sh * r.size.x
			var pts := PackedVector2Array()
			for pp in [Vector2(x0, r.position.y), Vector2(x0 + 18, r.position.y), Vector2(x0 - 22, r.end.y), Vector2(x0 - 40, r.end.y)]:
				pts.append(Vector2(clampf(pp.x, r.position.x, r.end.x), pp.y))
			draw_colored_polygon(pts, Color(1, 1, 1, 0.07))
	# 다시 뽑기
	var rb := Rect2(238, 346, 164, 28)
	var can: bool = run.pearls >= PD.DRAFT_REROLL
	button(rb, "", "tc_reroll", Color("dfe6ee"), can)
	draw_string(font_bold, (rb.position + Vector2(14, 18)).round(), "다시 뽑기", HORIZONTAL_ALIGNMENT_LEFT, -1, 12, _readable_on(Color(0.75, 0.78, 0.82) if can else Color(0.2, 0.19, 0.22), Color(0, 0, 0, 0), 4.5))
	draw_icon("pearl", rb.position + Vector2(96, 7), 1.0)
	text(rb.position + Vector2(114, 18), "%d" % PD.DRAFT_REROLL, Color("1a1d22") if can else C["danger"])
	text(Vector2(410, 364), "가진 진주 %d" % run.pearls, UI["muted"])
	if not run.tactics.is_empty():
		text(Vector2(0, 392), fit("이번 밤 고른 전술: " + ", ".join(run.tactics.map(func(z): return PD.TACTICS[z]["name"])), 600.0), UI["muted"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)


## 원군: 대기실 병사 중 3명을 골라 마을 앞으로 (챕터 3부터, 한 밤에 한 번)
func _draw_reinforce() -> void:
	draw_rect(Rect2(Vector2.ZERO, VIEW), Color(0.08, 0, 0, 0.66))
	var pk: float = 1.0 + 0.04 * sin(t * 0.2)
	draw_set_transform(Vector2(320, 70), 0.0, Vector2(pk, pk))
	text(Vector2(-320, 0), "돌발! 원군이 왔다", C["danger"].lightened(0.2), 36, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	draw_set_transform(Vector2.ZERO)
	text(Vector2(0, 92), "병사가 모두 쓰러졌다 — 대기실 병사를 최대 %d명 불러 마을 앞으로 (1명당 흙 %d · 한 밤에 한 번)" % [PD.REINFORCE_COUNT, PD.REINFORCE_CLAY], C["text"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	hover_sid = -1
	var list: Array = run.best_reserve(30).map(func(id): return run.soldier(id))   # 센 병사부터
	for i in mini(list.size(), 30):
		var sd: Dictionary = list[i]
		var r := Rect2(320 - 5 * 40 + (i % 10) * 40, 106 + (i / 10) * 50, MINI.x, MINI.y)
		_draw_mini(r, sd, rf_pick.has(sd["id"]), "rf_%d" % sd["id"])
	var mx: int = run.reinforce_max()
	text(Vector2(0, 274), "고른 병사 %d / %d   ·   흙 %d 필요 (가진 흙 %d)" % [rf_pick.size(), mx, rf_pick.size() * PD.REINFORCE_CLAY, run.clay], UI["gold"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	button(Rect2(110, 288, 130, 30), "추천 %d명" % mx, "rf_auto", UI["gold"])
	button(Rect2(255, 288, 130, 30), "출전!  (흙 %d)" % (rf_pick.size() * PD.REINFORCE_CLAY), "rf_go", C["danger"].lightened(0.2), not rf_pick.is_empty(), true)
	button(Rect2(400, 288, 130, 30), "부르지 않기", "rf_no", C["dim"])
	text(Vector2(0, 334), "부르지 않으면 도깨비가 마을을 약탈하고 물러갑니다", UI["muted"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	if hover_sid >= 0:
		var hs: Dictionary = run.soldier(hover_sid)
		if not hs.is_empty():
			draw_unit_tip(hs, get_local_mouse_position() + Vector2(14, -40))
