extends StateMachineCondition
class_name InputActionJustReleased

@export var controller: ActorController
@export var key: String

func evaluate() -> bool:
	return controller.is_action_just_released(key)
