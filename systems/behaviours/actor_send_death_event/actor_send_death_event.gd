extends ActorBehaviour
class_name ActorSendDeathEvent

@export var actor: WorldCharacter

func run(_delta: float) -> void:
	actor.send_death_finished()
