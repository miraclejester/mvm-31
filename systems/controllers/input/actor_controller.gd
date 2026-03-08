extends Node
class_name ActorController

static var MAX_BUFFER_TIME: float = 1

signal action_just_released(action: String)
signal action_just_pressed(action: String)
signal direct_action(action: String)

@export var available_actions: Array[String]
@export var external_input: bool = true
@export var direction_threshold: float = 0.01

var direction: Vector2 = Vector2.ZERO
var face_direction: Vector2 = Vector2.ZERO
var left_strength: float = 0
var right_strength: float = 0
var up_strength: float = 0
var down_strength: float = 0
var action_dict: Dictionary[String, InputActionData] = {}

func _ready() -> void:
	for action in available_actions:
		action_dict[action] = InputActionData.new(action)


func _process(delta: float) -> void:
	update_inputs(delta)


func update_inputs(delta: float) -> void:
	if external_input:
		set_movement_input(get_movement_input())
	for action in available_actions:
		get_action_data(action, delta)
	if not (right_strength > 0 and left_strength > 0):
		direction.x = right_strength - left_strength
	if not (up_strength > 0 and down_strength > 0):
		direction.y = down_strength - up_strength
	if direction.x != 0 or direction.y != 0:
		face_direction = direction


func is_action_just_pressed(action: String) -> bool:
	var data: InputActionData = action_dict.get(action)
	return data != null and data.just_pressed


func is_action_just_released(action: String) -> bool:
	var data: InputActionData = action_dict.get(action)
	return data != null and data.just_released


func is_action_pressed(action: String) -> bool:
	var data: InputActionData = action_dict.get(action)
	return data != null and data.pressed


func action_buffered(action: String, time: float) -> bool:
	var data: InputActionData = action_dict.get(action)
	return data != null and data.buffering and data.time_since_last_just_pressed <= time


func send_action_just_released(action: String) -> void:
	action_just_released.emit(action)


func send_action_just_pressed(action: String) -> void:
	action_just_pressed.emit(action)


func call_direct_action(action: String) -> void:
	direct_action.emit(action)


func set_movement_input(input: Vector2) -> void:
	right_strength = 1 if input.x > direction_threshold else 0
	left_strength = 1 if input.x < -direction_threshold else 0
	up_strength = 1 if input.y < -direction_threshold else 0
	down_strength = 1 if input.y > direction_threshold else 0


func get_movement_input() -> Vector2:
	return Vector2.ZERO

func get_action_data(_key: String, _delta: float) -> void:
	pass
