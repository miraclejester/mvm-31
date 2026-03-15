extends CanvasLayer
class_name Hud

@onready var lifebar: LifeBar = %LifeBar

func set_health(health: int) -> void:
	lifebar.set_health(health)
