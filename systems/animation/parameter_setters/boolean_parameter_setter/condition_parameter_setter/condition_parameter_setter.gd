extends BooleanParameterSetter
class_name ConditionParameterSetter

var condition: StateMachineCondition

func _ready() -> void:
	condition = get_child(0) as StateMachineCondition

func get_value() -> Variant:
	return condition.evaluate()
