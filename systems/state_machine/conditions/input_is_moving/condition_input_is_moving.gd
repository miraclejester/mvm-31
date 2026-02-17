extends StateMachineCondition
class_name ConditionInputIsMoving

@export var controller: ActorController

func evaluate() -> bool:
	return controller.is_moving
