extends StateMachineCondition
class_name ConditionBodyIsOnFloor

@export var body: CharacterBody2D

func evaluate() -> bool:
	return body.is_on_floor()
