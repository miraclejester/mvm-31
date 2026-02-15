extends CharacterBody2D
class_name PlayerStateMachine

@export var initial_state: PlayerState

@onready var animations: AnimatedSprite2D = %Animations
@onready var states_parent: Node = %States

var states: Dictionary[String, PlayerState] = {}
var current_state: PlayerState = null

func _ready() -> void:
	init_state_machine()
	enter_state(initial_state)


func _process(delta: float) -> void:
	current_state.on_process(self, delta)


func _physics_process(delta: float) -> void:
	current_state.on_physics_process(self, delta)


func init_state_machine() -> void:
	var state_list: Array[PlayerState] = []
	state_list.assign(states_parent.get_children())
	for state in state_list:
		states.set(state.state_id, state)


func enter_state(state: PlayerState) -> void:
	if (current_state != null):
		current_state.on_exit(self)
	current_state = state
	current_state.on_enter(self)

#
