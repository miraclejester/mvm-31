extends ActorBehaviour
class_name BehaviourSequence

var behaviours: Array[ActorBehaviour] = []

func _ready() -> void:
	behaviours.assign(get_children())


func run(delta: float) -> void:
	for behaviour in behaviours:
		behaviour.try_run(delta)


func run_physics(delta: float) -> void:
	for behaviour in behaviours:
		behaviour.try_run_physics(delta)
