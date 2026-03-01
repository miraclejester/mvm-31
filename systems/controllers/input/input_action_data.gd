extends RefCounted
class_name InputActionData

var key: String
var pressed: bool
var just_pressed: bool
var just_released: bool
var time_since_last_just_pressed: float
var buffering: bool = false

func _init(k: String) -> void:
	key = k
	pressed = false
	just_pressed = false
	just_released = false
	time_since_last_just_pressed = 0
	buffering = false
