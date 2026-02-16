extends Node2D
class_name ParallaxBackgroundController

var layers: Array[Parallax2D] = []

func _ready() -> void:
	layers.assign(get_children())


func set_limits(bounds: Rect2i) -> void:
	for layer in layers:
		layer.limit_begin = Vector2(
			bounds.position.x, bounds.position.y
		)
		layer.limit_end = Vector2(
			bounds.position.x + bounds.size.x,
			bounds.position.y + bounds.size.y
		)
