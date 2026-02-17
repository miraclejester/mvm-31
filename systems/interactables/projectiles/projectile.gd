extends CharacterBody2D
class_name Projectile

func initialize(emitter_data: ProjectileEmitterData, shot_data: ProjectileShotData) -> void:
	velocity = shot_data.direction * emitter_data.projectile_speed
	scale.x = sign(shot_data.direction.x)


func _process(_delta: float) -> void:
	move_and_slide()
