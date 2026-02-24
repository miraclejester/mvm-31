extends Node2D
class_name GameWorldRoom

@onready var camera_bounds: BoundsRect = %CameraBounds
@onready var layers_parent: Node2D = %MapLayers
@onready var projectile_parent: Node2D = %ProjectilesParent

var map_layers: Dictionary[String, TileMapLayer] = {}

func _ready() -> void:
	for child in layers_parent.get_children():
		map_layers[child.name] = child as TileMapLayer


func initialize_room(context: WorldContext) -> void:
	var camera: Camera2D = context.camera
	var bounds: Rect2i = camera_bounds.get_bounds()
	camera.limit_left = bounds.position.x
	camera.limit_right = bounds.position.x + bounds.size.x
	camera.limit_top = bounds.position.y
	camera.limit_bottom = bounds.position.y + bounds.size.y


func get_map_layer(key: String) -> TileMapLayer:
	return map_layers.get(key)

func on_projectile_shot(data: ProjectileShotData) -> void:
	projectile_parent.add_child(data.projectile)
	data.projectile.global_position = data.position
