extends Node2D
class_name GameWorldRoom

@onready var camera_bounds: BoundsRect = %CameraBounds
@onready var layers_parent: Node2D = %MapLayers
@onready var projectile_parent: Node2D = %ProjectilesParent
@onready var player_spawn: Marker2D = %PlayerSpawn
@onready var transitions_parent: Node2D = %Transitions

var map_layers: Dictionary[String, TileMapLayer] = {}
var transitions: Dictionary[String, RoomTransition] = {}
var room_data: GameWorldRoomData

func _ready() -> void:
	for child in layers_parent.get_children():
		map_layers[child.name] = child as TileMapLayer
	for child in transitions_parent.get_children():
		var t: RoomTransition = child as RoomTransition
		transitions[t.key] = t


func initialize_room(context: WorldContext) -> void:
	var camera: Camera2D = context.camera
	var bounds: Rect2i = camera_bounds.get_bounds()
	camera.limit_left = bounds.position.x
	camera.limit_right = bounds.position.x + bounds.size.x
	camera.limit_top = bounds.position.y
	camera.limit_bottom = bounds.position.y + bounds.size.y


func get_map_layer(key: String) -> TileMapLayer:
	return map_layers.get(key)


func get_room_transition(key: String) -> RoomTransition:
	return transitions.get(key)


func has_room_transition(key: String) -> bool:
	return transitions.has(key)


func get_default_player_position() -> Vector2:
	return player_spawn.global_position


func on_projectile_shot(data: ProjectileShotData) -> void:
	projectile_parent.add_child(data.projectile)
	data.projectile.global_position = data.position
