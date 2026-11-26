extends RefCounted
## 테스트 묶음의 공통 도우미.

const Data = preload("res://src/core/data.gd")
const World = preload("res://src/core/world.gd")
const Run = preload("res://src/core/run.gd")
const Echo = preload("res://src/core/echo.gd")
const Save = preload("res://src/core/save.gd")
const Habits = preload("res://src/core/habits.gd")
const PlayerBot = preload("res://tests/bots/player_bot.gd")

const IDLE := {"move": Vector2.ZERO, "aim": Vector2.ZERO, "attack": false, "dodge": false}

var failures: Array = []


func check(cond: bool, msg: String) -> void:
	if not cond:
		failures.append(msg)


## 봇으로 한 판을 끝까지 돌린다. 보상은 항상 첫 번째, 회수도 첫 번째.
func play_run(run, bot_style: String, weapon: String, seed_value: int, max_frames := 60 * 60 * 12) -> void:
	run.start(weapon)
	var bot = null
	var frames := 0
	while run.state != "end" and frames < max_frames:
		match run.state:
			"room", "echo":
				if bot == null or bot.brain == null:
					bot = PlayerBot.new(bot_style, weapon, seed_value)
				run.step(bot.decide(run.world))
				frames += 1
			"reward", "recover":
				run.choose(0)
			"analysis":
				run.begin_echo_fight()
	return
