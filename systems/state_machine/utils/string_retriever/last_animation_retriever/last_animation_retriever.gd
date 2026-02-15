extends StringRetriever
class_name LastAnimationRetriever

@export var animation_controller: SimpleAnimationController

func retrieve_string() -> String:
	return animation_controller.last_played_anim_key
