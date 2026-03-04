extends ActorBehaviour
class_name ControllerSetMovementInput

@export var controller: ActorController
@export var input: Vector2

func run(_delta: float) -> void:
	controller.set_movement_input(input)
