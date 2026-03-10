extends ActorBehaviour
class_name ActorSetScale

@export var actor: Node2D
@export var scale: Vector2

func run(_delta: float) -> void:
	actor.scale = scale
