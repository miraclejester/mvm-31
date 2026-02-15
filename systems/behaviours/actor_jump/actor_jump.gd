extends ActorBehaviour
class_name ActorJump

@export var movement_behaviour: ActorMovement

func run(delta: float) -> void:
	movement_behaviour.start_jump(delta)
