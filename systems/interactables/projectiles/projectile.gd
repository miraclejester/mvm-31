extends CharacterBody2D
class_name Projectile

enum EProjectileDirectionType {
	Direct,
	Player
}

@export var direction_type: EProjectileDirectionType

@onready var visibility_notifier: VisibleOnScreenNotifier2D = %VisibilityNotifier

func _ready() -> void:
	visibility_notifier.screen_exited.connect(on_screen_exited)


func initialize(emitter_data: ProjectileEmitterData, shot_data: ProjectileShotData) -> void:
	var final_dir: Vector2 = Vector2.RIGHT
	match direction_type:
		EProjectileDirectionType.Direct:
			final_dir = shot_data.direction
		EProjectileDirectionType.Player:
			if not is_instance_valid(GameManager.current_world.player):
				final_dir = shot_data.direction
			else:
				final_dir = shot_data.position.direction_to(GameManager.current_world.player.global_position)
	velocity = final_dir * emitter_data.projectile_speed
	scale.x = sign(shot_data.direction.x)


func _process(_delta: float) -> void:
	move_and_slide()


func on_screen_exited() -> void:
	queue_free()
