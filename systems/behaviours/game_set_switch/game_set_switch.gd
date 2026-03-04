extends ActorBehaviour
class_name GameSetSwitch

@export var switch_name: String

func run(_delta: float) -> void:
	GameManager.set_switch(switch_name)
