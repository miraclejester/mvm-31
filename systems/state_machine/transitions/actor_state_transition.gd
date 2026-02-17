extends Node
class_name ActorStateTransition

@export var target_state: ActorState

var conditions: Array[StateMachineCondition] = []

func _ready() -> void:
	conditions.assign(get_children())


func state_entered() -> void:
	for condition in conditions:
		condition.state_entered()


func state_exited() -> void:
	for condition in conditions:
		condition.state_exited()


func state_processed(delta: float) -> void:
	for condition in conditions:
		condition.state_processed(delta)


func evaluate() -> bool:
	for condition in conditions:
		if not condition.evaluate():
			return false
	return true
