extends BooleanParameterSetter
class_name ControllerParameterSetter

enum EActionModifier {
	Pressed,
	JustPressed
}

@export var controller: ActorController
@export var action_modifier: EActionModifier
@export var action: String

func get_value() -> Variant:
	match action_modifier:
		EActionModifier.Pressed:
			return controller.is_action_pressed(action)
		EActionModifier.JustPressed:
			return controller.is_action_just_pressed(action)
		_:
			return false
