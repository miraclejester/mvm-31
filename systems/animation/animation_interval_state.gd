extends RefCounted
class_name AnimationIntervalState

var pending_reset: bool
var data: AnimationIntervalData

func _init(d: AnimationIntervalData) -> void:
	pending_reset = false
	data = d
