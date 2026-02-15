extends ActorState
class_name PlayerStateIdle

var player: Player

func on_entere(state_machine: ActorStateMachine) -> void:
	player = state_machine.context as Player
	player.animations.play("idle")
