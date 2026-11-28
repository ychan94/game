extends Node2D
## 시작: 이제 게임은 '가마의 병사' 하나 (사용자: "게임은 가마 병사만 하고 알 관련 게임은 없이")
## 지난 시험판(AFTERSELF, src/core)은 보류 — 첫 화면에서 뺐다.


func _ready() -> void:
	get_tree().change_scene_to_file.call_deferred("res://src/game/kiln_scene.tscn")
