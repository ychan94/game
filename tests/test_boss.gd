extends "res://tests/suite.gd"
## boss: 어제의 나가 정말 "나"를 따라 하는지 + 봇이 어제의 나를 이길 수 있는지.
## 결과 줄은 RESULT_JSON: 으로 내보내고, scripts/test.py 가 reports/boss/ 에 남긴다.


## 같은 방 구성에서 봇 스타일만 바꿔 습관을 잰다
func _record_habits(style: String, weapon: String) -> Dictionary:
	var h = Habits.new()
	for seed_value in [1, 2, 3]:
		var w = World.new(seed_value)
		w.habits = h
		w.spawn_player(weapon, [])
		for kind in ["slime", "slime", "archer", "charger"]:
			w.spawn_enemy(kind, Vector2(100 + 140 * w.units.size(), 100))
		var bot = PlayerBot.new(style, weapon, seed_value)
		for i in 60 * 40:
			if not w.player.alive or w.foes_left() == 0:
				break
			w.step(bot.decide(w))
	return h.summary([])


func test_habits_reflect_play_style() -> bool:
	var roller := _record_habits("roller", "bow")
	var steady := _record_habits("steady", "bow")
	check(roller["dodge_per_min"] > steady["dodge_per_min"] * 2.0,
		"구르기 많은 봇의 구르기 기록이 훨씬 많아야: %.1f vs %.1f" % [roller["dodge_per_min"], steady["dodge_per_min"]])
	check(roller["pref_distance"] < steady["pref_distance"],
		"붙는 봇의 거리가 더 가까워야: %.0f vs %.0f" % [roller["pref_distance"], steady["pref_distance"]])
	check(roller["circle"] > 0.0 and steady["circle"] < 0.0,
		"도는 방향이 반대로 기록돼야: %.2f vs %.2f" % [roller["circle"], steady["circle"]])
	return true


## 메아리를 허수아비(원을 그리며 걷는 플레이어) 앞에 세워 행동을 잰다
func _echo_behavior(habits: Dictionary, weapon: String) -> Dictionary:
	var profile := Echo.make_profile(weapon, [], habits, 2, "dead")
	var w = World.new(4)
	var p = w.spawn_player("sword", [])
	p.hp = 1e9
	p.max_hp = 1e9
	var e = w.spawn_echo(profile)
	var dodges := 0
	var dist_sum := 0.0
	for i in 60 * 30:
		w.step({"move": Vector2(cos(i * 0.02), sin(i * 0.02)) * 0.6})
		for ev in w.events:
			if ev["kind"] == "dodge" and ev["unit"] == e.id:
				dodges += 1
		dist_sum += e.pos.distance_to(p.pos)
	return {"dodges": dodges, "distance": dist_sum / (60 * 30)}


func test_echo_follows_habits() -> bool:
	var roller := _record_habits("roller", "bow")
	var steady := _record_habits("steady", "bow")
	var er := _echo_behavior(roller, "bow")
	var es := _echo_behavior(steady, "bow")
	check(er["dodges"] > es["dodges"], "구르기 많은 나의 메아리가 더 많이 굴러야: %d vs %d" % [er["dodges"], es["dodges"]])
	check(er["distance"] < es["distance"], "붙는 나의 메아리가 더 가까이 붙어야: %.0f vs %.0f" % [er["distance"], es["distance"]])
	return true


func test_echo_copies_build() -> bool:
	var w = World.new(1)
	w.spawn_player("sword", [])
	var e = w.spawn_echo(Echo.make_profile("bow", ["spin", "sprint"], {}, 2, "dead"))
	check(e.weapon == "bow" and e.abilities == ["spin", "sprint"], "메아리는 내 무기·능력을 그대로 쓴다")
	check(is_equal_approx(e.speed, Data.PLAYER_SPEED * 1.25), "질주도 그대로")
	return true


func test_echo_copies_at_most_70_percent() -> bool:
	var extreme := {"pref_distance": 220.0, "dodge_reactive": 1.0, "dodge_per_min": 60.0, "circle": 1.0, "attack_per_min": 200.0}
	var bp := Echo.brain_params(extreme, "sword")
	check(bp["distance"] < 220.0 and bp["circle"] <= Data.ECHO_FIDELITY + 0.0001 and bp["reactive"] < 1.0,
		"극단적인 습관도 70%%까지만 따라 한다: %s" % [bp])
	return true


## 보스전: 봇이 여러 가지 "어제의 나"를 이길 수 있는가
func test_bot_can_beat_echoes() -> bool:
	var cases := [
		["tutorial", Echo.tutorial_profile()],
		["roller_bow", Echo.make_profile("bow", ["spin", "double_roll", "sprint"], _record_habits("roller", "bow"), 2, "dead")],
		["steady_sword", Echo.make_profile("sword", ["heavy", "thorns", "bloodthirst"], _record_habits("steady", "sword"), 2, "dead")],
	]
	var build := ["heavy", "sprint", "double_roll"]
	for c in cases:
		for seed_value in [1, 2, 3]:
			var w = World.new(seed_value)
			var p = w.spawn_player("sword", build)
			var echo = w.spawn_echo(c[1], Vector2(320, 80), seed_value)
			var bot = PlayerBot.new("reader", "sword", seed_value)
			while w.player.alive and w.foes_left() > 0 and w.frame < 60 * 180:
				w.step(bot.decide(w))
			var cleared: bool = w.foes_left() == 0 and w.player.alive
			print("RESULT_JSON:" + JSON.stringify({"boss": c[0], "seed": seed_value, "cleared": cleared,
				"time_s": snappedf(w.frame / 60.0, 0.01), "hp_lost": snappedf(Data.PLAYER_HP - maxf(p.hp, 0.0), 0.1),
				"echo_hp_left": snappedf(maxf(echo.hp, 0.0), 0.1)}))
			check(cleared, "%s seed=%d 를 못 이김" % [c[0], seed_value])
	return true
