extends RefCounted
## 게임 수치와 목록. 밸런스를 바꿀 때는 이 파일만 고친다.

const FPS := 60

# ---------- 플레이어 기본 ----------
const PLAYER_HP := 100.0
const PLAYER_SPEED := 2.0          # 프레임당 픽셀 (초당 120px)
const PLAYER_RADIUS := 9.0
const DODGE_FRAMES := 14
const DODGE_SPEED_MUL := 2.6
const DODGE_RECHARGE := 40         # 구르기 1회 충전에 걸리는 프레임
const HURT_INVULN := 30
const FLOOR_HEAL := 20.0

# ---------- 판 구조 ----------
const ROOMS_PER_FLOOR := 3
const ECHO_FLOOR := 3              # 이 층에서 어제의 나를 만난다 (시험판은 여기서 끝)
const MAX_ABILITIES := 6

# ---------- 어제의 나 (메아리) ----------
const ECHO_HP := 220.0
const ECHO_FIDELITY := 0.7         # 습관을 따라 하는 최대 비율 (기획서: 최대 70%)
const ECHO_EXPOSED := 18           # 약점: 구르기 끝난 뒤 멈춰 있는 프레임 (0.3초)
const ECHO_EXPOSED_DMG_MUL := 1.5  # 약점 순간에 받는 피해 배율
const ECHO_ATTACK_CD_MUL := 1.3    # 약점: 공격 뒤 재사용 대기가 플레이어보다 길다
const ECHO_WINDUP := 12            # 공정성: 메아리는 공격 전 0.2초 자세를 잡는다 (보고 피할 수 있게)

# ---------- 무기 ----------
const WEAPONS := {
	"sword": {"name": "검", "damage": 12.0, "cooldown": 20, "range": 34.0, "arc": 100.0},
	"bow": {"name": "활", "damage": 9.0, "cooldown": 24, "shot_speed": 6.0, "life": 60},
}

# ---------- 능력 (최대 6개) ----------
const ABILITIES := {
	"spin": {"name": "회전 베기", "type": "공격", "desc": "검은 사방을 베고, 활은 세 갈래로 쏜다"},
	"pierce": {"name": "꿰뚫기", "type": "공격", "desc": "화살이 2명을 더 꿰뚫고, 검이 12px 더 닿는다"},
	"heavy": {"name": "강타", "type": "공격", "desc": "피해 +30%, 공격 간격 +15%"},
	"double_roll": {"name": "연속 구르기", "type": "이동", "desc": "구르기를 2번까지 모아 둔다"},
	"sprint": {"name": "질주", "type": "이동", "desc": "이동 속도 +25%"},
	"blast_roll": {"name": "폭발 구르기", "type": "이동", "desc": "구르기가 끝나는 자리에 폭발 (피해 10)"},
	"bloodthirst": {"name": "피의 갈증", "type": "지속", "desc": "적을 쓰러뜨리면 체력 4 회복"},
	"thorns": {"name": "가시 갑옷", "type": "지속", "desc": "맞으면 때린 상대에게 피해 6"},
}

# ---------- 적 ----------
const ENEMIES := {
	"slime": {"name": "슬라임", "hp": 20.0, "speed": 1.1, "radius": 9.0, "contact": 6.0},
	"archer": {"name": "궁수", "hp": 16.0, "speed": 1.0, "radius": 8.0, "contact": 3.0,
		"keep": 140.0, "aim": 20, "reload": 90, "shot_speed": 3.0, "shot_damage": 7.0},
	"charger": {"name": "돌진병", "hp": 30.0, "speed": 0.9, "radius": 11.0, "contact": 5.0,
		"dash_contact": 12.0, "sight": 150.0, "telegraph": 35, "dash": 18, "dash_speed": 6.0, "recover": 40},
}
const SPAWN_DELAY := 30  # 적이 나타나서 움직이기까지 (불공정한 첫 타 방지)

# 층·방마다 나오는 적
const ROOM_PLANS := {
	1: [["slime", "slime", "slime"], ["slime", "slime", "archer"], ["slime", "slime", "charger"]],
	2: [["slime", "slime", "slime", "archer", "archer"], ["charger", "charger", "archer", "slime", "slime"],
		["slime", "slime", "slime", "charger", "archer", "archer"]],
}
