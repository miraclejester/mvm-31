extends RefCounted
class_name SaveData

var current_room: String
var unlocked_abilities: Array[AbilityData.EAbilityKey]
var room_switches: Dictionary[String, bool]
var pearls: int = 0

func _init(r: String) -> void:
	current_room = r
	unlocked_abilities = []
	room_switches = {}
	pearls = 0


func serialize() -> Dictionary:
	var res: Dictionary = {}
	res[Strings.DATA_CURRENT_ROOM] = current_room
	res[Strings.DATA_UNLOCKED_ABILITIES] = unlocked_abilities
	res[Strings.DATA_ROOM_SWITCHES] = room_switches
	res[Strings.DATA_PEARLS] = pearls
	return res


func fill_from_data(data: Dictionary) -> void:
	current_room = data.get(Strings.DATA_CURRENT_ROOM, current_room)
	unlocked_abilities = data.get(Strings.DATA_UNLOCKED_ABILITIES, unlocked_abilities)
	room_switches = data.get(Strings.DATA_ROOM_SWITCHES, room_switches)
	pearls = data.get(Strings.DATA_PEARLS, 0)


func set_switch(switch_name: String) -> void:
	room_switches[switch_name] = true


func get_switch(switch_name: String) -> bool:
	return room_switches.get(switch_name, false)


func add_pearl() -> void:
	pearls += 1
