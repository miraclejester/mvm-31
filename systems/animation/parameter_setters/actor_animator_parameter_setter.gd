extends Node
class_name ActorAnimatorParameterSetter

@export var parameter_path: String
@export var is_trigger: bool = false
@export var setter_key: String = ""

var animation_controller: ActorAnimationController

func get_value() -> Variant:
	return null


func set_parameter() -> void:
	animation_controller.set("parameters/%s" % parameter_path, get_value())


func set_trigger() -> void:
	animation_controller.set("parameters/%s" % parameter_path, true)


func reset_trigger() -> void:
	animation_controller.set("parameters/%s" % parameter_path, false)
