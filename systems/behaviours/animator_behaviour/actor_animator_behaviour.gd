extends ActorBehaviour
class_name ActorAnimatorBehaviour

enum EAnimatorBehaviour {
	DirectTravel
}

@export var animation_controller: ActorAnimationController
@export var operation: EAnimatorBehaviour
@export var target_node: String


func run(_delta: float) -> void:
	match operation:
		EAnimatorBehaviour.DirectTravel:
			animation_controller.direct_to_state(target_node)
