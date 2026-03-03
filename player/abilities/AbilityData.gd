extends Resource
class_name AbilityData

enum EAbilityKey {
	MeleeAttack,
	RangedAttack,
	Mermaid,
	Counter
}

@export var ability_key: EAbilityKey
@export var ability_name: String
