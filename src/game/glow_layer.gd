extends Node2D
## 그리기 층 하나. 주인(host)의 draw_layer(이 층, mode) 가 실제로 그린다.
##   bg    : 전장 바닥 (픽셀, 캐릭터 뒤)
##   back  : 그림자·뒷빛·낮은 안개 (부드럽게, 캐릭터 뒤)
##   glow  : 불빛·섬광 (빛을 더하는 가산 혼합, 캐릭터 앞)
##   front : 앞 안개·밤 색감·가장자리 어둡게 (부드럽게, 캐릭터 앞)

var host = null
var mode := "glow"


func setup(owner_node, layer_mode: String) -> void:
	host = owner_node
	mode = layer_mode
	match mode:
		"bg":
			z_index = -2
		"back":
			z_index = -1
			texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
		"glow":
			z_index = 1
			texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
			var m := CanvasItemMaterial.new()
			m.blend_mode = CanvasItemMaterial.BLEND_MODE_ADD
			material = m
		"front":
			z_index = 2
			texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR


func _process(_d: float) -> void:
	queue_redraw()


func _draw() -> void:
	if host != null and host.has_method("draw_layer"):
		host.draw_layer(self, mode)
