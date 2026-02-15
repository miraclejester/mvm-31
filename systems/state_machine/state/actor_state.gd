@abstract
extends Node
class_name ActorState

var transitions: Array[ActorStateTransition] = []

func _ready() -> void:
	transitions.assign(get_children())


func process_transitions(state_machine: ActorStateMachine) -> ActorState:
	for transition in transitions:
		if transition.evaluate(state_machine):
			return transition.target_state
	return null


func on_enter(_state_machine: ActorStateMachine) -> void:
	pass


func on_exit(_state_machine: ActorStateMachine) -> void:
	pass


func on_process(_state_machine: ActorStateMachine, _delta: float) -> void:
	pass


func on_physics_process(_state_machine: ActorStateMachine, _delta: float) -> void:
	pass
