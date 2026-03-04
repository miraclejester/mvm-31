extends RefCounted
class_name SaveData

var current_room: String
var unlocked_abilities: Array[AbilityData.EAbilityKey]
var room_switches: Dictionary[String, bool]

func _init(r: String) -> void:
	current_room = r
	unlocked_abilities = []
	room_switches = {}


func serialize() -> Dictionary:
	var res: Dictionary = {}
	res[Strings.DATA_CURRENT_ROOM] = current_room
	res[Strings.DATA_UNLOCKED_ABILITIES] = unlocked_abilities
	res[Strings.DATA_ROOM_SWITCHES] = room_switches
	return res


func fill_from_data(data: Dictionary) -> void:
	current_room = data[Strings.DATA_CURRENT_ROOM]
	unlocked_abilities = data[Strings.DATA_UNLOCKED_ABILITIES]
	room_switches = data[Strings.DATA_ROOM_SWITCHES]


func set_switch(switch_name: String) -> void:
	room_switches[switch_name] = true


func get_switch(switch_name: String) -> bool:
	return room_switches.get(switch_name, false)
