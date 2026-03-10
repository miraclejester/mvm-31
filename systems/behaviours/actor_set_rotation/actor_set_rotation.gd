extends ActorBehaviour
class_name ActorSetRotation

@export var actor: Node2D
@export var rotation_degrees: float

func run(_delta: float) -> void:
	actor.rotation_degrees = rotation_degrees
