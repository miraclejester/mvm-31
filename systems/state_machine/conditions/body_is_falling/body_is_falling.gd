extends StateMachineCondition
class_name BodyIsFalling

@export var body: CharacterBody2D

func evaluate() -> bool:
	return (not body.is_on_floor()) and body.velocity.y >= 0
