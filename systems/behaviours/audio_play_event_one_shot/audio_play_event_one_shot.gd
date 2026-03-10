extends ActorBehaviour
class_name AudioPlayEventOneShot

@export var event_emitter: FmodEventEmitter2D

func run(_delta: float) -> void:
	event_emitter.volume = AudioManager.config.sfx_volume
	event_emitter.play_one_shot()
