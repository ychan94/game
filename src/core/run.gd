extends RefCounted
## 한 판의 흐름. 화면과 무관하게 돌아간다.
##
## 상태: start → room ⇄ reward → analysis → echo → recover → end
##   start     무기 고르기 (+ 기억 도감에서 능력 1개 들고 가기)
##   room      전투. 다 쓰러뜨리면 reward
##   reward    능력 3개 중 1개 고르기
##   analysis  "어제의 나 분석표"를 보고 준비
##   echo      어제의 나와 싸움
##   recover   이기면 어제의 능력 1개 회수
##   end       판이 끝남. 이번 판의 내가 다음 판의 메아리가 된다 (죽어도, 이겨도)

const Data = preload("res://src/core/data.gd")
const World = preload("res://src/core/world.gd")
const Echo = preload("res://src/core/echo.gd")
const Habits = preload("res://src/core/habits.gd")

var rng := RandomNumberGenerator.new()
var save
var state := "start"
var floor_no := 1
var room_no := 0
var weapon := "sword"
var abilities: Array = []
var player_hp := Data.PLAYER_HP
var world = null
var habits = null
var echo_profile := {}     # 이번 판에서 만날 어제의 나
var choices: Array = []
var result := ""
var new_echo := {}         # 이번 판이 끝나며 남긴 메아리
var echo_beaten := false


func _init(seed_value: int, save_store) -> void:
	rng.seed = seed_value
	save = save_store
	echo_profile = save.echo() if not save.echo().is_empty() else Echo.tutorial_profile()


func start(weapon_id: String, carried := "") -> void:
	weapon = weapon_id
	abilities = [carried] if carried != "" else []
	habits = Habits.new()
	player_hp = Data.PLAYER_HP
	floor_no = 1
	room_no = 0
	_enter_room()


func _enter_room() -> void:
	room_no += 1
	if floor_no >= Data.ECHO_FLOOR:
		state = "analysis"
		world = null
		return
	world = World.new(rng.randi())
	world.habits = habits
	world.spawn_player(weapon, abilities, Vector2(320, 300), player_hp)
	var plan: Array = Data.ROOM_PLANS[floor_no][room_no - 1]
	for kind in plan:
		world.spawn_enemy(kind, Vector2(rng.randf_range(60, 580), rng.randf_range(50, 170)))
	state = "room"


func begin_echo_fight() -> void:
	if state != "analysis":
		return
	world = World.new(rng.randi())
	world.habits = habits
	world.spawn_player(weapon, abilities, Vector2(320, 300), player_hp)
	world.spawn_echo(echo_profile, Vector2(320, 80), rng.randi())
	state = "echo"


func step(inputs: Dictionary) -> void:
	if state != "room" and state != "echo":
		return
	world.step(inputs)
	player_hp = world.player.hp
	if not world.player.alive:
		_end("dead")
	elif world.foes_left() == 0:
		if state == "echo":
			echo_beaten = true
			choices = []
			for a in echo_profile["abilities"]:
				if not abilities.has(a):
					choices.append(a)
			if choices.is_empty() or abilities.size() >= Data.MAX_ABILITIES:
				_end("victory")
			else:
				state = "recover"
		else:
			_room_cleared()


func _room_cleared() -> void:
	if room_no >= Data.ROOMS_PER_FLOOR:
		floor_no += 1
		room_no = 0
		player_hp = minf(Data.PLAYER_HP, player_hp + Data.FLOOR_HEAL)
	if abilities.size() >= Data.MAX_ABILITIES:
		_enter_room()
		return
	var pool: Array = []
	for id in Data.ABILITIES.keys():
		if not abilities.has(id):
			pool.append(id)
	choices = []
	for i in mini(3, pool.size()):
		choices.append(pool.pop_at(rng.randi_range(0, pool.size() - 1)))
	state = "reward"


func choose(index: int) -> void:
	if index < 0 or index >= choices.size():
		return
	var picked: String = choices[index]
	if state == "reward":
		abilities.append(picked)
		_enter_room()
	elif state == "recover":
		abilities.append(picked)
		save.add_codex(picked)
		_end("victory")


func _end(res: String) -> void:
	result = res
	state = "end"
	new_echo = Echo.make_profile(weapon, abilities, habits.summary(abilities), floor_no, res)
	save.store_echo(new_echo)


## 분석표: 화면과 테스트가 함께 쓴다. [{"label", "stars"(0~3), "value", "hint"}]
func analysis_rows() -> Array:
	var h: Dictionary = echo_profile["habits"]
	var rows: Array = []
	var dpm: float = h.get("dodge_per_min", 0.0)
	rows.append({"label": "구르기", "stars": _stars(dpm, [4.0, 10.0, 18.0]), "value": "1분에 %.0f번" % dpm,
		"hint": "구르기가 끝나는 순간 0.3초 멈춘다. 그때 때려라"})
	var dist: float = h.get("pref_distance", 100.0)
	var close := dist < 80.0
	rows.append({"label": "거리", "stars": 3 if dist < 50.0 or dist > 160.0 else 2 if close or dist > 120.0 else 1,
		"value": ("가까이 붙는다 (%.0fpx)" if close else "멀리서 싸운다 (%.0fpx)") % dist,
		"hint": "거리를 벌려라" if close else "파고들어라"})
	var main: String = h.get("main_ability", "")
	rows.append({"label": "주력 기술", "stars": 3 if main != "" else 0,
		"value": Data.ABILITIES[main]["name"] if main != "" else "없음",
		"hint": "쓰고 난 뒤 다시 쓰기까지 오래 걸린다" if main != "" else "기본 공격만 쓴다"})
	var c: float = h.get("circle", 0.0)
	rows.append({"label": "도는 방향", "stars": _stars(absf(c), [0.15, 0.35, 0.6]),
		"value": "시계 반대 방향" if c > 0.05 else "시계 방향" if c < -0.05 else "일정하지 않음",
		"hint": "도는 쪽 앞을 막아라" if absf(c) > 0.05 else "읽기 어렵다"})
	return rows


func _stars(v: float, steps: Array) -> int:
	var n := 0
	for s in steps:
		if v >= s:
			n += 1
	return n
