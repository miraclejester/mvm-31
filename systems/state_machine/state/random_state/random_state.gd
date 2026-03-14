extends ActorState
class_name RandomState

@onready var states_parent: Node = %States

var possible_states: Array[ActorState] = []
var current_state: ActorState

func _ready() -> void:
	super()
	possible_states.assign(states_parent.get_children())


func select_state() -> void:
	current_state = possible_states.pick_random()


func process_transitions() -> ActorState:
	var top_level: ActorState = super()
	if top_level != null:
		return top_level
	return current_state.process_transitions()


func run_on_enter(delta: float) -> void:
	super(delta)
	select_state()
	current_state.run_on_enter(delta)


func run_on_exit(delta: float) -> void:
	current_state.run_on_exit(delta)

func run_on_process(delta: float) -> void:
	current_state.run_on_process(delta)

func run_on_physics_process(delta: float) -> void:
	current_state.run_on_physics_process(delta)
