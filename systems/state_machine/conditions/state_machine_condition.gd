extends Node
class_name StateMachineCondition

func evaluate() -> bool:
	return true

func state_entered() -> void:
	pass

func state_processed(_delta: float) -> void:
	pass

func state_exited() -> void:
	pass
