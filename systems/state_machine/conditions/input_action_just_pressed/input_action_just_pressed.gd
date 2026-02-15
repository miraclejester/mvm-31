extends StateMachineCondition
class_name InputActionJustPressed

@export var controller: ActorController
@export var key: String

func evaluate(_state_machine: ActorStateMachine) -> bool:
	return controller.is_action_just_pressed(key)
