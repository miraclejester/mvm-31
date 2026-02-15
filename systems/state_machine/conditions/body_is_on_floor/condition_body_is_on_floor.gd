extends StateMachineCondition
class_name ConditionBodyIsOnFloor

@export var body: CharacterBody2D

func evaluate(_state_machine: ActorStateMachine) -> bool:
	return body.is_on_floor()
