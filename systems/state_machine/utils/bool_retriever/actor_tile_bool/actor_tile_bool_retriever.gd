extends BoolRetriever
class_name ActorTileBoolRetriever

@export var movement: ActorMovement

func retrieve_bool() -> bool:
	return movement.water_marker_in_water()
