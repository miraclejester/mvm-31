extends Node
class_name ActorController

signal action_just_released(action: String)
signal action_just_pressed(action: String)

@export var available_actions: Array[String]

var direction: Vector2 = Vector2.ZERO
var left_strength: float = 0
var right_strength: float = 0
var is_moving: bool = false
var action_dict: Dictionary[String, InputActionData] = {}

func _ready() -> void:
	for action in available_actions:
		action_dict[action] = InputActionData.new(action)


func _process(_delta: float) -> void:
	update_inputs()


func update_inputs() -> void:
	get_movement_input()
	for action in available_actions:
		get_action_data(action)
	if not (right_strength > 0 and left_strength > 0):
		direction.x = right_strength - left_strength
	is_moving = direction.x != 0


func is_action_just_pressed(action: String) -> bool:
	var data: InputActionData = action_dict.get(action)
	return data != null and data.just_pressed


func send_action_just_released(action: String) -> void:
	action_just_released.emit(action)


func send_action_just_pressed(action: String) -> void:
	action_just_pressed.emit(action)


func get_movement_input() -> void:
	pass

func get_action_data(_key: String) -> void:
	pass
