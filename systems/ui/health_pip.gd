extends TextureRect
class_name HealthPip

@export var on_texture: Texture2D
@export var off_texture: Texture2D

func _ready() -> void:
	set_enabled(true)


func set_enabled(enabled: bool) -> void:
	if enabled:
		texture = on_texture
	else:
		texture = off_texture
