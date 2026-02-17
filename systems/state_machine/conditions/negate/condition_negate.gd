extends StateMachineCondition
class_name ConditionNegate

var conditions: Array[StateMachineCondition] = []

func _ready() -> void:
	conditions.assign(get_children())


func evaluate() -> bool:
	for condition in conditions:
		if not condition.evaluate():
			return true
	return false
