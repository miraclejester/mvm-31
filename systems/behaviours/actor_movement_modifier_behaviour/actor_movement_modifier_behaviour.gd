extends ActorBehaviour
class_name ActorMovementModifierBehaviour

enum EActorMovementMod {
	ResetWaterRotations
}

@export var movement: ActorMovement
@export var operation: EActorMovementMod

func run(_delta: float) -> void:
	match operation:
		EActorMovementMod.ResetWaterRotations:
			movement.reset_water_rotations()
