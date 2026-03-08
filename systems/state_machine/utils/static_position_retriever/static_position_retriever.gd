extends Node
class_name StaticPositionRetriever

@export var target: Node2D

var cached_position: Vector2

func _ready() -> void:
	cached_position = target.global_position


func get_cached_position() -> Vector2:
	return cached_position
