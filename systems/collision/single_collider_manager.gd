extends Node
class_name SingleColliderManager

@export var collider: CollisionShape2D
@export var specs: Array[ColliderSpec]

var spec_dict: Dictionary[String, ColliderSpec]

func _ready() -> void:
	spec_dict = {}
	for spec in specs:
		spec_dict[spec.key] = spec


func apply_spec(key: String) -> void:
	var spec: ColliderSpec = spec_dict.get(key)
	if spec == null:
		return
	collider.shape = spec.shape
	collider.position = spec.position
