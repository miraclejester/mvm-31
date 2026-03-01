extends ActorBehaviour
class_name AnimatorSetTrigger

@export var animation_controller: ActorAnimationController
@export var trigger_key: String

func run(_delta: float) -> void:
	animation_controller.set_trigger(trigger_key)
