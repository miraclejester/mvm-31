extends ActorBehaviour
class_name GameSaveGame

func run(_delta: float) -> void:
	GameManager.save_to_file()
