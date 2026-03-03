extends ActorAnimatorParameterSetter
class_name BodyVelocityParameterSetter

enum EVelocityAxis { X, Y}
enum EOperation { None, Abs, Sign }

@export var body: CharacterBody2D
@export var axis: EVelocityAxis
@export var operation: EOperation

func get_value() -> Variant:
	var axis_value: float = body.velocity.x if axis == EVelocityAxis.X else body.velocity.y
	match operation:
		EOperation.Abs:
			axis_value = abs(axis_value)
		EOperation.Sign:
			axis_value = sign(axis_value)
		_:
			pass
	return axis_value
