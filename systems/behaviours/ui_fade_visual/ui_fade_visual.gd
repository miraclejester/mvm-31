extends ActorBehaviour
class_name UIFadeVisual

enum EFadeOption {
	In, Out
}

@export var item: CanvasItem
@export var fade_option: EFadeOption
@export var time_to_fade: float


func run(_delta) -> void:
	var tween: Tween = create_tween()
	var value: float = 0 if fade_option == EFadeOption.Out else 1
	tween.tween_property(item, "modulate:a", value, time_to_fade)
