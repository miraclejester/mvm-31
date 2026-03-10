extends ActorBehaviour
class_name WorldModifierBehaviour

enum EWorldOperation {
	SendEnteredWater,
	SendExitedWater
}

@export var operation: EWorldOperation

func run(_delta: float) -> void:
	match operation:
		EWorldOperation.SendEnteredWater:
			GameManager.current_world.send_entered_water()
		EWorldOperation.SendExitedWater:
			GameManager.current_world.send_exited_water()
