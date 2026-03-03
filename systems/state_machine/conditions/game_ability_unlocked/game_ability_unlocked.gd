extends StateMachineCondition
class_name GameAbilityUnlocked

@export var ability: AbilityData.EAbilityKey

func evaluate() -> bool:
	return GameManager.is_ability_unlocked(ability)
