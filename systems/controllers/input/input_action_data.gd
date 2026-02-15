extends RefCounted
class_name InputActionData

var key: String
var pressed: bool
var just_pressed: bool
var just_released: bool

func _init(k: String) -> void:
	key = k
	pressed = false
	just_pressed = false
	just_released = false
