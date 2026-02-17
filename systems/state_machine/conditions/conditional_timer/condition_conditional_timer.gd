extends StateMachineCondition
class_name ConditionConditionalTimer

@onready var timer: Timer = %Timer
@onready var reset_conditions_parent: Node = %ResetConditions

@export var time: float

var has_timed_out: bool
var reset_conditions: Array[StateMachineCondition] = []

func _ready() -> void:
	timer.timeout.connect(on_timeout)
	reset_conditions.assign(reset_conditions_parent.get_children())


func state_entered() -> void:
	timer.stop()
	timer.start(time)


func state_exited() -> void:
	timer.stop()
	has_timed_out = false


func state_processed(_delta: float) -> void:
	for condition in reset_conditions:
		if not condition.evaluate():
			return
	timer.stop()
	timer.start(time)


func evaluate() -> bool:
	return has_timed_out
	

func on_timeout() -> void:
	has_timed_out = true
