extends Node2D
class_name GameWorld

@export var player: Player
@export var world_data: GameWorldData

@onready var camera: Camera2D = %MainCamera
@onready var current_room_parent: Node2D = %CurrentRoomParent

var current_room: GameWorldRoom
var context: WorldContext

func _ready() -> void:
	context = WorldContext.from_data({
		"camera": camera,
		"player": player,
	})
	
	EventBroadcaster.projectile_shot.connect(on_projectile_shot)
	GameManager.current_world = self
	load_room(world_data.default_room)


func load_room(data: GameWorldRoomData, entrance_key: String = "") -> void:
	if current_room != null:
		current_room.queue_free()
		current_room_parent.remove_child(current_room)
	
	var room: GameWorldRoom = data.room_scene.instantiate() as GameWorldRoom
	current_room_parent.add_child(room)
	room.room_data = data
	
	room.initialize_room(context)
	if entrance_key.is_empty() or (not room.has_room_transition(entrance_key)):
		player.global_position = room.get_default_player_position()
	else:
		player.global_position = room.get_room_transition(entrance_key).get_entrance_point()
	current_room = room
	AudioManager.play_bgm(room.room_data.bgm_guid)


func execute_transition(key: String) -> void:
	for transition in world_data.transitions:
		if transition.room1 == current_room.room_data and transition.key1 == key:
			load_room(transition.room2, transition.key2)
			return
		elif transition.room2 == current_room.room_data and transition.key2 == key:
			load_room(transition.room1, transition.key1)
			return


func on_projectile_shot(data: ProjectileShotData) -> void:
	current_room.on_projectile_shot(data)
