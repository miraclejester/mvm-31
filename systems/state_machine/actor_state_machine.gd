extends Node
class_name ActorStateMachine

@export var initial_state: ActorState

@onready var any_state_transitions_parent: Node = %AnyStateTransitions

var current_state: ActorState = null
var any_transitions: Array[ActorStateTransition] = []

func _ready() -> void:
	set_process(false)
	set_physics_process(false)
	any_transitions.assign(any_state_transitions_parent.get_children())


func run() -> void:
	set_process(true)
	set_physics_process(true)
	enter_state(initial_state)


func _process(delta: float) -> void:
	current_state.run_on_process(delta)
	
	for transition in any_transitions:
		if transition.target_state != current_state and transition.evaluate():
			enter_state(transition.target_state)
			return
	
	var next_state = current_state.process_transitions()
	if next_state != null:
		enter_state(next_state)


func _physics_process(delta: float) -> void:
	current_state.run_on_physics_process(delta)


func enter_state(state: ActorState) -> void:
	if (current_state != null):
		current_state.run_on_exit(0)
	current_state = state
	print("Entered state %s" % state.name)
	current_state.run_on_enter(0)
