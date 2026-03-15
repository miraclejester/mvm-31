extends Node2D
class_name Ending

@onready var akoya_sprite: Sprite2D = %Akoya

func _ready() -> void:
	OverlayEffects.fade_in()
	float_up()


func float_up() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(akoya_sprite, "position", akoya_sprite.position + Vector2.UP * 2, 1).set_trans(Tween.TRANS_SINE)
	tween.tween_callback(float_down)


func float_down() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(akoya_sprite, "position", akoya_sprite.position + Vector2.DOWN * 2, 1).set_trans(Tween.TRANS_SINE)
	tween.tween_callback(float_up)
