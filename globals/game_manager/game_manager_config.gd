extends Resource
class_name GameManagerConfig

@export var possible_abilities: Array[AbilityData]
@export var save_path: String = "save_game.save"
@export var default_room: GameWorldRoomData
@export var default_abilities: Array[AbilityData.EAbilityKey]
