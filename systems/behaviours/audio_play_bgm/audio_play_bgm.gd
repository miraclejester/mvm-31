extends ActorBehaviour
class_name AudioPlayBGM

@export var bgm_key: String

func run(_delta: float) -> void:
	AudioManager.play_bgm(bgm_key)
