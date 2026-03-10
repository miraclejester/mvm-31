extends ActorAnimatorParameterSetter
class_name BodyVelocityParameterSetter

enum EVelocityAxis { X, Y, Both }
enum EOperation { None, Abs, Sign }

@export var body: CharacterBody2D
@export var axis: EVelocityAxis
@export var operation: EOperation

func get_value() -> Variant:
	var axis_value: float = 0
	match axis:
		EVelocityAxis.X:
			axis_value = body.velocity.x
		EVelocityAxis.Y:
			axis_value = body.velocity.y
		EVelocityAxis.Both:
			axis_value = body.velocity.length()
	match operation:
		EOperation.Abs:
			axis_value = abs(axis_value)
		EOperation.Sign:
			axis_value = sign(axis_value)
		_:
			pass
	return axis_value
