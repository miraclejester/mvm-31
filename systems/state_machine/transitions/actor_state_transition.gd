extends Node
class_name ActorStateTransition

@export var target_state: ActorState

var conditions: Array[StateMachineCondition] = []

func _ready() -> void:
	conditions.assign(get_children())
	

func evaluate(state_machine: ActorStateMachine) -> bool:
	for condition in conditions:
		if not condition.evaluate(state_machine):
			return false
	return true
