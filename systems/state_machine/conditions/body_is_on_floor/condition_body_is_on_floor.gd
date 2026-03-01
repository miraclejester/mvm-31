extends StateMachineCondition
class_name ConditionBodyIsOnFloor

@export var movement: ActorMovement

func evaluate() -> bool:
	return movement.is_considered_on_floor()
