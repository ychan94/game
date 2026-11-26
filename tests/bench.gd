extends SceneTree
## 성능 측정판: 적이 가장 많은 장면을 시드 고정으로 재현한다. perf/bench.py 가 부른다.
##   godot --headless --path . --script res://tests/bench.gd -- run|profile
## 결과는 RESULT_JSON: 한 줄로 내보낸다.

const World = preload("res://src/core/world.gd")
const Echo = preload("res://src/core/echo.gd")

const SEED := 42
const FRAMES := 600
const WARMUP := 30
const HASH_EVERY := 30
const ENEMIES := {"slime": 60, "archer": 30, "charger": 30}  # 120마리 + 어제의 나


func _scripted_input(f: int) -> Dictionary:
	var a := f * 0.05
	return {"move": Vector2(cos(a), sin(a)), "aim": Vector2(cos(a * 2.0), sin(a * 2.0)),
		"attack": f % 15 == 0, "dodge": f % 120 == 0}


func _build() -> Object:
	var w = World.new(SEED)
	var p = w.spawn_player("bow", ["spin", "pierce", "double_roll"])
	p.hp = 1e9
	p.max_hp = 1e9
	var rng := RandomNumberGenerator.new()
	rng.seed = SEED
	for kind in ENEMIES:
		for i in ENEMIES[kind]:
			w.spawn_enemy(kind, Vector2(rng.randf_range(30, 610), rng.randf_range(30, 200)))
	w.spawn_echo(Echo.tutorial_profile(), Vector2(320, 60), SEED)
	return w


func _init() -> void:
	var mode: String = OS.get_cmdline_user_args()[0] if OS.get_cmdline_user_args().size() > 0 else "run"
	var w = _build()
	var sys_us := {}
	for s in World.SYSTEMS:
		sys_us[s] = []
	var frame_ms: Array = []
	var hashes: Array = []
	for f in FRAMES:
		w.inputs = _scripted_input(f)
		w.events.clear()
		var t0 := Time.get_ticks_usec()
		if mode == "profile":
			for s in World.SYSTEMS:
				var a := Time.get_ticks_usec()
				w.call(s)
				sys_us[s].append(Time.get_ticks_usec() - a)
			w.frame += 1
		else:
			w.step(_scripted_input(f))
		var dt := (Time.get_ticks_usec() - t0) / 1000.0
		if f >= WARMUP:
			frame_ms.append(dt)
		if f % HASH_EVERY == 0:
			hashes.append([f, w.state_hash(), w.foes_left()])
	var out := {"mode": mode, "seed": SEED, "frames": FRAMES, "enemies": ENEMIES, "frame_ms": frame_ms, "hashes": hashes}
	if mode == "profile":
		var prof := {}
		for s in sys_us:
			var v: Array = sys_us[s]
			var total := 0.0
			var mx := 0.0
			for x in v:
				total += x
				mx = maxf(mx, x)
			prof[s] = {"avg_ms": total / v.size() / 1000.0, "max_ms": mx / 1000.0, "total_ms": total / 1000.0}
		out["systems"] = prof
	print("RESULT_JSON:" + JSON.stringify(out))
	quit(0)
