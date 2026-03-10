extends ActorBehaviour
class_name Node2DFlipOnInput

@export var flip_target: Node2D
@export var controller: ActorController

var last_scale_x: float

func run(_delta: float) -> void:
	if controller.direction.x != 0:
		last_scale_x = controller.direction.x
		flip_target.scale.x = controller.direction.x


func run_disabled(_delta: float) -> void:
	if controller.direction.x != 0:
		last_scale_x = controller.direction.x


func recover_last_flip() -> void:
	if last_scale_x != 0:
		flip_target.scale.x = last_scale_x
