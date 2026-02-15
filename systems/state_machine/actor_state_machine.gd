extends Node
class_name ActorStateMachine

@export var initial_state: ActorState

var current_state: ActorState = null
var context: Variant = null

func _ready() -> void:
	set_process(false)
	set_physics_process(false)


func run() -> void:
	set_process(true)
	set_physics_process(true)
	enter_state(initial_state)


func _process(delta: float) -> void:
	current_state.on_process(self, delta)
	var next_state = current_state.process_transitions(self)
	if next_state != null:
		enter_state(next_state)


func _physics_process(delta: float) -> void:
	current_state.on_physics_process(self, delta)


func enter_state(state: ActorState) -> void:
	if (current_state != null):
		current_state.on_exit(self)
	current_state = state
	current_state.on_enter(self)
