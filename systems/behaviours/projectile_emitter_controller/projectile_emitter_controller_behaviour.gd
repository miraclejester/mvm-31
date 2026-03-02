extends ActorBehaviour
class_name ProjectileControllerEmitterBehaviour

@export var emitter: ProjectileEmitter
@export var controller: ActorController
@export var shoot_action: String

func _ready() -> void:
	controller.direct_action.connect(on_controller_direct_action)


func on_controller_direct_action(key: String) -> void:
	if not enabled:
		return
	if key == shoot_action:
		emitter.fire_projectile()
