extends StateMachineCondition
class_name BodyIsInCoyoteTime

@export var body: CharacterBody2D
@export var time: float = 0.5

@onready var coyote_timer: Timer = %CoyoteTimer

var was_on_floor: float = false
var on_coyote_time: float = false

func _ready() -> void:
	coyote_timer.timeout.connect(coyote_timer_timeout)

func state_entered() -> void:
	was_on_floor = body.is_on_floor()
	on_coyote_time = false

func state_processed(_delta: float) -> void:
	var on_floor: bool = body.is_on_floor()
	if was_on_floor and (not on_floor) and (not on_coyote_time):
		on_coyote_time = true
		coyote_timer.stop()
		coyote_timer.start(time)
	was_on_floor = on_floor

func state_exited() -> void:
	coyote_timer.stop()
	was_on_floor = false
	on_coyote_time = false

func evaluate() -> bool:
	return on_coyote_time

func coyote_timer_timeout() -> void:
	on_coyote_time = false
