extends StateMachineCondition
class_name ConditionAnimatedSpriteAnimationFinished

@export var animated_sprite: AnimatedSprite2D
@export var anim_name: String

var animation_has_finished: bool = false
var checking: bool = false


func _ready() -> void:
	animated_sprite.animation_finished.connect(on_animation_finished)


func evaluate() -> bool:
	return animation_has_finished


func state_entered() -> void:
	animation_has_finished = false
	checking = true


func state_exited() -> void:
	animation_has_finished = false
	checking = false


func on_animation_finished() -> void:
	if not checking:
		return
	animation_has_finished = animated_sprite.animation == anim_name
