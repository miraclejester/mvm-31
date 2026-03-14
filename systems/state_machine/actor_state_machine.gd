extends Node
class_name ActorStateMachine

@export var initial_state: ActorState
@export var debug_logs: bool = false

@onready var states_parent: Node = %States
@onready var any_state_transitions_parent: Node = %AnyStateTransitions

var current_state: ActorState = null
var any_transitions: Array[ActorStateTransition] = []
var state_dict: Dictionary[String, ActorState] = {}

func _ready() -> void:
	set_process(false)
	set_physics_process(false)
	any_transitions.assign(any_state_transitions_parent.get_children())
	for child in states_parent.get_children():
		var s: ActorState = child as ActorState
		state_dict.set(s.name, s)
	


func run() -> void:
	set_process(true)
	set_physics_process(true)
	enter_state(initial_state)


func _process(delta: float) -> void:
	if current_state == null:
		return
	current_state.run_on_process(delta)
	
	for transition in any_transitions:
		if transition.target_state != current_state and transition.evaluate():
			enter_state(transition.target_state)
			return
	
	var next_state = current_state.process_transitions()
	if next_state != null:
		enter_state(next_state)


func _physics_process(delta: float) -> void:
	if current_state == null:
		return
	current_state.run_on_physics_process(delta)


func enter_state(state: ActorState) -> void:
	if state == null:
		return
	if not state.can_enter_state():
		return
	if (current_state != null):
		current_state.run_on_exit(0)
		for transition in any_transitions:
			transition.state_exited()
	current_state = state	
	if debug_logs:
		print("Entered state %s" % state.name)
	current_state.run_on_enter(0)
	for transition in any_transitions:
		transition.state_entered()


func enter_state_by_name(state_name: String) -> void:
	var state: ActorState = state_dict.get(state_name, null)
	enter_state(state)
