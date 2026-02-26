extends Node

signal projectile_shot(data: ProjectileShotData)

func emit_projectile_shot(data: ProjectileShotData) -> void:
	projectile_shot.emit(data)
