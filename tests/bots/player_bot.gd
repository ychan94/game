extends RefCounted
## 테스트용 플레이어 봇. world.observe 와 같은 정보만 보고 플레이어 조작만 낸다.
## 두뇌는 메아리와 같은 것을 "습관 그대로(섞지 않고)" 쓴다.

const Echo = preload("res://src/core/echo.gd")

const STYLES := {
	# 구르기를 자주 하고 가까이 붙는 사람
	"roller": {"distance": 30.0, "reactive": 0.9, "random_dodge_per_min": 20.0, "circle": 0.6, "aggression": 60.0},
	# 거의 안 구르고 멀리서 싸우는 사람 (검이면 가까이 갈 수밖에 없어 거리는 무기 따라)
	"steady": {"distance": 150.0, "reactive": 0.15, "random_dodge_per_min": 0.0, "circle": -0.5, "aggression": 60.0},
	# 무난한 사람
	"normal": {"distance": -1.0, "reactive": 0.6, "random_dodge_per_min": 3.0, "circle": 0.2, "aggression": 60.0},
	# 분석표를 읽고 빈틈을 노리는 사람 (보스전 테스트용)
	"reader": {"distance": -1.0, "reactive": 0.6, "random_dodge_per_min": 3.0, "circle": 0.2, "aggression": 60.0, "punish": true},
}

var brain


func _init(style_name: String, weapon: String, seed_value := 11) -> void:
	var style: Dictionary = STYLES[style_name].duplicate()
	if style["distance"] < 0.0:
		style["distance"] = Echo.default_distance(weapon)
	brain = Echo.Brain.new(Echo.raw_params(style, weapon), seed_value)


func decide(world) -> Dictionary:
	return brain.decide(world, world.player)
