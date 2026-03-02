extends AnimationTree
class_name ActorAnimationController

signal action_finished(key: String)

@export var body: CharacterBody2D
@export var movement: ActorMovement
@export var controller: ActorController
@export var crouch_action: String

var active_triggers: Array[String] = []
var active_intervals: Dictionary[String, AnimationIntervalState] = {}

func _ready() -> void:
	active = true

func _process(_delta: float) -> void:
	reset_triggers()
	set("parameters/Grounded/blend_position", abs(body.velocity.x))
	set("parameters/Airborne/blend_position", sign(body.velocity.y))
	set("parameters/conditions/grounded", movement.is_considered_on_floor())
	set("parameters/conditions/airborne", not movement.is_considered_on_floor())
	set("parameters/conditions/crouching", controller.is_action_pressed(crouch_action))
	set("parameters/conditions/standing", not controller.is_action_pressed(crouch_action))
	refresh_interval_parameters()
	
	for key in active_intervals:
		var state: AnimationIntervalState = active_intervals.get(key)
		if (not state.pending_reset) and controller.is_action_just_pressed(state.action):
			state.pending_reset = true


func set_trigger(key: String) -> void:
	set("parameters/conditions/%s" % key, true)
	active_triggers.append(key)


func reset_triggers() -> void:
	for key in active_triggers:
		set("parameters/conditions/%s" % key, false)
	active_triggers = []


func send_action_finished_event(action: String) -> void:
	action_finished.emit(action)


func call_direct_action(action: String) -> void:
	controller.call_direct_action(action)


func start_action_reset_interval(action: String, control_action: String) -> void:
	if active_intervals.has(action):
		active_intervals[action].pending_reset = false
	else:
		active_intervals[action] = AnimationIntervalState.new(control_action)


func resolve_interval(action: String) -> void:
	var state: AnimationIntervalState = active_intervals.get(action)
	if state != null and (not state.pending_reset):
		active_intervals.erase(action)
		send_action_finished_event(action)
		refresh_interval_parameters()


func is_interval_active(action: String) -> bool:
	return active_intervals.has(action)


func refresh_interval_parameters() -> void:
	set("parameters/conditions/gun_idle", not is_interval_active("shoot"))
