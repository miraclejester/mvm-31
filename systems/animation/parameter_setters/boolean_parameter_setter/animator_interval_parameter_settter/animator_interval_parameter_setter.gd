extends BooleanParameterSetter
class_name AnimatorIntervalParameterSetter

@export var interval_key: String

func get_value() -> Variant:
	return animation_controller.is_interval_active(interval_key)
