extends ActorBehaviour
class_name AnimatedSpritePlayAnimation

@export var animated_sprite: AnimatedSprite2D
@export var anim_key: String

func run(_delta: float) -> void:
	animated_sprite.play(anim_key)
