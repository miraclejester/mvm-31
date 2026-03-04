extends ActorBehaviour
class_name ActorEraseActor

@export var target: Node2D

func run(_delta: float) -> void:
	target.queue_free()
