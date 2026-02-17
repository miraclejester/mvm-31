extends Node2D
class_name WorldRoom

signal doorway_triggered(data: DoorwayData)

@onready var map_parent: Node2D = %Map
@onready var background_parent: Node2D = %Background
@onready var doorway_parent: Node2D = %Doorways
@onready var projectile_parent: Node2D = %Projectiles

var current_context: WorldContext
var level_layer: TileMapLayer
var room_bounds: Rect2i
var current_map: Node2D
var spawn_points: Dictionary[String, Vector2] = {}


func initialize(data: WorldRoomData, context: WorldContext) -> void:
	current_context = context
	load_room(data)
	load_background(data)
	process_spawn_points(current_map.get_node("spawn_points"))
	process_doorways()
	clear_objects()
	context.player.global_position = spawn_points.get(context.spawn)


func load_room(data: WorldRoomData) -> void:
	if map_parent.get_child_count() >= 1:
		var old_room: Node2D = map_parent.get_child(0)
		old_room.queue_free()
		map_parent.remove_child(old_room)
	var map_node: Node2D = data.room_scene.instantiate() as Node2D
	level_layer = map_node.get_node("level") as TileMapLayer
	calculate_room_bounds()
	map_parent.add_child(map_node)
	current_map = map_node
	
	current_context.camera.limit_left = room_bounds.position.x
	current_context.camera.limit_right = room_bounds.position.x + room_bounds.size.x
	current_context.camera.limit_top = room_bounds.position.y
	current_context.camera.limit_bottom = room_bounds.position.y + room_bounds.size.y


func calculate_room_bounds() -> void:
	var used_rect: Rect2i = level_layer.get_used_rect()
	var tile_size: int = level_layer.tile_set.tile_size.x
	room_bounds = Rect2i(int(global_position.x), int(global_position.y), used_rect.size.x * tile_size, used_rect.size.y * tile_size)


func load_background(data: WorldRoomData) -> void:
	if background_parent.get_child_count() > 1:
		var old_bg: Node2D = background_parent.get_child(0)
		old_bg.queue_free()
		background_parent.remove_child(old_bg)
	var bg: ParallaxBackgroundController = data.background_scene.instantiate() as ParallaxBackgroundController
	background_parent.add_child(bg)
	#bg.set_limits(room_bounds)


func process_spawn_points(spawn_point_parent: Node2D) -> void:
	spawn_points.clear()
	var nodes: Array[Node2D] = []
	nodes.assign(spawn_point_parent.get_children())
	for node in nodes:
		spawn_points.set(node.name, node.global_position)


func process_doorways() -> void:
	var doorway_scene: PackedScene = load("res://systems/interactables/doorways/doorway.tscn")
	for child in doorway_parent.get_children():
		child.queue_free()
	
	var doorway_node: Node2D = current_map.get_node("doorways")
	for child in doorway_node.get_children():
		var doorway: Doorway = doorway_scene.instantiate() as Doorway
		var data: DoorwayData = DoorwayData.new()
		data.target_room = load("res://maps/map_list/%s.tres" % child.get_meta("target_room"))
		data.target_spawn_point = child.get_meta("target_spawn_point")
		doorway.initialize(data)
		doorway_parent.call_deferred("add_child", doorway)
		doorway.global_position = (child as Node2D).global_position
		
		doorway.door_triggered.connect(on_doorway_triggered)


func on_doorway_triggered(data: DoorwayData) -> void:
	doorway_triggered.emit(data)


func on_projectile_shot(data: ProjectileShotData) -> void:
	projectile_parent.add_child(data.projectile)
	data.projectile.global_position = data.position


func clear_objects() -> void:
	for child in projectile_parent.get_children():
		child.queue_free()
