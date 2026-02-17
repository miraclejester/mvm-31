extends Node
class_name ActorController

signal action_just_released(action: String)
signal action_just_pressed(action: String)

@export var available_actions: Array[String]

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


func _process(_delta: float) -> void:
	update_inputs()


func update_inputs() -> void:
	get_movement_input()
	for action in available_actions:
		get_action_data(action)
	if not (right_strength > 0 and left_strength > 0):
		direction.x = right_strength - left_strength
	if not (up_strength > 0 and down_strength > 0):
		direction.y = down_strength - up_strength
	if direction.x != 0 or direction.y != 0:
		face_direction = direction


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
