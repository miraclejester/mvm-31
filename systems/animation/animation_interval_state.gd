extends RefCounted
class_name AnimationIntervalState

var pending_reset: bool
var action: String

func _init(a: String) -> void:
	pending_reset = false
	action = a
