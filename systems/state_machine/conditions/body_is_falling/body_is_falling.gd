extends StateMachineCondition
class_name BodyIsFalling

@export var body: CharacterBody2D

func evaluate(_state_machine: ActorStateMachine) -> bool:
	return (not body.is_on_floor()) and body.velocity.y >= 0
