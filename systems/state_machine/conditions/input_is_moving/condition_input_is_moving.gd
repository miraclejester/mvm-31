extends StateMachineCondition
class_name ConditionInputIsMoving

@export var controller: ActorController

func evaluate(_state_machine: ActorStateMachine) -> bool:
	return controller.is_moving
