extends Node2D
class_name GameWorld

@export var world_data: WorldData
@export var player: Player

@onready var current_room: WorldRoom = %CurrentRoom
@onready var camera: Camera2D = %MainCamera

func _ready() -> void:
	var context: WorldContext = WorldContext.from_data({
		"camera": camera,
		"player": player,
		"spawn": "initial_spawn"
	})
	current_room.initialize(world_data.default_starting_room, context)
	
	current_room.doorway_triggered.connect(enter_doorway)
	EventBroadcaster.projectile_shot.connect(on_projectile_shot)


func enter_doorway(data: DoorwayData) -> void:
	current_room.initialize(data.target_room, WorldContext.from_data({
		"camera": camera,
		"player": player,
		"spawn": data.target_spawn_point
	}))


func on_projectile_shot(data: ProjectileShotData) -> void:
	current_room.on_projectile_shot(data)
