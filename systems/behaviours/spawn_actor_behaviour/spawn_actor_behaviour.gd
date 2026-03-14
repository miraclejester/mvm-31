extends ActorBehaviour
class_name SpawnActorBehaviour

@export var actor_scene: PackedScene
@export var parent: Node2D


func run(_delta: float) -> void:
	parent.add_child(actor_scene.instantiate())
