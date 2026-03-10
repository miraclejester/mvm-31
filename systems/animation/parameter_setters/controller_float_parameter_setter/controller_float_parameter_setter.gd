extends ActorAnimatorParameterSetter
class_name ControllerFloatParameterSetter

enum EControllerOperation {
	Direction
}

@export var controller: ActorController
@export var operation: EControllerOperation

func get_value() -> Variant:
	match operation:
		EControllerOperation.Direction:
			return controller.direction.length()
	return null
