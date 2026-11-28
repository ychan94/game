extends RefCounted
## 전술 강화 (판이 끝나도 남는 영구 강화) + 시간 기록. 화면과 무관하게 돌아간다.
## 불씨: 아침·밤을 ★3 으로 넘길 때마다 1개. 나무의 칸을 사면 다음 판부터 적용.
## 저장: user://meta.cfg (테스트는 path 를 바꿔 쓴다)

const SAVE := "user://meta.cfg"

## 가지: core 코어 · supply 보급 · unit 병사 · shop 상점 · kiln 가마
## key: 효과 이름, per: 단계마다 더하는 값, max: 최대 단계, cost: 단계별 값, need: 먼저 1단계 이상 있어야 하는 칸
## 불씨는 아침·밤을 ★3(마을 90% 이상)으로 넘길 때마다 1개 (2026-11-28 사용자) → 한 판 최대 25개라 값은 1~6
const NODES := {
	"core": {"name": "가마터", "branch": "core", "desc": "전술 강화의 뿌리", "key": "", "per": 0.0, "max": 1, "cost": [0], "need": ""},
	# 마을
	"wall": {"name": "마을 성벽", "branch": "core", "desc": "도깨비가 마을에 주는 피해 -10%", "key": "village_guard", "per": 0.1, "max": 3, "cost": [1, 2, 4], "need": "core"},
	"repair": {"name": "마을 수리", "branch": "core", "desc": "밤을 넘길 때마다 마을 체력 +5%", "key": "night_repair", "per": 0.05, "max": 2, "cost": [2, 4], "need": "wall"},
	"beacon": {"name": "봉화", "branch": "core", "desc": "도깨비 대장에게 주는 피해 +15%", "key": "boss_dmg", "per": 0.15, "max": 2, "cost": [3, 5], "need": "repair"},
	# 부대 (2026-11-28 "부대원 수도 늘려주는 것")
	"command": {"name": "지휘 한도", "branch": "army", "desc": "부대 자리 +1", "key": "cap", "per": 1.0, "max": 3, "cost": [2, 4, 6], "need": "core"},
	"recruit": {"name": "신병 모집", "branch": "army", "desc": "판을 시작할 때 일반 병사 +1", "key": "start_soldier", "per": 1.0, "max": 2, "cost": [2, 4], "need": "command"},
	"drill": {"name": "정예 훈련", "branch": "army", "desc": "모든 병사 스킬 위력 +10%", "key": "skill", "per": 0.1, "max": 3, "cost": [2, 3, 5], "need": "recruit"},
	"mend": {"name": "회복의 기운", "branch": "army", "desc": "모든 병사 초당 체력 0.4% 회복", "key": "regen", "per": 0.004, "max": 2, "cost": [3, 5], "need": "drill"},
	"bulwark": {"name": "방패 진", "branch": "army", "desc": "전투 시작 때 보호막 (최대 체력 8%)", "key": "shield", "per": 0.08, "max": 2, "cost": [3, 5], "need": "mend"},
	# 보급
	"clay": {"name": "흙 창고", "branch": "supply", "desc": "판을 시작할 때 흙 +6", "key": "start_clay", "per": 6.0, "max": 3, "cost": [1, 2, 3], "need": "core"},
	"ticket": {"name": "뽑기권 꾸러미", "branch": "supply", "desc": "판을 시작할 때 뽑기권 +1", "key": "start_tickets", "per": 1.0, "max": 3, "cost": [2, 3, 4], "need": "clay"},
	"night_pearl": {"name": "밤 사냥", "branch": "supply", "desc": "밤을 넘길 때마다 진주 +1", "key": "night_pearls", "per": 1.0, "max": 2, "cost": [2, 4], "need": "ticket"},
	"night_clay": {"name": "흙 수레", "branch": "supply", "desc": "밤을 넘길 때마다 흙 +2", "key": "night_clay", "per": 2.0, "max": 2, "cost": [2, 4], "need": "night_pearl"},
	"bounty": {"name": "밤 보상", "branch": "supply", "desc": "★3 밤마다 뽑기권 +1", "key": "night_tickets", "per": 1.0, "max": 1, "cost": [6], "need": "night_clay"},
	# 병사
	"train": {"name": "단련", "branch": "unit", "desc": "모든 병사 공격력 +5%", "key": "atk", "per": 0.05, "max": 3, "cost": [1, 2, 4], "need": "core"},
	"tough": {"name": "튼튼한 몸", "branch": "unit", "desc": "모든 병사 체력 +8%", "key": "hp", "per": 0.08, "max": 3, "cost": [1, 2, 4], "need": "train"},
	"swift": {"name": "날랜 손", "branch": "unit", "desc": "모든 병사 공격 속도 +5%", "key": "haste", "per": 0.05, "max": 3, "cost": [2, 3, 5], "need": "tough"},
	"eagle": {"name": "매의 눈", "branch": "unit", "desc": "모든 병사 사거리 +8%", "key": "range", "per": 0.08, "max": 2, "cost": [2, 4], "need": "swift"},
	"focus": {"name": "스킬 숙련", "branch": "unit", "desc": "스킬 재사용 -5%", "key": "cdr", "per": 0.05, "max": 2, "cost": [3, 5], "need": "eagle"},
	# 상점
	"purse": {"name": "진주 주머니", "branch": "shop", "desc": "판을 시작할 때 진주 +3", "key": "start_pearls", "per": 3.0, "max": 3, "cost": [1, 2, 3], "need": "core"},
	"hunter": {"name": "진주 사냥꾼", "branch": "shop", "desc": "진주를 얻는 처치 수 -1 (6 → 5 → 4)", "key": "pearl_rate", "per": 1.0, "max": 2, "cost": [2, 4], "need": "purse"},
	"reroll": {"name": "단골 손님", "branch": "shop", "desc": "아침마다 다시 진열 1번 공짜", "key": "free_reroll", "per": 1.0, "max": 1, "cost": [3], "need": "hunter"},
	"haggle": {"name": "흥정", "branch": "shop", "desc": "상점 값 -1 (최소 1)", "key": "discount", "per": 1.0, "max": 1, "cost": [5], "need": "reroll"},
	# 가마
	"fire": {"name": "불 다스리기", "branch": "kiln", "desc": "안전한 불 +1 (그만큼 덜 깨진다)", "key": "safe_heat", "per": 1.0, "max": 2, "cost": [2, 4], "need": "core"},
	"glaze": {"name": "고운 유약", "branch": "kiln", "desc": "상품이 될 몫 +5%p", "key": "fine_bonus", "per": 0.05, "max": 2, "cost": [2, 4], "need": "fire"},
	"aura": {"name": "요변 기운", "branch": "kiln", "desc": "요변이 될 몫 +2%p", "key": "legend_bonus", "per": 0.02, "max": 2, "cost": [3, 5], "need": "glaze"},
	"shard": {"name": "파편 모으기", "branch": "kiln", "desc": "요변 확정에 필요한 파편 -1", "key": "shard_need", "per": 1.0, "max": 1, "cost": [5], "need": "aura"},
	"favor": {"name": "가마신의 총애", "branch": "kiln", "desc": "내기 꽝 천장 -1", "key": "bet_pity", "per": 1.0, "max": 3, "cost": [2, 3, 4], "need": "shard"},
	# 합동
	"c_pow": {"name": "합을 맞추다", "branch": "combo", "desc": "합동 기술 피해 +15%", "key": "combo_pow", "per": 0.15, "max": 3, "cost": [1, 3, 5], "need": "core"},
	"c_cd": {"name": "손발이 척척", "branch": "combo", "desc": "합동 기술 재사용 -10%", "key": "combo_cd", "per": 0.1, "max": 2, "cost": [3, 5], "need": "c_pow"},
	"c_first": {"name": "선제 신호", "branch": "combo", "desc": "첫 합동 기술이 2초 빨리", "key": "combo_first", "per": 120.0, "max": 1, "cost": [4], "need": "c_cd"},
	"c_heal": {"name": "함께 숨 고르기", "branch": "combo", "desc": "합동 기술 때 모든 아군 체력 10% 회복", "key": "combo_heal", "per": 0.1, "max": 1, "cost": [5], "need": "c_first"},
}
const BRANCH_NAME := {"core": "마을", "army": "부대", "supply": "보급", "unit": "병사", "shop": "상점", "kiln": "가마", "combo": "합동"}
const RECORDS_KEEP := 5          # 챕터마다 남기는 기록 수

var embers := 0                  # 불씨
var levels := {}                 # 칸 → 단계
var lord_name := ""              # 군주 이름 (2026-12-01 "닉네임 ... 군주 같은 개념으로 왼쪽 위에 프로필")
var lord_exp := 0                # 넘긴 밤 수의 합 (판이 끝날 때 더한다) → 군주 단계
var best := {}                   # 가장 멀리 간 판 {chapter, night, kills, date}
var records := {}                # "1".."5" → [{time, date, army}] (빠른 순)
var path := SAVE


func _init(save_path := SAVE) -> void:
	path = save_path
	levels = {"core": 1}


func level(id: String) -> int:
	return levels.get(id, 0)


func cost(id: String) -> int:
	var n: Dictionary = NODES[id]
	var lv := level(id)
	return -1 if lv >= n["max"] else n["cost"][lv]


func can_buy(id: String) -> bool:
	var n: Dictionary = NODES[id]
	var c := cost(id)
	return c >= 0 and embers >= c and (n["need"] == "" or level(n["need"]) >= 1)


func buy(id: String) -> bool:
	if not can_buy(id):
		return false
	embers -= cost(id)
	levels[id] = level(id) + 1
	return true


## 판에 줄 효과 {key: 값}
func effects() -> Dictionary:
	var e := {}
	for id in NODES:
		var n: Dictionary = NODES[id]
		if n["key"] != "" and level(id) > 0:
			e[n["key"]] = e.get(n["key"], 0.0) + n["per"] * level(id)
	return e


## (예전) 판이 끝나면 불씨 — 2026-11-28 부터는 ★3 밤마다 1개 (EMBER_PER_3STAR). 기록 화면 호환용으로 남김
const EMBER_PER_3STAR := 1
static func embers_for(_chapters_cleared: int, _nights_cleared: int, _kills: int) -> int:
	return 0


## 챕터를 넘긴 시간(초, 밤 전투 시간 합)을 기록. 순위(1부터)를 돌려준다
func add_record(chapter: int, seconds: float, army_note := "") -> int:
	var key := str(chapter)
	var list: Array = records.get(key, [])
	var rec := {"time": snappedf(seconds, 0.1), "date": Time.get_date_string_from_system(), "army": army_note, "name": lord_name}
	list.append(rec)
	list.sort_custom(func(a, b): return a["time"] < b["time"])
	var rank: int = list.find(rec) + 1
	records[key] = list.slice(0, RECORDS_KEEP)
	return rank if rank <= RECORDS_KEEP else -1


## 판이 끝나면: 가장 멀리 간 기록 (챕터·밤이 더 깊거나, 같으면 처치가 많으면) 바꾼다. 새 기록이면 true
func note_run(chapter: int, night: int, kills: int, cleared_all := false) -> bool:
	var reach: int = chapter * 10 + night + (100 if cleared_all else 0)
	var old: int = best.get("reach", -1)
	if reach > old or (reach == old and kills > best.get("kills", 0)):
		best = {"reach": reach, "chapter": chapter, "night": night, "kills": kills, "all": cleared_all, "date": Time.get_date_string_from_system(), "name": lord_name}
		return true
	return false


func save() -> void:
	var cf := ConfigFile.new()
	cf.set_value("meta", "best", best)
	cf.set_value("meta", "lord_name", lord_name)
	cf.set_value("meta", "lord_exp", lord_exp)
	cf.set_value("meta", "embers", embers)
	cf.set_value("meta", "levels", levels)
	cf.set_value("meta", "records", records)
	cf.save(path)


func load_saved() -> void:
	var cf := ConfigFile.new()
	if cf.load(path) != OK:
		return
	embers = cf.get_value("meta", "embers", 0)
	levels = cf.get_value("meta", "levels", {"core": 1})
	records = cf.get_value("meta", "records", {})
	best = cf.get_value("meta", "best", {})
	lord_name = cf.get_value("meta", "lord_name", "")
	lord_exp = cf.get_value("meta", "lord_exp", 0)


# ---------------- 군주 (닉네임·단계) ----------------
const LORD_TITLES := [[0, "마을 촌장"], [6, "고을 수령"], [18, "성주"], [36, "영주"], [60, "대군주"]]
const NAME_MIN := 2
const NAME_MAX := 8


## 이름 다듬기: 앞뒤 빈칸 빼고 길이 확인. 못 쓰면 ""
static func clean_name(s: String) -> String:
	var n := s.strip_edges().replace("\n", "")
	if n.length() < NAME_MIN or n.length() > NAME_MAX:
		return ""
	return n


func lord_level() -> int:
	var lv := 0
	for i in LORD_TITLES.size():
		if lord_exp >= LORD_TITLES[i][0]:
			lv = i
	return lv


func lord_title() -> String:
	return LORD_TITLES[lord_level()][1]


## 다음 단계까지 [지금, 필요] (마지막 단계면 [1, 1])
func lord_progress() -> Vector2i:
	var lv := lord_level()
	if lv >= LORD_TITLES.size() - 1:
		return Vector2i(1, 1)
	var a: int = LORD_TITLES[lv][0]
	var b: int = LORD_TITLES[lv + 1][0]
	return Vector2i(lord_exp - a, b - a)
