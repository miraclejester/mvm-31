extends Area2D
class_name RoomTransition



@export var key: String

@onready var entrance: Marker2D = %Entrance


func get_entrance_point() -> Vector2:
	return entrance.global_position


func execute_transition() -> void:
	GameManager.current_world.execute_transition(key)
