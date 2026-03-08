extends ActorBehaviour
class_name ActorHitboxBehaviour

enum EHitboxOperation {
	EnableDisableCollider
}

@export var hitbox: Hitbox
@export var operation: EHitboxOperation
@export var enable: bool

func run(_delta: float) -> void:
	match operation:
		EHitboxOperation.EnableDisableCollider:
			hitbox.set_collider_enabled(enable)
