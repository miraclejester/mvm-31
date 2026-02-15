extends PlayerState
class_name PlayerStateRun

func on_enter(player: PlayerStateMachine) -> void:
	player.animations.play("run")

#
