extends Node2D
class_name GameWorld

signal room_load_started(next_room: GameWorldRoomData)
signal current_room_set(room: GameWorldRoomData)
signal entered_water()
signal exited_water()

@export var player: WorldCharacter
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
	GameManager.set_world(self)
	load_room(GameManager.get_current_saved_room())


func stop_time() -> void:
	current_room_parent.process_mode = Node.PROCESS_MODE_PAUSABLE
	get_tree().paused = true


func continue_time() -> void:
	current_room_parent.process_mode = Node.PROCESS_MODE_INHERIT
	get_tree().paused = false


func load_room(data: GameWorldRoomData, entrance_key: String = "") -> void:
	if current_room != null:
		current_room.queue_free()
		current_room_parent.remove_child(current_room)
	
	room_load_started.emit(data)
	var room: GameWorldRoom = data.room_scene.instantiate() as GameWorldRoom
	current_room_parent.add_child(room)
	room.room_data = data
	
	room.initialize_room(context)
	if entrance_key.is_empty() or (not room.has_room_transition(entrance_key)):
		player.global_position = room.get_default_player_position()
	else:
		player.global_position = room.get_room_transition(entrance_key).get_entrance_point()
	camera.global_position = player.global_position
	camera.reset_smoothing()
	current_room = room
	current_room_set.emit(data)
	AudioManager.play_bgm(room.room_data.bgm_key)


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


func send_entered_water() -> void:
	entered_water.emit()


func send_exited_water() -> void:
	exited_water.emit()
