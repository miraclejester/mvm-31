extends Node
class_name ActorBehaviour

@export var enable_on_ready: bool = true

var enabled: bool = true

func _ready() -> void:
	set_enabled(enable_on_ready)

func run(_delta: float) -> void:
	pass

func run_physics(_delta: float) -> void:
	pass

func on_enable() -> void:
	pass

func on_disable() -> void:
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
	if enabled:
		on_enable()
	else:
		on_disable()
