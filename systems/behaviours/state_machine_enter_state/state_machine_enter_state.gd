extends ActorBehaviour
class_name StateMachineEnterState

@export var state_machine: ActorStateMachine
@export var state_name: String

func run(_delta: float) -> void:
	state_machine.enter_state_by_name(state_name)
