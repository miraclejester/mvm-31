extends ActorBehaviour
class_name ActorMovement

enum EMovementMode {
	GROUND,
	WATER,
	SURFACE_WATER,
	AERIAL
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
@export var constant_speed: bool = false

@export_group("Water Movement")
@export var water_detector: BoolRetriever
@export var water_max_speed: float = 280
@export var water_friction_factor: float = 0.2
@export var water_acceleration: float = 15
@export var water_speed_jump_out_threshold: float = 200
@export var water_jump_force: float = -400
@export var can_swim_underwater_condition: StateMachineCondition
@export var full_rotation_targets: Array[Node2D]
@export var half_rotation_targets: Array[Node2D]

@export_group("Surface Water Movement")
@export var water_marker: Node2D
@export var underwater_marker: Node2D
@export var surfacing_speed: float = 300
@export var surface_move_speed: float = 280

@export_group("Jump")
@export var jump_action_key: String = "jump"
@export var jump_force: float = -700
@export var jump_threshold: float = -200
@export var cut_jump_force: float = -320

@export_group("Aerial")
@export var aerial_enabled = false

@onready var coyote_timer: Timer = %CoyoteTimer

var jump_enabled = true
var on_coyote_time: bool = false
var was_on_floor: bool = false
var controller_enabled: bool = true
var control_direction: Vector2 = Vector2.ZERO
var control_face_dir: Vector2 = Vector2.ZERO
var jumping = false

var velocity: Vector2
var current_profile: ActorMovementProfile
var profile_key: EMovementMode = EMovementMode.GROUND
var move_mode_dict: Dictionary[EMovementMode, ActorMovementProfile] = {
	EMovementMode.GROUND : ActorMovementProfile.from_data({
		"move_method": ground_movement,
		"initialize_method": ground_initialize_movement,
		"profile_name": "Ground"
	}),
	EMovementMode.SURFACE_WATER: ActorMovementProfile.from_data({
		"move_method": surface_water_movement,
		"profile_name": "WaterSurface"
	}),
	EMovementMode.AERIAL: ActorMovementProfile.from_data({
		"move_method": aerial_movement,
		"profile_name": "Aerial"
	}),
	EMovementMode.WATER : ActorMovementProfile.from_data({
		"move_method": water_movement,
		"profile_name": "Water"
	})
}

func _ready() -> void:
	body.floor_snap_length = floor_snap_length
	body.up_direction = Vector2.UP
	body.floor_constant_speed = true
	controller.action_just_released.connect(on_controller_just_released)
	was_on_floor = false
	on_coyote_time = false
	profile_key = EMovementMode.AERIAL if aerial_enabled else EMovementMode.GROUND
	coyote_timer.timeout.connect(on_coyote_timer_timeout)


func run(_delta: float) -> void:
	var on_floor: bool = body.is_on_floor()
	if coyote_time_enabled and was_on_floor and (not on_floor) and body.velocity.y >= 0:
		on_coyote_time = true
		coyote_timer.start(coyote_time)
	was_on_floor = on_floor


func run_physics(delta: float) -> void:
	move(delta)
	if body.velocity.y >= 0:
		jumping = false


func apply_gravity(delta: float) -> void:
	if not body.is_on_floor():
		velocity += gravity * delta


func move(delta: float) -> void:
	get_controller_input()
	var key: EMovementMode = get_move_profile_key()
	var profile: ActorMovementProfile = move_mode_dict[key]
	if current_profile == null or current_profile != profile:
		current_profile = profile
		profile_key = key
		profile.enter_method.call()
		#print("Changed profile")
	profile.initialize_method.call()
	profile.move_method.call(delta)
	body.move_and_slide()
	profile.post_move_method.call()


func get_move_profile_key() -> EMovementMode:
	match profile_key:
		EMovementMode.AERIAL:
			return EMovementMode.AERIAL
		EMovementMode.GROUND:
			var can_swim_underwater: bool = (can_swim_underwater_condition != null) and can_swim_underwater_condition.evaluate()
			if water_marker_in_water():
				return EMovementMode.WATER if can_swim_underwater else EMovementMode.SURFACE_WATER
			else:
				return EMovementMode.GROUND
		EMovementMode.SURFACE_WATER:
			if not underwater_marker_in_water():
				return EMovementMode.GROUND
			else:
				return EMovementMode.SURFACE_WATER
		EMovementMode.WATER:
			if not underwater_marker_in_water():
				return EMovementMode.GROUND
			else:
				return EMovementMode.WATER
	return EMovementMode.GROUND


func ground_movement(delta: float) -> void:
	velocity = body.velocity
	if velocity.y < 0 or (not on_coyote_time):
		apply_gravity(delta)
	
	if control_direction.x != 0:
		if constant_speed:
			velocity.x = control_direction.x * max_speed
		else:
			velocity.x = move_toward(velocity.x, control_direction.x * max_speed, acceleration)
	elif is_considered_on_floor():
		if constant_speed:
			velocity.x = 0
		else:
			velocity.x = move_toward(velocity.x, 0, decceleration)
	body.velocity = velocity


func is_considered_on_floor():
	return body.is_on_floor() or on_coyote_time


func water_marker_in_water() -> bool:
	if water_marker == null:
		return false
	var tile: TileData = Utils.get_tile_at(Strings.ROOM_LAYER_NEAR_FOREGROUND, water_marker.global_position)
	return tile != null and tile.get_custom_data("is_water")


func underwater_marker_in_water() -> bool:
	if underwater_marker == null:
		return false
	var tile: TileData = Utils.get_tile_at(Strings.ROOM_LAYER_NEAR_FOREGROUND, underwater_marker.global_position)
	return tile != null and tile.get_custom_data("is_water")


func ground_initialize_movement() -> void:
	body.rotation = 0
	jump_enabled = true


func water_movement(_delta: float) -> void:
	velocity = body.velocity
	
	if not jumping:
		if control_direction != Vector2.ZERO:
			var desired_rot: float = rad_to_deg(control_face_dir.angle())
			for target in full_rotation_targets:
				target.rotation_degrees = desired_rot
			for target in half_rotation_targets:
				target.rotation_degrees = desired_rot
				if target.rotation_degrees > 91 or target.rotation_degrees < -46:
					target.scale.y = -1
				else:
					target.scale.y = 1
		else:
			reset_water_rotations()
	if control_direction != Vector2.ZERO:
		velocity = velocity.move_toward(control_direction * water_max_speed, water_acceleration)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, water_max_speed * water_friction_factor)
	
	if not water_marker_in_water() and not jumping and control_direction.y <= 0:
		velocity.y = 0
	
	body.velocity = velocity


func reset_water_rotations() -> void:
	for target in full_rotation_targets:
		target.rotation_degrees = 0
	for target in half_rotation_targets:
		target.rotation_degrees = 0
		target.scale.y = 1


func surface_water_movement(_delta: float) -> void:
	if water_marker_in_water() and underwater_marker_in_water():
		velocity.y = -surfacing_speed
	elif not jumping:
		velocity.y = 0
	
	if control_direction.x != 0:
		velocity.x = move_toward(velocity.x, control_direction.x * surface_move_speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, decceleration)
	body.velocity = velocity


func aerial_movement(_delta: float) -> void:
	velocity = body.velocity
	
	if control_direction != Vector2.ZERO:
		if constant_speed:
			velocity = control_direction * max_speed
		else:
			velocity = velocity.move_toward(control_direction * max_speed, acceleration)
	else:
		velocity = Vector2.ZERO
	body.velocity = velocity


func start_jump(_delta: float) -> void:
	apply_jump_force(jump_force)


func apply_jump_force(jf: float) -> void:
	if not jump_enabled:
		return
	jumping = true
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
