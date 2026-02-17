extends StateMachineCondition
class_name ConditionExternal

@export var condition: StateMachineCondition

func state_entered() -> void:
	condition.state_entered()


func state_exited() -> void:
	condition.state_exited()


func state_processed(delta: float) -> void:
	condition.state_processed(delta)


func evaluate() -> bool:
	return condition.evaluate()
