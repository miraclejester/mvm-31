@tool
extends Marker2D
class_name BoundsRect

@export var debug_color: Color = Color.RED

@onready var bottom_right: Marker2D = %BottomRightCorner

func get_bounds() -> Rect2i:
	var width: int = roundi(bottom_right.global_position.x - global_position.x)
	var height: int = roundi(bottom_right.global_position.y - global_position.y)
	return Rect2i(roundi(global_position.x), roundi(global_position.y), width, height)


func _process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		return
	queue_redraw()


func _draw():
	if (Engine.is_editor_hint()):
		draw_rect(get_bounds(), debug_color)
