extends ActorBehaviour
class_name GameUnlockAbility

@export var ability: AbilityData

func run(_delta: float) -> void:
	GameManager.unlock_ability(ability)
