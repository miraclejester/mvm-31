extends Node
class_name ActorBehaviour

var enabled: bool = true

func run(_delta: float) -> void:
	pass

func run_physics(_delta: float) -> void:
	pass


func try_run(delta: float) -> void:
	if not enabled:
		return
	run(delta)


func try_run_physics(delta: float) -> void:
	if not enabled:
		return
	run_physics(delta)


func set_enabled(e: bool) -> void:
	enabled = e
