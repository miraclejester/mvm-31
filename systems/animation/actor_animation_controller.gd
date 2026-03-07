extends AnimationTree
class_name ActorAnimationController

signal action_finished(key: String)

@export var controller: ActorController
@export var interval_data: Array[AnimationIntervalData]
@export var debug_is_player: bool = false

@onready var process_parent: Node = %ProcessParameters
@onready var interval_parent: Node = %IntervalParameters
@onready var trigger_parent: Node = %TriggerParameters

var active_triggers: Array[String] = []
var active_intervals: Dictionary[String, AnimationIntervalState] = {}
var interval_specs: Dictionary[String, AnimationIntervalData] = {}
var process_parameters: Dictionary[String, ActorAnimatorParameterSetter] = {}
var interval_parameters: Dictionary[String, ActorAnimatorParameterSetter] = {}
var trigger_parameters: Dictionary[String, ActorAnimatorParameterSetter] = {}

func _ready() -> void:
	active = true
	for data in interval_data:
		interval_specs[data.interval_key] = data
	for child in process_parent.get_children():
		var s: ActorAnimatorParameterSetter = child as ActorAnimatorParameterSetter
		process_parameters[s.setter_key] = s
		s.animation_controller = self
	for child in interval_parent.get_children():
		var s: ActorAnimatorParameterSetter = child as ActorAnimatorParameterSetter
		interval_parameters[s.setter_key] = s
		s.animation_controller = self
	for child in trigger_parent.get_children():
		var s: ActorAnimatorParameterSetter = child as ActorAnimatorParameterSetter
		trigger_parameters[s.setter_key] = s
		s.animation_controller = self

func _process(_delta: float) -> void:
	reset_triggers()
	refresh_interval_parameters()
	for s_key in process_parameters:
		process_parameters[s_key].set_parameter()
	for key in active_intervals:
		var state: AnimationIntervalState = active_intervals.get(key)
		if (not state.pending_reset) and controller.is_action_just_pressed(state.data.control_key):
			state.pending_reset = true
	if Input.is_action_just_pressed("debug_hurt") and debug_is_player:
		direct_to_state('hurt')


func direct_to_state(state_key: String) -> void:
	get_playback().travel(state_key)


func get_playback() -> AnimationNodeStateMachinePlayback:
	return get('parameters/playback') as AnimationNodeStateMachinePlayback


func set_trigger(key: String) -> void:
	trigger_parameters[key].set_trigger()
	active_triggers.append(key)
	for k in active_intervals:
		var state: AnimationIntervalState = active_intervals.get(k)
		if (k in state.data.triggerInterrupts):
			state.pending_reset = true
			resolve_interval(k)


func reset_triggers() -> void:
	for key in active_triggers:
		trigger_parameters[key].reset_trigger()
	active_triggers = []


func send_action_finished_event(action: String) -> void:
	action_finished.emit(action)


func call_direct_action(action: String) -> void:
	controller.call_direct_action(action)


func start_action_reset_interval(action: String) -> void:
	if active_intervals.has(action):
		active_intervals[action].pending_reset = false
	else:
		var data: AnimationIntervalData = interval_specs.get(action, null)
		if data != null:
			active_intervals[action] = AnimationIntervalState.new(data)


func resolve_interval(action: String) -> void:
	var state: AnimationIntervalState = active_intervals.get(action)
	if state != null and (not state.pending_reset):
		active_intervals.erase(action)
		send_action_finished_event(action)
		refresh_interval_parameters()


func is_interval_active(action: String) -> bool:
	return active_intervals.has(action)


func remove_interval(action: String) -> void:
	active_intervals.erase(action)


func refresh_interval_parameters() -> void:
	for s_key in interval_parameters:
		interval_parameters[s_key].set_parameter()
