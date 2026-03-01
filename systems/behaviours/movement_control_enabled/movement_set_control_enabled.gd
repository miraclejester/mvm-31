extends ActorBehaviour
class_name MovementSetControlEnabled

@export var movement: ActorMovement
@export var control_enabled: bool

func run(_delta: float) -> void:
	movement.controller_enabled = control_enabled
