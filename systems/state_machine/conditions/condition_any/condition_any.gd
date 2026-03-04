extends StateMachineCondition
class_name ConditionAny

var conditions: Array[StateMachineCondition]

func _ready() -> void:
	conditions.assign(get_children())


func evaluate() -> bool:
	if conditions.is_empty():
		return true
	for condition in conditions:
		if condition.evaluate():
			return true
	return false
