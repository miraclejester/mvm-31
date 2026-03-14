extends Node
class_name StaticPositionRetriever

@export var target: Node2D

var cached_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	if target == null:
		return
	cached_position = target.global_position


func get_cached_position() -> Vector2:
	return cached_position
