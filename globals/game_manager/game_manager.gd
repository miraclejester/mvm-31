extends Node

@export var default_abilities: Array[AbilityData]

var current_world: GameWorld
var unlocked_abilities: Dictionary[AbilityData.EAbilityKey, AbilityData] = {}

func _ready() -> void:
	for ability in default_abilities:
		unlock_ability(ability)


func unlock_ability(data: AbilityData) -> void:
	unlocked_abilities[data.ability_key] = data

func is_ability_unlocked(key: AbilityData.EAbilityKey) -> bool:
	return unlocked_abilities.has(key)
