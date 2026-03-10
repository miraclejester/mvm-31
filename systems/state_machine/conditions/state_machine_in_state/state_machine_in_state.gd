extends StateMachineCondition
class_name StateMachineInState

@export var state_machine: ActorStateMachine
@export var valid_states: Array[ActorState]

func evaluate() -> bool:
	return state_machine.current_state in valid_states
