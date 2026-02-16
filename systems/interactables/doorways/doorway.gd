extends Area2D
class_name Doorway

signal door_triggered(data: DoorwayData)

@export var target_map: PackedScene
@export var target_spawn_point: String

var data: DoorwayData

func initialize(d: DoorwayData) -> void:
	data = d

func trigger_door() -> void:
	door_triggered.emit(data)
