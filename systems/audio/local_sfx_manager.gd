extends Node2D
class_name LocalSFXManager

var emitters: Dictionary[String, FmodEventEmitter2D]

func _ready() -> void:
	for child in get_children():
		var e: FmodEventEmitter2D = child as FmodEventEmitter2D
		emitters[e.name] = e


func play_sfx(key: String) -> void:
	emitters[key].play_one_shot()


func play_quick_sfx(key) -> void:
	emitters[key].play()
