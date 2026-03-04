extends ActorController
class_name PlayerController

func get_movement_input() -> Vector2:
	return Input.get_vector("left", "right", "up", "down")

func get_action_data(key: String, delta: float) -> void:
	var data: InputActionData = action_dict.get(key)
	if data != null:
		data.pressed = Input.is_action_pressed(key)
		data.just_pressed = Input.is_action_just_pressed(key)
		data.just_released = Input.is_action_just_released(key)
		
		if data.just_released:
			data.buffering = false
			data.time_since_last_just_pressed = 0
			send_action_just_released(key)
		if data.just_pressed:
			data.time_since_last_just_pressed = 0
			data.buffering = true
			send_action_just_pressed(key)
		else:
			data.time_since_last_just_pressed += delta
			if data.time_since_last_just_pressed > MAX_BUFFER_TIME:
				data.buffering = false
				data.time_since_last_just_pressed = 0
