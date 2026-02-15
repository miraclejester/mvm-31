extends StateMachineCondition
class_name ConditionNegate

var conditions: Array[StateMachineCondition] = []

func _ready() -> void:
	conditions.assign(get_children())


func evaluate(state_machine: ActorStateMachine) -> bool:
	for condition in conditions:
		if not condition.evaluate(state_machine):
			return true
	return false
