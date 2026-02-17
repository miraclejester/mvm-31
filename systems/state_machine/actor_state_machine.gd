extends Node
class_name ActorStateMachine

@export var initial_state: ActorState

var current_state: ActorState = null

func _ready() -> void:
	set_process(false)
	set_physics_process(false)


func run() -> void:
	set_process(true)
	set_physics_process(true)
	enter_state(initial_state)


func _process(delta: float) -> void:
	current_state.run_on_process(delta)
	var next_state = current_state.process_transitions()
	if next_state != null:
		enter_state(next_state)


func _physics_process(delta: float) -> void:
	current_state.run_on_physics_process(delta)


func enter_state(state: ActorState) -> void:
	if (current_state != null):
		current_state.run_on_exit(0)
	current_state = state
	current_state.run_on_enter(0)
