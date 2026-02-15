extends AnimatedSprite2D
class_name SimpleAnimationController

var last_played_anim_key: String = ""

func _ready() -> void:
	animation_finished.connect(on_animation_finished)


func on_animation_finished() -> void:
	last_played_anim_key = animation
