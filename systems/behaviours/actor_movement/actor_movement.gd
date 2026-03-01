extends ActorBehaviour
class_name ActorMovement

enum EMovementMode {
	GROUND,
	WATER
}

@export_group("References")
@export var body: CharacterBody2D
@export var controller: ActorController

@export_group("Ground Movement")
@export var acceleration: float = 20
@export var decceleration: float = 40
@export var max_speed: float = 280
@export var gravity: Vector2 = Vector2(0, 1500)
@export var floor_snap_length: float = 5
@export var coyote_time: float = 0.5
@export var coyote_time_enabled: bool = false

@export_group("Water Movement")
@export var water_detector: BoolRetriever
@export var water_max_speed: float = 280
@export var water_friction_factor: float = 0.2
@export var water_acceleration: float = 15
@export var water_speed_jump_out_threshold: float = 200
@export var water_jump_force: float = -400

@export_group("Jump")
@export var jump_action_key: String = "jump"
@export var jump_force: float = -700
@export var jump_threshold: float = -200
@export var cut_jump_force: float = -320

@onready var coyote_timer: Timer = %CoyoteTimer

var jump_enabled = true
var on_coyote_time: bool = false
var was_on_floor: bool = false
var controller_enabled: bool = true
var control_direction: Vector2 = Vector2.ZERO
var control_face_dir: Vector2 = Vector2.ZERO

var velocity: Vector2
var current_profile: ActorMovementProfile
var move_mode_dict: Dictionary[EMovementMode, ActorMovementProfile] = {
	EMovementMode.GROUND : ActorMovementProfile.from_data({
		"move_method": ground_movement,
		"initialize_method": ground_initialize_movement,
	}),
	#EMovementMode.WATER : ActorMovementProfile.from_data({
	#	"move_method": water_movement,
	#	"initialize_method": func(): jump_enabled = false,
	#	"post_move_method": water_post_movement
	#})
}

func _ready() -> void:
	body.floor_snap_length = floor_snap_length
	body.up_direction = Vector2.UP
	body.floor_constant_speed = true
	controller.action_just_released.connect(on_controller_just_released)
	was_on_floor = false
	on_coyote_time = false
	coyote_timer.timeout.connect(on_coyote_timer_timeout)


func run(_delta: float) -> void:
	var on_floor: bool = body.is_on_floor()
	if coyote_time_enabled and was_on_floor and (not on_floor) and body.velocity.y >= 0:
		on_coyote_time = true
		coyote_timer.start(coyote_time)
	was_on_floor = on_floor


func run_physics(delta: float) -> void:
	move(delta)


func apply_gravity(delta: float) -> void:
	if not body.is_on_floor():
		velocity += gravity * delta


func move(delta: float) -> void:
	get_controller_input()
	var profile: ActorMovementProfile = get_move_profile()
	if current_profile == null or current_profile != profile:
		current_profile = profile
		profile.enter_method.call()
	profile.initialize_method.call()
	profile.move_method.call(delta)
	body.move_and_slide()
	profile.post_move_method.call()


func get_move_profile() -> ActorMovementProfile:
	return move_mode_dict[EMovementMode.GROUND]


func ground_movement(delta: float) -> void:
	velocity = body.velocity
	if velocity.y < 0 or (not on_coyote_time):
		apply_gravity(delta)
	
	if control_direction.x != 0:
		velocity.x = move_toward(velocity.x, control_direction.x * max_speed, acceleration)
	elif is_considered_on_floor():
		velocity.x = move_toward(velocity.x, 0, decceleration)
	body.velocity = velocity


func is_considered_on_floor():
	return body.is_on_floor() or on_coyote_time


func ground_initialize_movement() -> void:
	body.rotation = 0
	jump_enabled = true


func water_movement(_delta: float) -> void:
	velocity = body.velocity
	
	body.rotation = control_face_dir.angle()
	if control_direction != Vector2.ZERO:
		velocity = velocity.move_toward(control_direction * water_max_speed, water_acceleration)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, water_max_speed * water_friction_factor)
	body.velocity = velocity


func water_post_movement() -> void:
	var in_water: bool = water_detector.retrieve_bool()
	if not in_water and body.velocity.y <= -water_speed_jump_out_threshold:
		jump_enabled = true
		apply_jump_force(water_jump_force)


func start_jump(_delta: float) -> void:
	apply_jump_force(jump_force)


func apply_jump_force(jf: float) -> void:
	if not jump_enabled:
		return
	velocity = body.velocity
	velocity.y = jf
	body.velocity = velocity


func get_controller_input() -> void:
	if controller_enabled:
		control_direction = controller.direction
		control_face_dir = controller.face_direction
	else:
		control_direction = Vector2.ZERO


func on_controller_just_released(key: String) -> void:
	if not enabled or not controller_enabled:
		return
	if key == jump_action_key and body.velocity.y < jump_threshold:
		apply_jump_force(cut_jump_force)


func on_coyote_timer_timeout() -> void:
	on_coyote_time = false
