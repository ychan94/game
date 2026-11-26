extends RefCounted
## 어제의 나(메아리): 프로필 만들기, 습관 → 두뇌 값 바꾸기, 두뇌(입력 만들기).
## 두뇌는 플레이어와 똑같은 조작(이동·조준·공격·구르기)만 낸다. 테스트용 플레이어 봇도 이 두뇌를 쓴다.

const Data = preload("res://src/core/data.gd")


static func make_profile(weapon: String, abilities: Array, habits: Dictionary, floor_reached: int, result: String) -> Dictionary:
	return {
		"version": 1,
		"weapon": weapon,
		"abilities": abilities.duplicate(),
		"habits": habits.duplicate(),
		"floor": floor_reached,
		"result": result,
		"tutorial": false,
	}


## 처음 하는 사람을 위한 미리 만든 메아리
static func tutorial_profile() -> Dictionary:
	var p := make_profile("sword", ["heavy"], {
		"dodge_per_min": 6.0, "dodge_reactive": 0.5, "pref_distance": 60.0, "circle": 0.3,
		"attack_per_min": 40.0, "main_ability": "heavy", "combat_seconds": 120.0,
	}, 2, "tutorial")
	p["tutorial"] = true
	return p


static func default_distance(weapon: String) -> float:
	return 40.0 if weapon == "sword" else 150.0


## 습관 → 두뇌 값. 따라 하기는 최대 FIDELITY(70%)까지만 섞는다.
static func brain_params(habits: Dictionary, weapon: String) -> Dictionary:
	var f := Data.ECHO_FIDELITY
	var reactive: float = habits.get("dodge_reactive", 0.35)
	var per_min: float = habits.get("dodge_per_min", 6.0)
	return {
		"weapon": weapon,
		"distance": lerpf(default_distance(weapon), clampf(habits.get("pref_distance", 100.0), 24.0, 220.0), f),
		"reactive": lerpf(0.35, reactive, f),
		"random_dodge_per_min": per_min * (1.0 - reactive) * f,
		"circle": clampf(habits.get("circle", 0.0), -1.0, 1.0) * f,
		"aggression": lerpf(30.0, habits.get("attack_per_min", 30.0), f),
	}


## 테스트 봇처럼 "습관을 그대로" 쓰고 싶을 때 (섞지 않음)
static func raw_params(style: Dictionary, weapon: String) -> Dictionary:
	return {
		"weapon": weapon,
		"distance": style.get("distance", default_distance(weapon)),
		"reactive": style.get("reactive", 0.5),
		"random_dodge_per_min": style.get("random_dodge_per_min", 0.0),
		"circle": style.get("circle", 0.0),
		"aggression": style.get("aggression", 60.0),
		"punish": style.get("punish", false),
	}


class Brain:
	var p: Dictionary
	var rng := RandomNumberGenerator.new()
	var threat_cd := 0

	func _init(params: Dictionary, seed_value: int) -> void:
		p = params
		rng.seed = seed_value

	func decide(world, me) -> Dictionary:
		var idle := {"move": Vector2.ZERO, "aim": Vector2.ZERO, "attack": false, "dodge": false}
		var target = world.nearest_foe(me)
		if target == null:
			return idle
		threat_cd = maxi(0, threat_cd - 1)
		var to: Vector2 = target.pos - me.pos
		var d := maxf(to.length(), 0.001)
		var dir := to / d
		var move := Vector2.ZERO
		var want: float = p["distance"]
		# 분석표를 읽은 플레이어: 상대가 멈췄거나(구르기 끝) 공격 뒤 빈틈이면 파고든다 (메아리 두뇌는 안 씀)
		if p.get("punish", false) and (target.exposed > 0 or target.attack_cd > 10 or target.state == "windup"):
			want = 20.0 if p["weapon"] == "sword" else want
		if d > want + 12.0:
			move += dir
		elif d < want - 12.0:
			move -= dir
		move += dir.orthogonal() * float(p["circle"])

		var can_dodge: bool = me.dodge_t == 0 and me.dodge_charges > 0
		var dodge := false
		var threat = world.threat_toward(me, 70.0)
		if threat != null:
			# 위험하면 일단 위험에서 비켜 선다 (구르기는 확률)
			move = threat.orthogonal() if rng.randf() < 0.5 else -threat.orthogonal()
			if can_dodge and threat_cd == 0:
				threat_cd = 20
				if rng.randf() < float(p["reactive"]):
					dodge = true
		# 분석표를 읽은 검 플레이어: 멀리서 쏘는 상대에게는 앞으로 굴러 거리를 좁힌다
		if not dodge and threat == null and p.get("punish", false) and p["weapon"] == "sword" and target.weapon == "bow" \
				and d > 90.0 and d < 200.0 and can_dodge:
			dodge = true
			move = dir
		if not dodge and can_dodge and rng.randf() < float(p["random_dodge_per_min"]) / 3600.0:
			dodge = true
			move = dir.orthogonal() * (1.0 if rng.randf() < 0.5 else -1.0)

		var in_range := false
		if p["weapon"] == "sword":
			in_range = d <= Data.WEAPONS["sword"]["range"] + target.radius + 8.0
		else:
			in_range = d <= 300.0
		var attack: bool = in_range and me.attack_cd == 0 and rng.randf() < clampf(float(p["aggression"]) / 60.0, 0.15, 1.0)
		if move.length() > 1.0:
			move = move.normalized()
		return {"move": move, "aim": dir, "attack": attack, "dodge": dodge}
