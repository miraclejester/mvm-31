extends ActorBehaviour
class_name ActorEnableBehaviour

@export var behaviour: ActorBehaviour
@export var enable: bool = true

func run(_delta: float) -> void:
	behaviour.set_enabled(enabled)
