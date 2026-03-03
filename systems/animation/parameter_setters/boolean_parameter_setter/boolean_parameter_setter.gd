extends ActorAnimatorParameterSetter
class_name BooleanParameterSetter

@export var negative_path: String
@export var send_negative: bool = true
@export var send_positive: bool = true

func set_parameter() -> void:
	if send_positive:
		super()
	if send_negative:
		animation_controller.set("parameters/%s" % negative_path, not get_value())
