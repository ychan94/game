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
	"general", "sniper", "haetae", "cheoyong", "dragon", "baekho", "jujak", "hyeonmu"]
const ROLE_NAME_KILN := {"spear": "창병", "archer": "궁수", "shield": "방패병",
	"axe": "도끼병", "cavalry": "기마병", "slinger": "투석병",
	"healer": "무당", "cannon": "화차", "twin": "쌍검무사",
	"general": "장수", "sniper": "신궁",
	"haetae": "해치", "cheoyong": "처용",
	"dragon": "청룡", "baekho": "백호", "jujak": "주작", "hyeonmu": "현무"}
const ROLE_DESC := {
	"spear": "앞에서 찌른다", "archer": "멀리서 쏜다", "shield": "도깨비를 끌어 막는다",
	"axe": "휘둘러 주변을 함께 벤다", "cavalry": "빠르게 달려들어 끊는다", "slinger": "돌을 던져 밀어낸다",
	"healer": "다친 병사를 고친다", "cannon": "아주 멀리 터지는 불화살", "twin": "두 칼로 아주 빠르게 벤다",
	"general": "곁의 병사 공격력 +30%", "sniper": "가장 강한 적을 끝에서 저격",
	"haetae": "해치 탈을 쓴 수호장, 적을 끌어당기고 불을 뿜는다", "cheoyong": "춤으로 주변 적을 모두 느리게",
	"dragon": "용 투구의 장군, 청룡언월도로 한 줄을 꿰뚫는다",
	"baekho": "흰 범 가죽의 무사, 번개 같은 발톱", "jujak": "봉황 깃의 도사, 불꽃 깃털을 쏜다", "hyeonmu": "거북 방패와 뱀 지팡이, 모든 공격을 받아 낸다",
}
const ROLE_NAME_NEST := {"spear": "공격형", "archer": "원거리형", "shield": "수비형"}
const ROLE_STATS := {
	"spear": {"hp": 60.0, "atk": 10.0, "range": 24.0, "cd": 40, "speed": 1.2},
	"archer": {"hp": 35.0, "atk": 8.0, "range": 260.0, "cd": 50, "speed": 0.0},
	"shield": {"hp": 140.0, "atk": 4.0, "range": 22.0, "cd": 50, "speed": 0.9},
	"axe": {"hp": 85.0, "atk": 12.0, "range": 26.0, "cd": 56, "speed": 1.0},
	"cavalry": {"hp": 75.0, "atk": 9.0, "range": 24.0, "cd": 32, "speed": 2.0},
	"healer": {"hp": 40.0, "atk": 0.0, "range": 190.0, "cd": 75, "speed": 0.0},
	"cannon": {"hp": 45.0, "atk": 16.0, "range": 340.0, "cd": 120, "speed": 0.0},
	"slinger": {"hp": 45.0, "atk": 7.0, "range": 200.0, "cd": 38, "speed": 0.0},
	"twin": {"hp": 90.0, "atk": 7.0, "range": 22.0, "cd": 18, "speed": 1.6},
	"general": {"hp": 180.0, "atk": 15.0, "range": 26.0, "cd": 44, "speed": 1.0},
	"sniper": {"hp": 50.0, "atk": 55.0, "range": 460.0, "cd": 110, "speed": 0.0},
	"haetae": {"hp": 520.0, "atk": 20.0, "range": 30.0, "cd": 50, "speed": 0.8},
	"cheoyong": {"hp": 240.0, "atk": 14.0, "range": 26.0, "cd": 36, "speed": 1.0},
	"dragon": {"hp": 380.0, "atk": 70.0, "range": 420.0, "cd": 96, "speed": 0.0},
	"baekho": {"hp": 420.0, "atk": 34.0, "range": 26.0, "cd": 26, "speed": 2.0},
	"jujak": {"hp": 280.0, "atk": 30.0, "range": 360.0, "cd": 48, "speed": 0.0},
	"hyeonmu": {"hp": 950.0, "atk": 16.0, "range": 30.0, "cd": 50, "speed": 0.6},
}
const SLING_PUSH := 8.0          # 투석병: 맞은 적을 조금 밀어낸다
const GENERAL_AURA := 100.0      # 장수 곁 이 거리 안의 병사는
const GENERAL_BUFF := 0.3        #   공격력 +30% (장수 여럿이어도 한 번만)
const HAETAE_TAUNT := 160.0      # 해치: 이 거리 안 적은 해치를 노린다
const HAETAE_BREATH := 0.5       # 해치: 맞은 적 주변(44px) 50% 불 피해
const CHEOYONG_AURA := 110.0     # 처용: 이 거리 안 적은 늘 느려진다
const DRAGON_LINE := 28.0        # 청룡: 앞쪽, 위아래 이 폭 안의 적을 모두 꿰뚫는다
const HYEONMU_TAUNT := 180.0     # 현무: 이 거리 안 적은 현무를 노린다
const HYEONMU_REDUCE := 0.3      # 현무: 받는 피해 -30%
const JUJAK_SPLASH := 0.5        # 주작: 맞은 적 주변(36px) 50% 불 피해 + 화상
const AXE_CLEAVE := 0.6          # 도끼: 맞은 적 주변(34px)도 60% 피해
const CANNON_SPLASH := 0.7       # 화차: 터진 자리 주변(44px) 70% 피해
const HEAL_AMOUNT := 10.0        # 무당: 한 번에 회복
const HEAL_SCALE := 0.35         # 등급·별 배율의 35%만 회복에 더한다 (전설 무당이 대장 공격을 다 지워 끝나지 않는 싸움 방지)

# ---------- 병사 뽑기 (가마의 병사) ----------
## 흙을 내고 뽑으면 병사 모양·유약이 무작위로 정해져 가마에 들어간다. 품질(보통·상품·요변)은 가마 불이 정한다.
## 등급 6단계. 신화는 아주 드물다.
## 억울하지 않은 운: 확률은 화면에 숫자로 · 등급별 천장 · 전설을 뽑을 때마다 신화 조각 1, 5개면 다음 뽑기 신화 확정
const GRADES := ["common", "uncommon", "rare", "hero", "legendary", "mythic"]
const GRADE_NAME := {"common": "일반", "uncommon": "고급", "rare": "희귀", "hero": "영웅", "legendary": "전설", "mythic": "신화"}
const GRADE_ODDS := {"common": 0.52, "uncommon": 0.27, "rare": 0.13, "hero": 0.06, "legendary": 0.018, "mythic": 0.002}
const ROLE_GRADE := {"spear": "common", "archer": "common", "shield": "common",
	"axe": "uncommon", "cavalry": "uncommon", "slinger": "uncommon",
	"healer": "rare", "cannon": "rare", "twin": "rare",
	"general": "hero", "sniper": "hero",
	"haetae": "legendary", "cheoyong": "legendary",
	"dragon": "mythic", "baekho": "mythic", "jujak": "mythic", "hyeonmu": "mythic"}
## 천장: 이 등급 이상이 이만큼 안 나오면 다음 뽑기는 그 등급 확정 (높은 천장이 먼저)
const PITY := {"rare": 20, "hero": 50, "legendary": 100}   # 사용자: "희귀 20번, 영웅은 50번, 전설은 100번"
const MYTH_SHARDS := 5            # 전설 5번 → 신화 확정 (사용자: "신화는 전설 5번 뽑으면 천장")
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
# ---------- 고유 스킬 (병사마다 하나, 별 ★3·★4·★5 에서 강화) ----------
## 스킬 (2026-11-28 "색깔이 다르면 스킬이 다르도록 ... 스킬마다 정확한 퍼뎀 수치")
## cd: 재사용 프레임. pct: 피해 = 공격력 × pct (★ 단계마다 위력 × (1 + 0.5 × lv), lv: ★3 = 1, ★4 = 2, ★5 = 3)
## 설명은 skill_info() 가 수치에서 만든다 → 화면에 나오는 숫자 = 실제 계산
const SKILLS := {
	"spear": {"name": "돌격 찌르기", "cd": 300, "pct": 3.5, "kind": "hit"},
	"archer": {"name": "연사", "cd": 330, "pct": 1.5, "kind": "hit"},
	"shield": {"name": "방패 벽", "cd": 420, "pct": 0.0, "kind": "support"},
	"axe": {"name": "회오리 베기", "cd": 330, "pct": 2.0, "kind": "hit"},
	"cavalry": {"name": "돌파", "cd": 360, "pct": 1.4, "kind": "hit"},
	"slinger": {"name": "바윗돌", "cd": 300, "pct": 3.0, "kind": "hit"},
	"healer": {"name": "큰 굿", "cd": 420, "pct": 0.0, "kind": "support"},
	"cannon": {"name": "신기전 일제 사격", "cd": 420, "pct": 0.8, "kind": "hit"},
	"twin": {"name": "칼춤", "cd": 300, "pct": 0.8, "kind": "hit"},
	"general": {"name": "진군의 북", "cd": 480, "pct": 0.0, "kind": "support"},
	"sniper": {"name": "관통 화살", "cd": 360, "pct": 3.0, "kind": "hit"},
	"haetae": {"name": "화염 숨결", "cd": 360, "pct": 1.5, "kind": "hit"},
	"cheoyong": {"name": "역신 쫓는 춤", "cd": 480, "pct": 1.0, "kind": "hit"},
	"dragon": {"name": "용오름", "cd": 540, "pct": 1.2, "kind": "hit"},
	"baekho": {"name": "범의 포효", "cd": 420, "pct": 7.0, "kind": "hit"},
	"jujak": {"name": "불새 강림", "cd": 480, "pct": 1.0, "kind": "hit"},
	"hyeonmu": {"name": "거북 등딱지", "cd": 540, "pct": 0.0, "kind": "support"},
}
## 유약마다 스킬 이름 [청자, 진사, 흑유]
const SKILL_NAMES := {
	"spear": ["물살 찌르기", "불창 돌격", "바위 꿰뚫기"],
	"archer": ["물방울 연사", "불화살 연사", "돌촉 연사"],
	"shield": ["물막이 방패", "불벽 방패", "바위 방패"],
	"axe": ["소용돌이 베기", "불회오리 베기", "땅울림 베기"],
	"cavalry": ["물보라 돌파", "불말 돌파", "지축 돌파"],
	"slinger": ["물수제비 돌", "불덩이 돌", "큰 바윗돌"],
	"healer": ["맑은 물 굿", "불씨 굿", "흙 굿"],
	"cannon": ["물폭탄 신기전", "대신기전", "철환 신기전"],
	"twin": ["물결 칼춤", "불꽃 칼춤", "흙먼지 칼춤"],
	"general": ["물결 진군고", "불꽃 진군고", "철벽 진군고"],
	"sniper": ["물줄기 관통", "불꽃 관통", "철촉 관통"],
	"haetae": ["물안개 숨결", "화염 숨결", "흙먼지 숨결"],
	"cheoyong": ["물 위의 춤", "불탈 춤", "땅 구르는 춤"],
	"dragon": ["물기둥 용오름", "불기둥 용오름", "흙기둥 용오름"],
	"baekho": ["서리 포효", "불꽃 포효", "바위 포효"],
	"jujak": ["비 깃털 강림", "불새 강림", "돌깃털 강림"],
	"hyeonmu": ["물 등딱지", "불 등딱지", "바위 등딱지"],
}
## 유약 효과: 공격 스킬은 맞은 적에게, 돕는 스킬은 받은 아군에게
const SKILL_FIRE_POW := 1.25      # 진사: 피해 +25% + 화상
const SKILL_WATER_SLOW := 180     # 청자: 맞은 적 3초 느리게 (40%)
const SKILL_EARTH_STUN := 30      # 흑유: 맞은 적 0.5초 기절
const SKILL_EARTH_SHIELD := 0.15  # 흑유: 쓴 병사 최대 체력 15% 보호막
const SKILL_SUP_HEAL := 0.10      # 청자 돕는 스킬: 받은 아군 최대 체력 10% 회복
const SKILL_SUP_ATK := 0.15       # 진사 돕는 스킬: 받은 아군 4초 공격력 +15%
const SKILL_SUP_SHIELD := 0.10    # 흑유 돕는 스킬: 받은 아군 최대 체력 10% 보호막


static func skill_name(role: String, element: String) -> String:
	var i: int = ELEMENTS.find(element)
	return SKILL_NAMES[role][i] if i >= 0 and SKILL_NAMES.has(role) else SKILLS[role]["name"]


## 스킬 설명 (실제 계산 수치로). lv = 스킬 단계 (★3 = 1). 화면은 이것만 쓴다
static func skill_info(role: String, element: String, lv: int) -> Dictionary:
	var sk: Dictionary = SKILLS[role]
	var mul: float = 1.0 + 0.5 * lv
	var fire: bool = element == "fire"
	var pc := func(x: float) -> String: return "%d%%" % roundi(x * mul * (SKILL_FIRE_POW if fire else 1.0) * 100.0)
	var d := ""
	match role:
		"spear": d = "가장 가까운 적에게 뛰어들어 공격력의 %s 피해%s" % [pc.call(sk["pct"]), " · 1초 기절" if lv >= 3 else ""]
		"archer": d = "가까운 적 %d명에게 화살, 한 발에 공격력의 %s" % [3 + lv, pc.call(sk["pct"])]
		"shield": d = "반경 %d 안 아군 4초간 받는 피해 -40%%%s" % [70 + 30 * lv, " · 적을 끌어당김" if lv >= 3 else ""]
		"axe": d = "반경 %d 안 적 모두 공격력의 %s" % [45 + 8 * lv, pc.call(sk["pct"])]
		"cavalry": d = "앞으로 %d 내달려 지나는 적 모두 공격력의 %s%s" % [110 + 30 * lv, pc.call(sk["pct"]), " · 밀쳐냄" if lv >= 3 else ""]
		"slinger": d = "큰 돌로 공격력의 %s + %.1f초 기절%s" % [pc.call(sk["pct"]), (50 + 20 * lv) / 60.0, (" · 주변 %s" % pc.call(1.2)) if lv >= 2 else ""]
		"healer": d = "주변 아군 모두 치유력의 %d%% 회복%s" % [roundi(150 * mul), " · 보호막 10%" if lv >= 3 else ""]
		"cannon": d = "적 %d명에게 불화살 공격력의 %s + 주변 폭발 %s" % [4 + lv, pc.call(sk["pct"]), pc.call(sk["pct"] * 0.5)]
		"twin": d = "주변 적을 %d번 벤다, 한 번에 공격력의 %s" % [6 + lv, pc.call(sk["pct"])]
		"general": d = "모든 아군 5초간 공격력 +%d%%%s" % [30 + 10 * lv, " · 공격 속도도" if lv >= 3 else ""]
		"sniper": d = "한 줄을 꿰뚫어 맞은 적 모두 공격력의 %s" % pc.call(sk["pct"])
		"haetae": d = "앞쪽 반경 %d 적 모두 공격력의 %s + 화상" % [90 + 30 * lv, pc.call(sk["pct"])]
		"cheoyong": d = "반경 %d 적 모두 공격력의 %s + %.1f초 기절" % [120 + 25 * lv, pc.call(sk["pct"]), (60 + 20 * lv) / 60.0]
		"dragon": d = "모든 적에게 공격력의 %s + 3초 느리게" % pc.call(sk["pct"])
		"baekho": d = "가장 강한 적에게 덮쳐 공격력의 %s, 주변 기절" % pc.call(sk["pct"])
		"jujak": d = "깃털 %d개, 하나에 공격력의 %s + 화상" % [8 + 2 * lv, pc.call(sk["pct"])]
		"hyeonmu": d = "모든 아군에게 최대 체력의 %d%% 보호막" % (20 + 5 * lv)
	var e := ""
	if sk["kind"] == "hit":
		e = {"water": "청자: 맞은 적 3초간 40% 느리게", "fire": "진사: 피해 +25% · 3초 화상", "earth": "흑유: 맞은 적 0.5초 기절 · 나에게 보호막 15%"}.get(element, "")
	else:
		e = {"water": "청자: 받은 아군 체력 10% 회복", "fire": "진사: 받은 아군 4초간 공격력 +15%", "earth": "흑유: 받은 아군 보호막 10%"}.get(element, "")
	var ups := []
	for i in 3:
		ups.append(skill_info_short(role, i + 1))
	return {"name": skill_name(role, element), "base": sk["name"], "cd": sk["cd"], "desc": d, "elem": e, "up": ups}


## ★3·★4·★5 에서 무엇이 오르나 (짧게)
static func skill_info_short(role: String, lv: int) -> String:
	var m := "위력 ×%.1f" % (1.0 + 0.5 * lv)
	match role:
		"spear": return m + (" · 1초 기절" if lv >= 3 else "")
		"archer": return "화살 %d발 · %s" % [3 + lv, m]
		"shield": return "반경 %d%s" % [70 + 30 * lv, " · 끌어당김" if lv >= 3 else ""]
		"axe": return "반경 %d · %s" % [45 + 8 * lv, m]
		"cavalry": return "거리 %d · %s%s" % [110 + 30 * lv, m, " · 밀쳐냄" if lv >= 3 else ""]
		"slinger": return "기절 %.1f초 · %s%s" % [(50 + 20 * lv) / 60.0, m, " · 주변까지" if lv >= 2 else ""]
		"healer": return "회복 ×%.1f%s" % [1.0 + 0.5 * lv, " · 보호막" if lv >= 3 else ""]
		"cannon": return "%d발 · %s" % [4 + lv, m]
		"twin": return "%d번 · %s" % [6 + lv, m]
		"general": return "공격력 +%d%%%s" % [30 + 10 * lv, " · 공격 속도" if lv >= 3 else ""]
		"cheoyong": return "반경 %d · 기절 %.1f초 · %s" % [120 + 25 * lv, (60 + 20 * lv) / 60.0, m]
		"haetae": return "반경 %d · %s%s" % [90 + 30 * lv, m, " · 화상 두 배" if lv >= 3 else ""]
		"jujak": return "깃털 %d개 · %s" % [8 + 2 * lv, m]
		"hyeonmu": return "보호막 %d%%" % (20 + 5 * lv)
	return m


const SKILL_FIRST := 0.5          # 첫 스킬은 재사용 시간의 절반 뒤


static func skill_level(star: int) -> int:
	return clampi(star - 2, 0, 3)


# ---------- 진영 시너지 (같은 진영 '서로 다른' 병사 수) ----------
## kind: shield 보호막(최대 체력 비율) · atk 공격력 · haste 공격 속도 · cdr 스킬 재사용 단축 · all_atk 모든 아군 공격력
const FACTIONS := {
	"gwangun": {"name": "관군", "roles": ["spear", "shield", "cavalry", "general"], "tiers": [2, 3, 4], "kind": "shield", "vals": [0.1, 0.2, 0.35], "desc": "전투 시작 때 관군에게 보호막 (최대 체력 %d%%)"},
	"sasu": {"name": "명사수", "roles": ["archer", "sniper", "cannon"], "tiers": [2, 3], "kind": "atk", "vals": [0.15, 0.35], "desc": "명사수 공격력 +%d%%"},
	"uibyeong": {"name": "의병", "roles": ["axe", "twin", "slinger"], "tiers": [2, 3], "kind": "haste", "vals": [0.2, 0.4], "desc": "의병 공격 속도 +%d%%"},
	"musok": {"name": "무속", "roles": ["healer", "cheoyong", "haetae"], "tiers": [2, 3], "kind": "cdr", "vals": [0.2, 0.4], "desc": "무속 스킬 재사용 -%d%%"},
	"sasin": {"name": "사신", "roles": ["dragon", "baekho", "jujak", "hyeonmu"], "tiers": [2, 3, 4], "kind": "all_atk", "vals": [0.1, 0.25, 0.5], "desc": "모든 아군 공격력 +%d%%"},
}


static func faction_of(role: String) -> String:
	for f in FACTIONS:
		if role in FACTIONS[f]["roles"]:
			return f
	return ""


# ---------- 전직 (★3 이상 + 같은 진영의 다른 병사 → 그 병사의 스킬을 흡수) ----------
const PROMO_STAR := 3
const PROMO_BONUS := 0.2          # 전직하면 체력·공격력 +20%
const PROMO_ADJ := {"spear": "창술", "shield": "철벽", "cavalry": "질풍", "general": "지휘", "archer": "속사", "sniper": "백발백중",
	"cannon": "화포", "axe": "광전", "twin": "쌍검", "slinger": "투석", "healer": "치유", "cheoyong": "춤꾼", "haetae": "화염",
	"dragon": "청룡의", "baekho": "백호의", "jujak": "주작의", "hyeonmu": "현무의"}


# ---------- 진주와 상점 ----------
const PEARL_PER_KILLS := 6        # 처치 6마리마다 진주 1
const PEARL_BOSS := 5             # (예전) 대장 진주 — 2026-11-28 부터 최종 보스 밤은 보상 ×1.5 (BOSS_REWARD_MUL)
const SHOP_SLOTS := 4             # 아침마다 진열 4개
const SHOP_REROLL := 1            # 진열 다시 굴리기 진주 1
## w: 진열될 몫 (확률표에 % 로 보인다), from: 이 챕터부터 나온다 (2026-11-28 "뽑기권은 많이 나와도 1개만 ... 낮은 확률로 5개", "챕터 3부터는 장비도")
const SHOP_ITEMS := {
	"whetstone": {"name": "숫돌", "price": 3, "desc": "공격력 +15%", "stat": "atk", "val": 0.15, "w": 20},
	"scale": {"name": "쇠비늘", "price": 3, "desc": "체력 +20%", "stat": "hp", "val": 0.2, "w": 20},
	"scroll": {"name": "비급서", "price": 4, "desc": "스킬 위력 +25%", "stat": "skill", "val": 0.25, "w": 16},
	"bell": {"name": "신령 방울", "price": 4, "desc": "스킬 재사용 -15%", "stat": "cdr", "val": 0.15, "w": 16},
	"ticket": {"name": "뽑기권", "price": 2, "desc": "뽑기권 1장", "stat": "ticket", "val": 1.0, "w": 10},
	"ticket5": {"name": "뽑기권 꾸러미", "price": 8, "desc": "뽑기권 5장", "stat": "ticket", "val": 5.0, "w": 2},
	"eq_blade": {"name": "강철 칼날", "price": 5, "desc": "장비: 공격력", "stat": "equip", "type": "blade", "w": 6, "from": 3},
	"eq_armor": {"name": "두석린갑", "price": 5, "desc": "장비: 체력", "stat": "equip", "type": "armor", "w": 6, "from": 3},
	"eq_charm": {"name": "신속 부적", "price": 5, "desc": "장비: 공격 속도", "stat": "equip", "type": "charm", "w": 6, "from": 3},
	"eq_gourd": {"name": "약 호리병", "price": 5, "desc": "장비: 체력 회복", "stat": "equip", "type": "gourd", "w": 6, "from": 3},
}


## 이 챕터 진열 확률표 [[key, 몫(0~1)], ...] — 화면의 표와 restock 이 같이 쓴다
static func shop_table(chapter: int) -> Array:
	var tot := 0.0
	var rows: Array = []
	for k in SHOP_ITEMS:
		if chapter >= SHOP_ITEMS[k].get("from", 1):
			rows.append([k, float(SHOP_ITEMS[k]["w"])])
			tot += SHOP_ITEMS[k]["w"]
	for r in rows:
		r[1] /= tot
	return rows
const UPG_MAX := 1.0              # 한 병사의 같은 강화는 +100% 까지 (재사용 단축은 50%)


# ---------- 가마신과 내기 (가마를 열 때 걸 수 있다) ----------
## 억울하지 않은 운: 확률은 화면에 그대로 · 꽝 3번이면 다음 내기는 대박 확정
const BET_ODDS := [
	["jackpot", "대박", 0.15, "가마 안 새 병사 모두 별 +1"],
	["twin", "쌍둥이", 0.2, "새 병사 하나가 둘로"],
	["gold", "금빛", 0.15, "새 병사 하나가 요변으로"],
	["pearls", "진주 비", 0.2, "진주 +4"],
	["bust", "꽝", 0.3, "새 병사 하나가 깨진다 (파편 +1)"],
]
const BET_PITY := 10               # 꽝 10번이면 다음은 대박 (2026-11-28 사용자: "꽝 10번당 1번 대박")

const VILLAGE_LINE := 112.0     # 마을 담장 선 (왼쪽 마을 구역 끝). 도깨비가 여기 닿으면 마을이 맞는다
const ALLY_AGGRO := 210.0       # 창병·방패병이 도깨비를 알아채고 마주 나가는 거리
const ALLY_LEASH := 170.0       # 제자리에서 이만큼 넘게는 쫓지 않는다 (대열이 무너지지 않게)
const ALLY_LINGER := 45          # 적이 없어도 이만큼(프레임) 기다렸다가 제자리로 (앞뒤로 오가지 않게)
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
const SYNERGY_COUNT := 3         # (예전) 같은 속성 3이면 합동 기술 — 2026-11-28 부터 병사 조합 합동 기술(COMBOS)로 바뀜
## 합동 기술: 부대에 필요한 병사가 모두 있으면, 로비에서 고른 하나만 쓴다 (2026-11-28 "병사 조합에 따른 합동 공격 ... 무조건 1개만 선택")
## needs: 꼭 있어야 하는 병사들, any: [후보 병사들, 몇 종] (신화처럼 고르는 조건), element: 파도·컷신 빛깔
## pct: 파도가 적 하나에 주는 피해 = 조합에 드는 병사들(부대에 있는 그 종류 모두)의 공격력 합 × pct (2026-11-28 "조합에 들어가는 병사와 유닛의 공격력을 합한 거에 퍼센트 데미지")
## bonus: 파도와 함께 오는 효과 (atk 모든 아군 공격력 / shield 보호막 / heal 회복 / stun 기절 / slow 느리게)
const COMBOS := {
	"tide": {"name": "해일 진격", "needs": ["spear", "shield", "archer"], "element": "water", "pct": 0.5, "bonus": "slow", "desc": "물마루가 전장을 휩쓸어 적을 밀어내고 느리게 한다"},
	"blaze": {"name": "화염 폭풍", "needs": ["slinger", "cannon", "archer"], "element": "fire", "pct": 0.65, "bonus": "", "desc": "불길이 전장을 훑고 지나가며 모두 불태운다"},
	"quake": {"name": "대지 가르기", "needs": ["axe", "shield", "cavalry"], "element": "earth", "pct": 0.5, "bonus": "stun", "desc": "땅을 갈라 적을 1.5초 기절시킨다"},
	"march": {"name": "진군의 함성", "needs": ["general", "spear", "cavalry"], "element": "fire", "pct": 0.4, "bonus": "atk", "desc": "불 파도와 함께 모든 아군 6초간 공격력 +40%"},
	"fortress": {"name": "철벽진", "needs": ["shield", "haetae", "hyeonmu"], "element": "earth", "pct": 0.3, "bonus": "shield", "desc": "흙 파도와 함께 모든 아군에게 최대 체력 25% 보호막"},
	"rite": {"name": "큰 굿판", "needs": ["healer", "cheoyong", "twin"], "element": "water", "pct": 0.4, "bonus": "heal", "desc": "맑은 물결과 함께 모든 아군 체력 40% 회복"},
	"volley": {"name": "명궁 일제 사격", "needs": ["archer", "sniper", "slinger"], "element": "water", "pct": 0.7, "bonus": "slow", "desc": "화살비가 물결처럼 쏟아져 적을 느리게 한다"},
	"guardians": {"name": "사신 강림", "needs": [], "any": [["dragon", "baekho", "jujak", "hyeonmu"], 2], "element": "fire", "pct": 1.0, "bonus": "atk", "desc": "신화 둘이 힘을 합쳐 거대한 불 파도 + 공격력 +40%"},
}
const COMBO_ATK := 0.4             # atk: 공격력 +40%
const COMBO_ATK_FRAMES := 360      # 6초
const COMBO_SHIELD := 0.25         # shield: 최대 체력 25%
const COMBO_HEAL := 0.4            # heal: 최대 체력 40%
const COMBO_STUN := 90             # stun: 1.5초


## 이 병사들(역할 목록)로 합동 기술을 쓸 수 있나
static func combo_ok(id: String, roles: Array) -> bool:
	if not COMBOS.has(id):
		return false
	var c: Dictionary = COMBOS[id]
	for r in c["needs"]:
		if not roles.has(r):
			return false
	if c.has("any"):
		var n := 0
		for r in c["any"][0]:
			if roles.has(r):
				n += 1
		if n < c["any"][1]:
			return false
	return true


## 합동 기술에 드는 병사 종류 (needs + any 후보)
static func combo_roles(id: String) -> Array:
	var c: Dictionary = COMBOS[id]
	var out: Array = c["needs"].duplicate()
	if c.has("any"):
		for r in c["any"][0]:
			if not out.has(r):
				out.append(r)
	return out


## 조건을 글로: "창병 + 방패병 + 궁수" / "청룡·백호·주작·현무 중 2"
## 합동 기술 설명 (실제 계산과 같은 수치)
static func combo_dmg_text(id: String) -> String:
	var c: Dictionary = COMBOS[id]
	var e: String = {"water": "밀어내고 느리게", "fire": "화상", "earth": "1.5초 기절"}[c["element"]]
	return "참여 병사 공격력 합의 %d%% 피해 + %s" % [roundi(c["pct"] * 100.0), e]


static func combo_need_text(id: String) -> String:
	var c: Dictionary = COMBOS[id]
	var parts: Array = c["needs"].map(func(r): return ROLE_NAME_KILN[r])
	if c.has("any"):
		parts.append("%s 중 %d종" % ["·".join(c["any"][0].map(func(r): return ROLE_NAME_KILN[r])), c["any"][1]])
	return " + ".join(parts)
const SYNERGY_FIRST := 360       # 첫 합동 기술은 6초 뒤 (2026-11-28 "쿨타임이 너무 짧은 것 같아": 3초 → 6초)
const SYNERGY_EVERY := 900       # 그 뒤 15초마다 (8초 → 15초)
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
	{"name": "여우골 숲", "new": "fox", "boss": "gumiho", "hp": 2.4, "boss_hp": 0.8},
	{"name": "안개 늪", "new": "armored", "boss": "imugi", "hp": 6.8, "boss_hp": 0.65},
	{"name": "얼음 고개", "new": "ghost", "boss": "reaper", "hp": 16.0, "boss_hp": 0.65},
	{"name": "도깨비 성", "new": "giant", "boss": "king", "hp": 20.0, "boss_hp": 0.65},
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
	if n >= KILN_NIGHTS:
		return boss_plan(chapter)   # 여섯째 밤은 최종 보스 밤
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
		var o: Dictionary = st.call(kind).duplicate()
		if n >= 2 and k % SNEAK_EVERY == 3:
			o["sneak"] = true
		plan.append([f, kind, o])
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
	plan.sort_custom(func(a, b): return a[0] < b[0])
	return plan


## 최종 보스 밤 (챕터의 여섯째 밤): 호위 도깨비(다섯째 밤 세기) + 처음부터 나오는 챕터 최종 보스 (2026-11-28 사용자)
static func boss_plan(chapter := 1) -> Array:
	var ch: Dictionary = CHAPTERS[clampi(chapter, 1, CHAPTERS.size()) - 1]
	var hp_mul: float = (1.0 + (KILN_NIGHTS - 2) * NIGHT_HP_GROWTH) * ch["hp"]
	var st := func(kind: String) -> Dictionary:
		return {"hp": ENEMIES[kind]["hp"] * hp_mul, "atk": ENEMIES[kind]["atk"] * sqrt(ch["hp"])}
	var plan: Array = []
	var k := 0
	for f in range(60, 1300, 48):
		k += 1
		var kind: String = ch["new"] if ch["new"] != "" and k % CHAPTER_NEW_EVERY == 0 else "goblin"
		var o: Dictionary = st.call(kind).duplicate()
		if k % SNEAK_EVERY == 3:
			o["sneak"] = true
		plan.append([f, kind, o])
	for f2 in [240, 520, 800, 1080]:
		plan.append([f2, "imp", st.call("imp")])
	for f3 in [400, 900]:
		plan.append([f3, "brute", st.call("brute")])
	var boss: String = ch["boss"]
	plan.append([300, boss, {"hp": ENEMIES[boss]["hp"] * ch["boss_hp"] * BOSS_STAGE_HP, "final": true}])
	plan.sort_custom(func(a, b): return a[0] < b[0])
	return plan


# ---------- 여러 밤 (가마의 병사 한 판) ----------
const KILN_NIGHTS := 6            # 챕터마다 밤 6번, 여섯째 밤은 최종 보스 (2026-11-28 "각 챕터별로 6번째 밤 ... 최종 보스")
const BOSS_STAGE_HP := 1.6        # 최종 보스는 예전 대장보다 체력 ×1.6
const BOSS_REWARD_MUL := 1.5      # 최종 보스 밤 보상 = 보통 밤의 1.5배 (뽑기권·흙·진주)
## 원군 (2026-11-28 "아군이 다 죽게 되면 ... 원군이 도와주는 돌발 ... 대기실 병사 3명 ... 챕터 3부터")
const REINFORCE_FROM_CHAPTER := 3
const REINFORCE_COUNT := 3
## 전술 뽑기 (2026-11-28 "2챕터에서는 ... 전술 뽑기 ... 50명의 적군을 물리칠 때마다 ... 보스의 HP가 50% 이하가 될 때")
const DRAFT_FROM_CHAPTER := 2
const DRAFT_KILLS := 50
const DRAFT_CHOICES := 3
const DRAFT_REROLL := 1           # 다시 뽑기 진주 1
## 카드: key 는 병사 능력치(soldier_mods 와 같은 이름) 또는 판 전체(village_guard · combo_pow). w: 나올 몫
const TACTICS := {
	"t_atk": {"name": "날 선 창끝", "desc": "모든 병사 공격력 +8%", "key": "atk", "val": 0.08, "rare": "common", "icon": "blade", "w": 10},
	"t_hp": {"name": "두꺼운 갑옷", "desc": "모든 병사 체력 +12%", "key": "hp", "val": 0.12, "rare": "common", "icon": "armor", "w": 10},
	"t_haste": {"name": "빠른 손놀림", "desc": "모든 병사 공격 속도 +8%", "key": "haste", "val": 0.08, "rare": "common", "icon": "charm", "w": 9},
	"t_range": {"name": "멀리 보기", "desc": "모든 병사 사거리 +10%", "key": "range", "val": 0.10, "rare": "common", "icon": "scale", "w": 8},
	"t_regen": {"name": "약초 주머니", "desc": "모든 병사 초당 체력 0.3% 회복", "key": "regen", "val": 0.003, "rare": "common", "icon": "gourd", "w": 8},
	"t_skill": {"name": "비전 수련", "desc": "모든 병사 스킬 위력 +15%", "key": "skill", "val": 0.15, "rare": "rare", "icon": "scroll", "w": 6},
	"t_cdr": {"name": "명상", "desc": "모든 병사 스킬 재사용 -8%", "key": "cdr", "val": 0.08, "rare": "rare", "icon": "bell", "w": 6},
	"t_shield": {"name": "가마 수호막", "desc": "밤마다 시작 보호막 (최대 체력 8%)", "key": "shield", "val": 0.08, "rare": "rare", "icon": "armor", "w": 6},
	"t_boss": {"name": "대장 사냥꾼", "desc": "도깨비 대장에게 주는 피해 +15%", "key": "boss_dmg", "val": 0.15, "rare": "rare", "icon": "fire", "w": 5},
	"t_wall": {"name": "목책", "desc": "도깨비가 마을에 주는 피해 -10%", "key": "village_guard", "val": 0.10, "rare": "rare", "icon": "armor", "w": 5},
	"t_combo": {"name": "북소리 맞추기", "desc": "합동 기술 피해 +20%", "key": "combo_pow", "val": 0.20, "rare": "hero", "icon": "bell", "w": 3},
	"t_all": {"name": "가마신의 숨결", "desc": "모든 병사 공격력 +12% · 체력 +12%", "key": "atk+hp", "val": 0.12, "rare": "hero", "icon": "fire", "w": 2},
}
const TACTIC_RARE_NAME := {"common": "일반", "rare": "희귀", "hero": "영웅"}
const NIGHT_HP_GROWTH := 0.45     # 챕터 안에서 밤마다 도깨비 체력 +45% (봇 균형 검사)
## '완승 아니면 완패' 막기 (2026-11-28 "완승 아니면 완패 현상은 고쳐야"):
##   1) 몰래 파고드는 도깨비: 둘째 밤부터 일부가 아군을 피해 마을로 → 잡는 힘이 모자란 만큼만 조금씩 샌다
##   2) 한 밤에 마을이 잃는 체력은 ROUT_CAP 까지 (아군이 다 쓰러져도 남은 도깨비는 약탈하고 물러간다)
const SNEAK_EVERY := 6            # 둘째 밤부터 도깨비 6마리 중 1마리가 몰래 파고든다
const SNEAK_SPEED := 1.25         # 몰래 파고드는 도깨비는 조금 빠르다
const ROUT_CAP := 0.6            # 한 밤에 마을이 잃는 체력 상한 (최대 체력의 60%) — 아무리 나빠도 한 밤에 끝나지는 않는다
const CHAPTER_REPAIR := 0.35      # 챕터를 넘기면 마을 체력을 최대의 35% 만큼 고친다 (예전: 다 고침)
const ARMY_CAP_START := 9         # 병사 자리 (사용자: "병사 종류랑 갯수도 좀 더 많아야")
const ARMY_CAP_PER_NIGHT := 2     # 밤마다 자리 +2
const ARMY_CAP_MAX := 18          # 자리는 여기까지 (그다음 성장은 별·등급·요변으로)
const CLAY_START := 24            # 처음 흙 (뽑기 8번)
const CLAY_REFIRE := 2            # 있는 병사 다시 굽기
const CLAY_PER_NIGHT := 4         # 밤을 넘기면 흙 (다시 굽기·뽑기에 쓴다)
const TICKETS_PER_NIGHT := 2      # 밤을 넘기면 뽑기권 (1장 = 뽑기 1번, 흙 없이)
const TICKET_PER_KILLS := 12      # 처치 12마리마다 뽑기권 1장 더
const TICKETS_BOSS := 3           # 대장을 쓰러뜨리면 뽑기권 더
## 별 올리기: 같은 병사·같은 별 3명을 합치면 별 +1 (★5 까지). 사용자: "같은 거 3개씩만 합쳐서 하는걸로 하자"
## 요변은 요변끼리만 (사용자 요청)
const MAX_STAR := 5
const STAR_MUL := {1: 1.0, 2: 1.6, 3: 2.5, 4: 3.8, 5: 5.6}


const MERGE_COUNT := 3


static func merge_need(_star: int) -> int:
	return MERGE_COUNT


# ---------- 장비 (챕터 3부터) ----------
## 병사 한 명에 하나. 밤을 넘기면 전리품으로 얻는다. 언제든 끼우고 뺄 수 있고 사라지지 않는다
const EQUIP_FROM_CHAPTER := 3
const EQUIPS := {
	"blade": {"name": "강철 칼날", "short": "칼날", "desc": "공격력", "atk": 0.25},
	"armor": {"name": "두석린갑", "short": "갑옷", "desc": "체력", "hp": 0.35},
	"charm": {"name": "신속 부적", "short": "부적", "desc": "공격 속도", "haste": 0.2},
	"gourd": {"name": "약 호리병", "short": "호리병", "desc": "초당 체력 회복", "regen": 0.012},
}
const EQUIP_LEVEL_MUL := {1: 1.0, 2: 1.8, 3: 2.8}
const EQUIP_LEVEL_NAME := {1: "", 2: "+", 3: "++"}
## 챕터별 장비 단계 확률 [1단계, 2단계, 3단계]
const EQUIP_LEVEL_ODDS := {3: [0.7, 0.25, 0.05], 4: [0.5, 0.35, 0.15], 5: [0.3, 0.45, 0.25]}
const EQUIP_PER_NIGHT := 1
const EQUIP_BOSS := 2             # 대장 밤에는 2개 (그중 하나는 2단계 이상 확정)


## 장비 → 전투 배율 {atk, hp, haste, regen}
static func equip_mods(item: Dictionary) -> Dictionary:
	if item.is_empty():
		return {}
	var e: Dictionary = EQUIPS[item["type"]]
	var k: float = EQUIP_LEVEL_MUL[item["level"]]
	var m := {}
	for key in ["atk", "hp", "haste", "regen"]:
		if e.has(key):
			m[key] = e[key] * k
	return m
const VILLAGE_REPAIR := 30.0      # 밤이 지나면 마을 체력 회복


# ---------- 가마 (B) ----------
const KILN_SLOTS := 100             # 가마에 한 번에 넣는 수 (2026-11-28 사용자: "최대로 뽑을 수 있는 수는 100명까지")
const RESERVE_MAX := 300            # 대기실 칸 (부대에 안 넣은 병사)
const KILN_MAX_HEAT := 10
const KILN_SAFE_HEAT := 4        # 여기까지는 절대 안 깨진다 (억울함 방지)
const SHARDS_FOR_LEGEND := 3     # 파편 3개면 다음 굽기에서 요변 1개 확정


## 불 세기 → 병사 한 명의 확률 (화면에 그대로 보여 준다)
## 밤 별: 마을 체력 비율로 (90% 이상 ★3 · 60% 이상 ★2 · 30% 이상 ★1 · 그 아래 ★0)
static func night_stars(vk: float) -> int:
	return 3 if vk >= 0.9 else (2 if vk >= 0.6 else (1 if vk >= 0.3 else 0))


## 실제로 나오는 몫: 깨짐 → 요변 → 상품 순서로 굴리므로 겹치는 몫을 빼고, 나머지는 보통. 넷을 더하면 1
static func kiln_shares(o: Dictionary) -> Dictionary:
	var crack: float = o["crack"]
	var legend: float = (1.0 - crack) * o["legend"]
	var fine: float = (1.0 - crack) * (1.0 - o["legend"]) * o["fine"]
	return {"legend": legend, "fine": fine, "normal": maxf(0.0, 1.0 - crack - legend - fine), "crack": crack}


## 몫을 정수 %로: 가장 큰 나머지부터 1씩 더해 합이 꼭 100
static func percent_100(shares: Dictionary) -> Dictionary:
	var out := {}
	var rem := []
	var total := 0
	for k in shares:
		var x: float = shares[k] * 100.0
		out[k] = int(floor(x + 1e-6))
		total += out[k]
		rem.append([x - out[k], k])
	rem.sort_custom(func(a, b): return a[0] > b[0])
	var i := 0
	while total < 100 and i < rem.size():
		out[rem[i][1]] += 1
		total += 1
		i += 1
	return out


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
