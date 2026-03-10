extends ActorBehaviour
class_name GameToggleStopTime

func run(_delta: float) -> void:
	GameManager.toggle_stop_time()
