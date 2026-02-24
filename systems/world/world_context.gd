extends RefCounted
class_name WorldContext

var camera: Camera2D
var player: Player

static func from_data(data: Dictionary) -> WorldContext:
	var res = WorldContext.new()
	res.camera = data.get("camera")
	res.player = data.get("player")
	return res
