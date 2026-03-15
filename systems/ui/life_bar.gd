extends TextureRect
class_name LifeBar

@onready var pip_parent: HBoxContainer = %Pips

var pips: Array[HealthPip]

func _ready() -> void:
	pips.assign(pip_parent.get_children())


func set_health(health: int) -> void:
	var idx: int = 0
	for pip in pips:
		pip.set_enabled(idx < health)
		idx += 1
