extends Node

signal world_set()
signal game_saved()

@export var possible_abilities: Array[AbilityData]
@export var save_path: String = "save_game.save"
@export var default_room: GameWorldRoomData
@export var default_abilities: Array[AbilityData.EAbilityKey]

var current_world: GameWorld
var ability_dict: Dictionary[AbilityData.EAbilityKey, AbilityData] = {}
var unlocked_abilities: Dictionary[AbilityData.EAbilityKey, AbilityData] = {}
var save_data: SaveData

func _ready() -> void:
	save_data = load_from_file()
	for ability in possible_abilities:
		ability_dict[ability.ability_key] = ability
	for ability_key in save_data.unlocked_abilities:
		unlock_ability(ability_dict[ability_key])


func set_world(world: GameWorld) -> void:
	current_world = world
	world_set.emit()
	world.current_room_set.connect(on_current_room_set)


func on_current_room_set(data: GameWorldRoomData) -> void:
	save_data.current_room = data.room_key


func unlock_ability(data: AbilityData) -> void:
	unlocked_abilities[data.ability_key] = data
	if not data.ability_key in save_data.unlocked_abilities:
		save_data.unlocked_abilities.append(data.ability_key)


func is_ability_unlocked(key: AbilityData.EAbilityKey) -> bool:
	return unlocked_abilities.has(key)


func get_current_saved_room() -> GameWorldRoomData:
	var room_key: String = save_data.current_room
	return ResourceLoader.load("res://maps/main_map/data/%s.tres" % room_key) as GameWorldRoomData


func set_switch(switch_name: String) -> void:
	save_data.set_switch(switch_name)


func get_switch(switch_name: String) -> bool:
	return save_data.get_switch(switch_name)


func get_save_path() -> String:
	return "user://%s" % save_path


func get_default_data() -> Dictionary:
	var res: Dictionary = {}
	res[Strings.DATA_UNLOCKED_ABILITIES] = []
	res[Strings.DATA_CURRENT_ROOM] = default_room.room_key
	res[Strings.DATA_ROOM_SWITCHES] = {}
	return res


func save_to_file() -> void:
	var file: FileAccess = FileAccess.open(get_save_path(), FileAccess.WRITE)
	if file == null:
		print("Error opening file for saving")
	
	file.store_var(save_data.serialize())
	file.close()
	game_saved.emit()


func load_from_file() -> SaveData:
	var path: String = get_save_path()
	var data: SaveData = create_new_save()
	if not FileAccess.file_exists(path):
		return data
	
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	if file == null:
		return data
	
	var res: Dictionary = file.get_var() as Dictionary
	file.close()
	data.fill_from_data(res)
	return data


func create_new_save() -> SaveData:
	var data: SaveData = SaveData.new(default_room.room_key)
	data.fill_from_data({
		Strings.DATA_UNLOCKED_ABILITIES: default_abilities
	})
	return data
