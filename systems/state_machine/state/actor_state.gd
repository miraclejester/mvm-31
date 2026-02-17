extends Node
class_name ActorState

@onready var on_enter_parent: Node = %OnEnter
@onready var on_exit_parent: Node = %OnExit
@onready var on_process_parent: Node = %OnProcess
@onready var on_physics_process_parent: Node = %OnPhysicsProcess
@onready var transitions_parent: Node = %Transitions

var on_enter: ActorBehaviour
var on_exit: ActorBehaviour
var on_process: ActorBehaviour
var on_physics_process: ActorBehaviour
var transitions: Array[ActorStateTransition] = []

func _ready() -> void:
	on_enter = get_actor_behaviour(on_enter_parent)
	on_exit = get_actor_behaviour(on_exit_parent)
	on_process = get_actor_behaviour(on_process_parent)
	on_physics_process = get_actor_behaviour(on_physics_process_parent)
	transitions.assign(transitions_parent.get_children())


func process_transitions() -> ActorState:
	for transition in transitions:
		if transition.evaluate():
			return transition.target_state
	return null


func get_actor_behaviour(target_parent: Node) -> ActorBehaviour:
	if target_parent.get_child_count() < 1:
		return null
	return target_parent.get_child(0) as ActorBehaviour


func run_behaviour(behaviour: ActorBehaviour, delta: float) -> void:
	if behaviour != null:
		behaviour.run(delta)

func run_on_enter(delta: float) -> void:
	for transition in transitions:
		transition.state_entered()
	run_behaviour(on_enter, delta)

func run_on_exit(delta: float) -> void:
	for transition in transitions:
		transition.state_exited()
	run_behaviour(on_exit, delta)

func run_on_process(delta: float) -> void:
	for transition in transitions:
		transition.state_processed(delta)
	run_behaviour(on_process, delta)

func run_on_physics_process(delta: float) -> void:
	run_behaviour(on_physics_process, delta)
