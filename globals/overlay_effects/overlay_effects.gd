extends CanvasLayer

signal fade_out_finished()

@onready var color_overlay: ColorRect = %ColorOverlay


func fade_out() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(color_overlay, "modulate:a", 1.0, 2).set_trans(Tween.TRANS_SINE)
	tween.tween_callback(on_fade_out_finished)


func fade_in() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(color_overlay, "modulate:a", 0, 2).set_trans(Tween.TRANS_SINE)


func on_fade_out_finished() -> void:
	fade_out_finished.emit()
