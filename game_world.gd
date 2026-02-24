extends Node2D
class_name GameWorld

@export var player: Player

@onready var current_room: GameWorldRoom = %GameWorldRoom
@onready var camera: Camera2D = %MainCamera

func _ready() -> void:
	var context: WorldContext = WorldContext.from_data({
		"camera": camera,
		"player": player,
		"spawn": "initial_spawn"
	})
	current_room.initialize_room(context)
	EventBroadcaster.projectile_shot.connect(on_projectile_shot)
	GameManager.current_world = self


func enter_doorway(data: DoorwayData) -> void:
	current_room.initialize_room(WorldContext.from_data({
		"camera": camera,
		"player": player,
		"spawn": data.target_spawn_point
	}))


func on_projectile_shot(data: ProjectileShotData) -> void:
	current_room.on_projectile_shot(data)
