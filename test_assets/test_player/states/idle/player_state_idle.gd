extends PlayerState
class_name PlayerStateIdle

func on_enter(player: PlayerStateMachine) -> void:
	player.animations.play("idle")

#
