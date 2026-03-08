extends ActorBehaviour
class_name ActorSetPosition

@export var actor: Node2D
@export var target: StaticPositionRetriever

func run(_delta: float) -> void:
	actor.global_position = target.get_cached_position()
