extends ActorController
class_name PlayerController

func get_movement_input() -> void:
	left_strength = Input.get_action_strength("left")
	right_strength = Input.get_action_strength("right")

func get_action_data(key: String) -> void:
	var data: InputActionData = action_dict.get(key)
	if data != null:
		var prev_just_released: bool = data.just_released
		
		data.pressed = Input.is_action_pressed(key)
		data.just_pressed = Input.is_action_just_pressed(key)
		data.just_released = Input.is_action_just_released(key)
		
		if not prev_just_released and data.just_released:
			send_action_just_released(key)
