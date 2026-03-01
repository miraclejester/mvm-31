extends Node
class_name ColliderGroupManager

var managers: Array[SingleColliderManager]

func _ready() -> void:
	managers.assign(get_children())


func apply_profile_key(key: String) -> void:
	for manager in managers:
		manager.apply_spec(key)
