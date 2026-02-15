extends ActorBehaviour
class_name Node2DFlipOnInput

@export var flip_target: Node2D
@export var controller: PlayerController

func run(_delta: float) -> void:
	if controller.direction.x != 0:
		flip_target.scale.x = controller.direction.x
