extends ActorBehaviour
class_name AudioPlayEventOneShot

@export var event_emitter: FmodEventEmitter2D
@export var play_regular: bool = false
@export var stop: bool = false

func run(_delta: float) -> void:
	if stop:
		event_emitter.stop()
		return
	event_emitter.volume = AudioManager.config.sfx_volume
	if play_regular:
		event_emitter.play()
	else:
		event_emitter.play_one_shot()
