extends SceneTree
## 장면별 스크린샷을 찍는다 (화면 확인용, 자동 테스트 아님).
##   xvfb-run -a godot --path . --rendering-driver opengl3 --script res://tests/screens.gd -- <저장 폴더>

const Save = preload("res://src/core/save.gd")
const PlayerBot = preload("res://tests/bots/player_bot.gd")

var main
var out_dir := ""


func _initialize() -> void:
	var args := OS.get_cmdline_user_args()
	out_dir = args[0] if args.size() > 0 else OS.get_user_data_dir()
	DirAccess.make_dir_recursive_absolute(out_dir)
	main = load("res://src/game/main.tscn").instantiate()
	root.add_child(main)
	create_timer(60.0).timeout.connect(func(): print("시간 초과"); quit(1))
	if main.get_script() == null or not main.has_method("_new_run"):
		print("main.gd 를 불러오지 못함")
		quit(1)
		return
	_shoot_all.call_deferred()


func _frames(n: int) -> void:
	for i in n:
		await process_frame


func _snap(name: String) -> void:
	await _frames(3)
	var img := root.get_viewport().get_texture().get_image()
	img.save_png(out_dir.path_join(name + ".png"))
	print("saved ", name)


func _drive(frames: int, bot) -> void:
	main.set_physics_process(false)
	for i in frames:
		if main.run.state != "room" and main.run.state != "echo":
			break
		main.run.step(bot.decide(main.run.world))
		main._collect_effects()
		main._tick_effects()
	main.queue_redraw()


func _shoot_all() -> void:
	main.save = Save.new()  # 저장 파일을 건드리지 않는다
	main._new_run()
	await _snap("01_start")
	main.run.start("sword")
	var bot = PlayerBot.new("reader", "sword", 3)
	await _drive(150, bot)
	await _snap("02_room")
	main.run.world.units = [main.run.world.player]
	main.run.step({})
	main.queue_redraw()
	await _snap("03_reward")
	main.run.choose(0)
	main.run.floor_no = 3
	main.run.room_no = 0
	main.run.state = "analysis"
	main.queue_redraw()
	await _snap("04_analysis")
	main.run.begin_echo_fight()
	await _drive(200, bot)
	await _snap("05_echo")
	main.run._end("dead")
	main.queue_redraw()
	await _snap("06_end")
	quit(0)
