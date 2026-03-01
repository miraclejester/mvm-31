extends StateMachineCondition
class_name InputActionPressed

@export var controller: ActorController
@export var key: String

func evaluate() -> bool:
	return controller.is_action_pressed(key)
