extends StateMachineCondition
class_name GameIsSwitchSet

@export var switch_name: String

func evaluate() -> bool:
	return GameManager.get_switch(switch_name)
