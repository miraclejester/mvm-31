extends ActorBehaviour
class_name ProjectileControllerEmitterBehaviour

@export var emitter: ProjectileEmitter
@export var controller: ActorController
@export var shoot_action: String

func _ready() -> void:
	controller.action_just_pressed.connect(on_controller_just_pressed)


func on_controller_just_pressed(key: String) -> void:
	if not enabled:
		return
	if key == shoot_action:
		emitter.fire_projectile()
