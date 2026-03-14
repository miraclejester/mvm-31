extends ActorRetriever
class_name PlayerRetriever

func get_actor() -> Node2D:
	if not is_instance_valid(GameManager.current_world.player):
		return null
	return GameManager.current_world.player
