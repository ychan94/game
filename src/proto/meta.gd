extends RefCounted
## 강화 나무 (판이 끝나도 남는 영구 강화) + 시간 기록. 화면과 무관하게 돌아간다.
## 불씨: 판이 끝날 때 얻는다 (넘긴 챕터·밤·처치). 나무의 칸을 사면 다음 판부터 적용.
## 저장: user://meta.cfg (테스트는 path 를 바꿔 쓴다)

const SAVE := "user://meta.cfg"

## 가지: core 코어 · supply 보급 · unit 병사 · shop 상점 · kiln 가마
## key: 효과 이름, per: 단계마다 더하는 값, max: 최대 단계, cost: 단계별 값, need: 먼저 1단계 이상 있어야 하는 칸
const NODES := {
	"core": {"name": "가마터", "branch": "core", "desc": "강화 나무의 뿌리", "key": "", "per": 0.0, "max": 1, "cost": [0], "need": ""},
	"wall": {"name": "마을 성벽", "branch": "core", "desc": "도깨비가 마을에 주는 피해 -10%", "key": "village_guard", "per": 0.1, "max": 3, "cost": [8, 16, 28], "need": "core"},
	"command": {"name": "지휘 한도", "branch": "core", "desc": "병사 자리 +1", "key": "cap", "per": 1.0, "max": 2, "cost": [20, 40], "need": "wall"},
	"clay": {"name": "흙 창고", "branch": "supply", "desc": "판을 시작할 때 흙 +6", "key": "start_clay", "per": 6.0, "max": 3, "cost": [6, 12, 20], "need": "core"},
	"ticket": {"name": "뽑기권 꾸러미", "branch": "supply", "desc": "판을 시작할 때 뽑기권 +1", "key": "start_tickets", "per": 1.0, "max": 3, "cost": [10, 18, 30], "need": "clay"},
	"bounty": {"name": "밤 보상", "branch": "supply", "desc": "밤마다 뽑기권 +1", "key": "night_tickets", "per": 1.0, "max": 1, "cost": [45], "need": "ticket"},
	"train": {"name": "단련", "branch": "unit", "desc": "모든 병사 공격력 +5%", "key": "atk", "per": 0.05, "max": 3, "cost": [8, 16, 28], "need": "core"},
	"tough": {"name": "튼튼한 몸", "branch": "unit", "desc": "모든 병사 체력 +8%", "key": "hp", "per": 0.08, "max": 3, "cost": [8, 16, 28], "need": "train"},
	"focus": {"name": "스킬 숙련", "branch": "unit", "desc": "스킬 재사용 -5%", "key": "cdr", "per": 0.05, "max": 2, "cost": [24, 40], "need": "tough"},
	"purse": {"name": "진주 주머니", "branch": "shop", "desc": "판을 시작할 때 진주 +3", "key": "start_pearls", "per": 3.0, "max": 3, "cost": [6, 12, 20], "need": "core"},
	"haggle": {"name": "흥정", "branch": "shop", "desc": "상점 값 -1 (최소 1)", "key": "discount", "per": 1.0, "max": 1, "cost": [30], "need": "purse"},
	"fire": {"name": "불 다스리기", "branch": "kiln", "desc": "안전한 불 +1 (그만큼 덜 깨진다)", "key": "safe_heat", "per": 1.0, "max": 2, "cost": [15, 30], "need": "core"},
	"shard": {"name": "파편 모으기", "branch": "kiln", "desc": "요변 확정에 필요한 파편 -1", "key": "shard_need", "per": 1.0, "max": 1, "cost": [35], "need": "fire"},
	"favor": {"name": "가마신의 총애", "branch": "kiln", "desc": "내기 꽝 천장 -1", "key": "bet_pity", "per": 1.0, "max": 1, "cost": [25], "need": "fire"},
}
const BRANCH_NAME := {"core": "코어", "supply": "보급", "unit": "병사", "shop": "상점", "kiln": "가마"}
const RECORDS_KEEP := 5          # 챕터마다 남기는 기록 수

var embers := 0                  # 불씨
var levels := {}                 # 칸 → 단계
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


## 판이 끝나면 불씨: 넘긴 챕터 ×10 + 넘긴 밤 ×2 + 처치 40마리당 1
static func embers_for(chapters_cleared: int, nights_cleared: int, kills: int) -> int:
	return chapters_cleared * 10 + nights_cleared * 2 + kills / 40


## 챕터를 넘긴 시간(초, 밤 전투 시간 합)을 기록. 순위(1부터)를 돌려준다
func add_record(chapter: int, seconds: float, army_note := "") -> int:
	var key := str(chapter)
	var list: Array = records.get(key, [])
	var rec := {"time": snappedf(seconds, 0.1), "date": Time.get_date_string_from_system(), "army": army_note}
	list.append(rec)
	list.sort_custom(func(a, b): return a["time"] < b["time"])
	var rank: int = list.find(rec) + 1
	records[key] = list.slice(0, RECORDS_KEEP)
	return rank if rank <= RECORDS_KEEP else -1


func save() -> void:
	var cf := ConfigFile.new()
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
