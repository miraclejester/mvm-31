extends AnimationTree
class_name ActorAnimationController

signal action_finished(key: String)

@export var body: CharacterBody2D
@export var movement: ActorMovement
@export var controller: ActorController
@export var crouch_action: String

var active_triggers: Array[String] = []

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


func set_trigger(key: String) -> void:
	set("parameters/conditions/%s" % key, true)
	active_triggers.append(key)


func reset_triggers() -> void:
	for key in active_triggers:
		set("parameters/conditions/%s" % key, false)
	active_triggers = []


func send_action_finished_event(action: String) -> void:
	action_finished.emit(action)
