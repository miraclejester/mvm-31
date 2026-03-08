extends StateMachineCondition
class_name ActorIsAtPosition

@export var actor: Node2D
@export var retriever: StaticPositionRetriever
@export var distance_threshold: float = 4

func evaluate() -> bool:
	var target_pos: Vector2 = retriever.get_cached_position()
	return actor.global_position.distance_to(target_pos) <= distance_threshold
