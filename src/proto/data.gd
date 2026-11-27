extends RefCounted
## 1분 시험판 수치. 밸런스는 이 파일만 고친다.

const FPS := 60

# ---------- 속성 (유약 / 알의 기운) ----------
const ELEMENTS := ["water", "fire", "earth"]
const ELEMENT_NAME := {"water": "물", "fire": "불", "earth": "땅"}
const GLAZE_NAME := {"water": "청자", "fire": "진사", "earth": "흑유"}
const FOOD_NAME := {"water": "물 이슬", "fire": "불 열매", "earth": "돌 가루"}
const SYNERGY_NAME := {"water": "해일", "fire": "화염 파도", "earth": "지진"}

# ---------- 품질 ----------
const TIERS := ["normal", "fine", "legend"]
const TIER_MUL := {"normal": 1.0, "fine": 1.5, "legend": 2.6}
const TIER_NAME_KILN := {"normal": "보통", "fine": "상품", "legend": "요변"}
const TIER_NAME_NEST := {"normal": "보통", "fine": "희귀", "legend": "전설"}

# ---------- 역할 (빚는 모양 / 알 모양) ----------
const ROLES := ["spear", "archer", "shield"]
## 가마의 병사 15종 (등급 6단계). 뒤로 갈수록 드물고 강하다
const KILN_ROLES := ["spear", "archer", "shield", "axe", "cavalry", "slinger", "healer", "cannon", "twin",
	"general", "sniper", "haetae", "cheoyong", "dragon", "bulgasari"]
const ROLE_NAME_KILN := {"spear": "창병", "archer": "궁수", "shield": "방패병",
	"axe": "도끼병", "cavalry": "기마병", "slinger": "투석병",
	"healer": "무당", "cannon": "화차", "twin": "쌍검무사",
	"general": "장수", "sniper": "신궁",
	"haetae": "해치", "cheoyong": "처용",
	"dragon": "청룡", "bulgasari": "불가사리"}
const ROLE_DESC := {
	"spear": "앞에서 찌른다", "archer": "멀리서 쏜다", "shield": "도깨비를 끌어 막는다",
	"axe": "휘둘러 주변을 함께 벤다", "cavalry": "빠르게 달려들어 끊는다", "slinger": "돌을 던져 밀어낸다",
	"healer": "다친 병사를 고친다", "cannon": "아주 멀리 터지는 불화살", "twin": "두 칼로 아주 빠르게 벤다",
	"general": "곁의 병사 공격력 +30%", "sniper": "가장 강한 적을 끝에서 저격",
	"haetae": "불을 뿜는 수호 짐승, 적을 모두 끌어당긴다", "cheoyong": "춤으로 주변 적을 모두 느리게",
	"dragon": "한 줄의 적을 모두 꿰뚫는 물기둥", "bulgasari": "적을 쓰러뜨릴수록 커지고 강해진다",
}
const ROLE_NAME_NEST := {"spear": "공격형", "archer": "원거리형", "shield": "수비형"}
const ROLE_STATS := {
	"spear": {"hp": 60.0, "atk": 10.0, "range": 24.0, "cd": 40, "speed": 1.2},
	"archer": {"hp": 35.0, "atk": 8.0, "range": 200.0, "cd": 50, "speed": 0.0},
	"shield": {"hp": 140.0, "atk": 4.0, "range": 22.0, "cd": 50, "speed": 0.9},
	"axe": {"hp": 85.0, "atk": 12.0, "range": 26.0, "cd": 56, "speed": 1.0},
	"cavalry": {"hp": 75.0, "atk": 9.0, "range": 24.0, "cd": 32, "speed": 2.0},
	"healer": {"hp": 40.0, "atk": 0.0, "range": 150.0, "cd": 75, "speed": 0.0},
	"cannon": {"hp": 45.0, "atk": 16.0, "range": 280.0, "cd": 120, "speed": 0.0},
	"slinger": {"hp": 45.0, "atk": 7.0, "range": 150.0, "cd": 38, "speed": 0.0},
	"twin": {"hp": 90.0, "atk": 7.0, "range": 22.0, "cd": 18, "speed": 1.6},
	"general": {"hp": 180.0, "atk": 15.0, "range": 26.0, "cd": 44, "speed": 1.0},
	"sniper": {"hp": 50.0, "atk": 55.0, "range": 380.0, "cd": 110, "speed": 0.0},
	"haetae": {"hp": 520.0, "atk": 20.0, "range": 30.0, "cd": 50, "speed": 0.8},
	"cheoyong": {"hp": 240.0, "atk": 14.0, "range": 26.0, "cd": 36, "speed": 1.0},
	"dragon": {"hp": 380.0, "atk": 70.0, "range": 420.0, "cd": 96, "speed": 0.0},
	"bulgasari": {"hp": 560.0, "atk": 24.0, "range": 30.0, "cd": 40, "speed": 1.0},
}
const SLING_PUSH := 8.0          # 투석병: 맞은 적을 조금 밀어낸다
const GENERAL_AURA := 100.0      # 장수 곁 이 거리 안의 병사는
const GENERAL_BUFF := 0.3        #   공격력 +30% (장수 여럿이어도 한 번만)
const HAETAE_TAUNT := 160.0      # 해치: 이 거리 안 적은 해치를 노린다
const HAETAE_BREATH := 0.5       # 해치: 맞은 적 주변(44px) 50% 불 피해
const CHEOYONG_AURA := 110.0     # 처용: 이 거리 안 적은 늘 느려진다
const DRAGON_LINE := 28.0        # 청룡: 앞쪽, 위아래 이 폭 안의 적을 모두 꿰뚫는다
const BULGASARI_GROW := 0.04     # 불가사리: 처치마다 공격·체력 +4%
const BULGASARI_MAX := 3.0       #   최대 3배
const AXE_CLEAVE := 0.6          # 도끼: 맞은 적 주변(34px)도 60% 피해
const CANNON_SPLASH := 0.7       # 화차: 터진 자리 주변(44px) 70% 피해
const HEAL_AMOUNT := 10.0        # 무당: 한 번에 회복
const HEAL_SCALE := 0.35         # 등급·별 배율의 35%만 회복에 더한다 (전설 무당이 대장 공격을 다 지워 끝나지 않는 싸움 방지)

# ---------- 병사 뽑기 (가마의 병사) ----------
## 흙을 내고 뽑으면 병사 모양·유약이 무작위로 정해져 가마에 들어간다. 품질(보통·상품·요변)은 가마 불이 정한다.
## 등급 6단계. 신화는 아주 드물다.
## 억울하지 않은 운: 확률은 화면에 숫자로 · 등급별 천장 · 전설을 뽑을 때마다 신화 조각 1, 3개면 다음 뽑기 신화 확정
const GRADES := ["common", "uncommon", "rare", "hero", "legendary", "mythic"]
const GRADE_NAME := {"common": "일반", "uncommon": "고급", "rare": "희귀", "hero": "영웅", "legendary": "전설", "mythic": "신화"}
const GRADE_ODDS := {"common": 0.52, "uncommon": 0.27, "rare": 0.13, "hero": 0.06, "legendary": 0.018, "mythic": 0.002}
const ROLE_GRADE := {"spear": "common", "archer": "common", "shield": "common",
	"axe": "uncommon", "cavalry": "uncommon", "slinger": "uncommon",
	"healer": "rare", "cannon": "rare", "twin": "rare",
	"general": "hero", "sniper": "hero",
	"haetae": "legendary", "cheoyong": "legendary",
	"dragon": "mythic", "bulgasari": "mythic"}
## 천장: 이 등급 이상이 이만큼 안 나오면 다음 뽑기는 그 등급 확정 (높은 천장이 먼저)
const PITY := {"rare": 8, "hero": 30, "legendary": 90}
const MYTH_SHARDS := 3            # 전설 3번 → 신화 확정
const CLAY_DRAW := 3              # 한 번 뽑기
const CLAY_SMASH_BACK := 1        # 가마에 넣은 뽑기 병사를 부수면 돌려받는 흙


static func grade_roles(g: String) -> Array:
	return KILN_ROLES.filter(func(r): return ROLE_GRADE[r] == g)


static func draw_odds() -> Dictionary:
	var by := {}
	for r in KILN_ROLES:
		var g: String = ROLE_GRADE[r]
		by[r] = GRADE_ODDS[g] / grade_roles(g).size()
	return by
const VILLAGE_LINE := 112.0     # 마을 담장 선 (왼쪽 마을 구역 끝). 도깨비가 여기 닿으면 마을이 맞는다
const ALLY_AGGRO := 210.0       # 창병·방패병이 도깨비를 알아채고 마주 나가는 거리
const ALLY_LEASH := 170.0       # 제자리에서 이만큼 넘게는 쫓지 않는다 (대열이 무너지지 않게)
const SHIELD_TAUNT := 90.0       # 방패 근처 적은 방패를 먼저 노린다
const SHIELD_REDUCE := 0.4       # 방패는 받는 피해 -40%
const NEST_STAT_MUL := 1.45      # 괴수는 3마리라 한 마리가 더 강하다

const CREATURE_NAME := {
	"spear": {"fire": "불꽃 도마뱀", "water": "물살 수달", "earth": "가시 고슴도치"},
	"archer": {"fire": "불씨 박쥐", "water": "물방울 해파리", "earth": "돌팔매 원숭이"},
	"shield": {"fire": "용암 두꺼비", "water": "조개 거북", "earth": "바위 거북"},
}

# ---------- 속성 효과 ----------
const BURN_FRAMES := 120
const BURN_DPS := 3.0
const FIRE_SPLASH := 0.3         # 주변 적에게 피해의 30%
const SLOW_FRAMES := 90
const SLOW_MUL := 0.5
const KNOCKBACK := 14.0
const SPECIAL_EVERY := 360       # 요변·전설은 6초마다 혼자 특수기
const SYNERGY_COUNT := 3         # 같은 속성 3이면 합동 기술
const SYNERGY_FIRST := 180       # 첫 합동 기술은 3초 뒤
const SYNERGY_EVERY := 480       # 그 뒤 8초마다
const SYNERGY_POWER := 12.0      # 합동 기술 기본 위력 (같은 속성 3마리 기준). 높으면 승부가 합동 기술 하나로 갈린다
const SYNERGY_WAVE_SPEED := 9.0  # 합동 기술 파도가 마을 쪽에서 전장을 휩쓰는 속도 (프레임당 px). 지나가는 순서대로 맞는다
const ENEMY_SPREAD := 20.0       # 도깨비끼리 서로 밀어내는 거리 (겹쳐 보이지 않게, 몸 크기와 별개)

# ---------- 적 (도깨비) ----------
const ENEMIES := {
	"goblin": {"name": "도깨비", "hp": 30.0, "atk": 6.0, "speed": 0.7, "range": 22.0, "cd": 50, "village": 8.0, "radius": 9.0},
	"imp": {"name": "도깨비불", "hp": 18.0, "atk": 5.0, "speed": 0.8, "range": 110.0, "cd": 70, "village": 6.0, "radius": 7.0},
	"brute": {"name": "큰 도깨비", "hp": 110.0, "atk": 14.0, "speed": 0.45, "range": 26.0, "cd": 80, "village": 20.0, "radius": 14.0},
	"chief": {"name": "도깨비 대장", "hp": 2400.0, "atk": 42.0, "speed": 0.35, "range": 30.0, "cd": 70, "village": 80.0, "radius": 20.0, "heavy": true},
	# 챕터마다 새로 나오는 적 (armor: 한 대마다 깎는 피해 · heavy: 밀리거나 느려지지 않음 · summon: [종류, 몇 프레임마다])
	"fox": {"name": "여우 요괴", "hp": 26.0, "atk": 5.0, "speed": 1.3, "range": 20.0, "cd": 34, "village": 8.0, "radius": 8.0},
	"armored": {"name": "갑옷 도깨비", "hp": 60.0, "atk": 8.0, "speed": 0.55, "range": 22.0, "cd": 50, "village": 10.0, "radius": 10.0, "armor": 4.0},
	"ghost": {"name": "원귀", "hp": 40.0, "atk": 7.0, "speed": 0.9, "range": 22.0, "cd": 44, "village": 12.0, "radius": 9.0, "heavy": true},
	"giant": {"name": "거인 도깨비", "hp": 300.0, "atk": 22.0, "speed": 0.35, "range": 30.0, "cd": 90, "village": 30.0, "radius": 16.0, "heavy": true},
	# 챕터 대장
	"gumiho": {"name": "구미호", "hp": 2600.0, "atk": 34.0, "speed": 0.6, "range": 26.0, "cd": 40, "village": 80.0, "radius": 18.0, "heavy": true, "summon": ["fox", 120]},
	"imugi": {"name": "이무기", "hp": 5200.0, "atk": 46.0, "speed": 0.3, "range": 34.0, "cd": 60, "village": 90.0, "radius": 22.0, "heavy": true, "armor": 6.0},
	"reaper": {"name": "저승사자", "hp": 4600.0, "atk": 80.0, "speed": 0.45, "range": 30.0, "cd": 70, "village": 100.0, "radius": 18.0, "heavy": true, "summon": ["ghost", 150]},
	"king": {"name": "도깨비 왕", "hp": 8000.0, "atk": 60.0, "speed": 0.32, "range": 34.0, "cd": 60, "village": 120.0, "radius": 24.0, "heavy": true, "armor": 5.0, "summon": ["brute", 220]},
}
const BOSSES := ["chief", "gumiho", "imugi", "reaper", "king"]

## 챕터: 아침 5번·밤 5번. 다섯째 밤에 대장. hp: 도깨비 체력 배율 (챕터 첫 밤 기준)
const CHAPTERS := [
	{"name": "마을 어귀", "new": "", "boss": "chief", "hp": 1.0, "boss_hp": 1.0},
	{"name": "여우골 숲", "new": "fox", "boss": "gumiho", "hp": 1.6, "boss_hp": 0.8},
	{"name": "안개 늪", "new": "armored", "boss": "imugi", "hp": 2.4, "boss_hp": 0.65},
	{"name": "얼음 고개", "new": "ghost", "boss": "reaper", "hp": 3.4, "boss_hp": 0.65},
	{"name": "도깨비 성", "new": "giant", "boss": "king", "hp": 4.6, "boss_hp": 0.65},
]
const CHAPTER_NEW_EVERY := 3      # 챕터의 새 적: 도깨비 3마리마다 1마리가 새 적으로
const CLAY_PER_CHAPTER := 12      # 챕터를 넘기면 흙 보너스
const VILLAGE_HP := 160.0        # 새어 들어온 피해가 서서히 쌓이게 (낮으면 '완승 아니면 완패'가 된다)


## 약 22초짜리 밤 한 번: [프레임, 종류]. 아래 네 값으로 난이도를 맞춘다.
const WAVE_GOBLIN_EVERY := 44     # 도깨비가 몇 프레임마다 나오나 (1분 시험판 한 판)
const ARMY_GOBLIN_EVERY := 26     # 밤 5번 한 판: 병사가 9~17명이라 더 촘촘히
const WAVE_IMPS := [240, 600, 960]
const WAVE_BRUTES := [480, 1040]
const WAVE_RUSH := 6              # 마지막 몰려오기 마릿수
const ARMY_RUSH := 10             # 밤 5번 한 판의 몰려오기


## big_army: 밤 5번 한 판 (병사가 많다) — 더 촘촘하고 밤마다 더 몰려온다
static func wave_plan(night := 1, big_army := false, chapter := 1) -> Array:
	var n := maxi(1, night)
	var ch: Dictionary = CHAPTERS[clampi(chapter, 1, CHAPTERS.size()) - 1]
	var ch_mul: float = ch["hp"]
	var every := maxi(12, ARMY_GOBLIN_EVERY - (n - 1) * 3) if big_army else maxi(22, WAVE_GOBLIN_EVERY - (n - 1) * 5)
	var hp_mul := (1.0 + (n - 1) * NIGHT_HP_GROWTH) * ch_mul
	var st := func(kind: String) -> Dictionary:
		return {} if hp_mul == 1.0 else {"hp": ENEMIES[kind]["hp"] * hp_mul, "atk": ENEMIES[kind]["atk"] * sqrt(ch_mul)}
	var plan: Array = []
	var f := 60
	var k := 0
	while f <= 1100:
		k += 1
		var kind: String = ch["new"] if ch["new"] != "" and k % CHAPTER_NEW_EVERY == 0 else "goblin"
		plan.append([f, kind, st.call(kind)])
		f += every
	var imps: Array = WAVE_IMPS.duplicate()
	var brutes: Array = WAVE_BRUTES.duplicate()
	for i in n - 1:
		imps.append(300 + i * 170)
		brutes.append(620 + i * 140)
	for f2 in imps:
		plan.append([f2, "imp", st.call("imp")])
	for f3 in brutes:
		plan.append([f3, "brute", st.call("brute")])
	for i in (ARMY_RUSH + (n - 1) * 4) if big_army else (WAVE_RUSH + (n - 1) * 2):
		plan.append([1150 + i * 12, "goblin", st.call("goblin")])
	if n >= KILN_NIGHTS:
		var boss: String = ch["boss"]
		plan.append([1250, boss, {"hp": ENEMIES[boss]["hp"] * ch["boss_hp"]}])
	plan.sort_custom(func(a, b): return a[0] < b[0])
	return plan


# ---------- 여러 밤 (가마의 병사 한 판) ----------
const KILN_NIGHTS := 5            # 다섯째 밤에 도깨비 대장
const NIGHT_HP_GROWTH := 0.45     # 챕터 안에서 밤마다 도깨비 체력 +45% (봇 균형 검사)
const ARMY_CAP_START := 9         # 병사 자리 (사용자: "병사 종류랑 갯수도 좀 더 많아야")
const ARMY_CAP_PER_NIGHT := 2     # 밤마다 자리 +2
const ARMY_CAP_MAX := 18          # 자리는 여기까지 (그다음 성장은 별·등급·요변으로)
const CLAY_START := 24            # 처음 흙 (뽑기 8번)
const CLAY_REFIRE := 2            # 있는 병사 다시 굽기
const CLAY_PER_NIGHT := 6         # 밤을 넘기면 흙
const CLAY_PER_KILLS := 4         # 처치 4마리마다 흙 1
const MERGE_COUNT := 3            # 같은 병사 3명 → 별 +1
const MAX_STAR := 3
const STAR_MUL := {1: 1.0, 2: 1.8, 3: 3.0}
const VILLAGE_REPAIR := 30.0      # 밤이 지나면 마을 체력 회복


# ---------- 가마 (B) ----------
const KILN_SLOTS := 8
const KILN_MAX_HEAT := 10
const KILN_SAFE_HEAT := 4        # 여기까지는 절대 안 깨진다 (억울함 방지)
const SHARDS_FOR_LEGEND := 3     # 파편 3개면 다음 굽기에서 요변 1개 확정


## 불 세기 → 병사 한 명의 확률 (화면에 그대로 보여 준다)
static func kiln_odds(heat: int) -> Dictionary:
	return {
		"crack": 0.0 if heat <= KILN_SAFE_HEAT else (heat - KILN_SAFE_HEAT) * 0.07,
		"legend": 0.0 if heat <= 3 else (heat - 3) * 0.045,
		"fine": minf(0.6, heat * 0.06),
	}


# ---------- 둥지 (A) ----------
const NEST_EGGS := 3
const NEST_FINE_AT := 3          # 3번 데우면 희귀
const NEST_LEGEND_AT := 6        # 6번 데우면 전설
const NEST_LUCKY := 0.2          # 깰 때 한 단계 더 오를 확률
const FOOD_TILT := 0.8           # 먹이 속성이 될 확률


## 지금 온기에서 한 번 더 데울 때 터질 확률
static func nest_burst_chance(warmth: int) -> float:
	return 0.0 if warmth < 2 else (warmth - 1) * 0.07
