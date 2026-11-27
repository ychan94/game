extends "res://src/game/proto_base.gd"
## 첫 화면: 1분 시험판 고르기


func _physics_process(_d: float) -> void:
	if pressed(KEY_1) or clicked("kiln"):
		get_tree().change_scene_to_file("res://src/game/kiln_scene.tscn")
	elif pressed(KEY_2) or clicked("nest"):
		get_tree().change_scene_to_file("res://src/game/nest_scene.tscn")
	elif pressed(KEY_3) or clicked("old"):
		get_tree().change_scene_to_file("res://src/game/main.tscn")
	tick_fx()
	queue_redraw()
	end_input()


func _draw() -> void:
	buttons.clear()
	draw_rect(Rect2(Vector2.ZERO, VIEW), C["bg"])
	text(Vector2(0, 70), "1분 시험판", C["accent"], 36, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	text(Vector2(0, 100), "두 가지만 봐 주세요:  ① '한 번 더' 하고 싶은가?   ② 쓸어버릴 때 시원한가?", C["dim"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
	view_style = "kiln"
	draw_ally_shape(Vector2(200, 170), "spear", "fire", "legend", 2.0)
	button(Rect2(110, 220, 180, 34), "[1]  가마의 병사", "kiln")
	text(Vector2(80, 276), "흙 병사를 빚고, 불을 올려 굽고,\n가마를 열어 마을을 지킨다", C["dim"], 12, 240.0, HORIZONTAL_ALIGNMENT_CENTER)
	view_style = "nest"
	draw_ally_shape(Vector2(440, 170), "shield", "water", "fine", 2.0)
	button(Rect2(350, 220, 180, 34), "[2]  알을 품는 성", "nest")
	text(Vector2(320, 276), "알을 데워 괴수를 깨우고,\n밤에 둥지를 지킨다", C["dim"], 12, 240.0, HORIZONTAL_ALIGNMENT_CENTER)
	button(Rect2(250, 340, 140, 24), "[3]  지난 시험판", "old", C["dim"])
	text(Vector2(0, 390), "어디서나 Esc = 이 화면", C["dim"], 12, 640.0, HORIZONTAL_ALIGNMENT_CENTER)
