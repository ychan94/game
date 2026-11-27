extends Node2D
## 빛 층: 이 층에 그린 것은 '빛을 더하는'(가산 혼합) 방식으로 섞인다. 겹칠수록 밝아져 진짜 빛처럼 보인다.
## 실제 그리기는 주인(host)의 draw_glow(이 층) 이 한다.

var host = null


func _ready() -> void:
	var m := CanvasItemMaterial.new()
	m.blend_mode = CanvasItemMaterial.BLEND_MODE_ADD
	material = m


func _process(_d: float) -> void:
	queue_redraw()


func _draw() -> void:
	if host != null and host.has_method("draw_glow"):
		host.draw_glow(self)
