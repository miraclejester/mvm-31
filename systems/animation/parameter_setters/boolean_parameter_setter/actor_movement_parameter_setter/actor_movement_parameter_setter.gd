extends BooleanParameterSetter
class_name ActorMovementParameterSetter

enum EMovementParameter {
	ConsideredOnFloor
}

@export var movement: ActorMovement
@export var movement_parameter: EMovementParameter

func get_value() -> Variant:
	match movement_parameter:
		EMovementParameter.ConsideredOnFloor:
			return movement.is_considered_on_floor()
		_:
			return null
