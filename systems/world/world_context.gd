extends RefCounted
class_name WorldContext

var camera: Camera2D
var player: Player
var spawn: String
var world_data: WorldData
var world_content: Node2D

static func from_data(data: Dictionary) -> WorldContext:
	var res = WorldContext.new()
	res.camera = data.get("camera")
	res.player = data.get("player")
	res.spawn = data.get("spawn")
	res.world_data = data.get("world_data")
	res.world_content = data.get("world_content")
	return res
