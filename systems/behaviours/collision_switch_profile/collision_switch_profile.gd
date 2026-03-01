extends ActorBehaviour
class_name CollisionSwitchProfile

@export var manager: ColliderGroupManager
@export var profile_key: String

func run(_delta: float) -> void:
	manager.apply_profile_key(profile_key)
