extends ActorBehaviour
class_name ActorMovement

@export_group("References")
@export var body: CharacterBody2D
@export var controller: ActorController

@export_group("Movement")
@export var acceleration: float = 20
@export var max_speed: float = 280
@export var gravity: Vector2 = Vector2(0, 1500)
@export var floor_snap_length: float = 5
@export var friction_factor: float = 0.8

@export_group("Jump")
@export var jump_action_key: String = "jump"
@export var jump_force: float = -700
@export var jump_threshold: float = -200
@export var cut_jump_force: float = -320

var velocity: Vector2

func _ready() -> void:
	body.floor_snap_length = floor_snap_length
	body.up_direction = Vector2.UP
	body.floor_constant_speed = true
	controller.action_just_released.connect(on_controller_just_released)


func run_physics(delta: float) -> void:
	move(delta)


func apply_gravity(delta: float) -> void:
	if not body.is_on_floor():
		velocity += gravity * delta

func move(delta: float) -> void:
	velocity = body.velocity
	apply_gravity(delta)
	
	if controller.direction != Vector2.ZERO:
		velocity.x = move_toward(velocity.x, controller.direction.x * max_speed, acceleration)
	elif body.is_on_floor():
		velocity.x = move_toward(velocity.x, 0, max_speed * friction_factor)
	body.velocity = velocity
	body.move_and_slide()


func start_jump(_delta: float) -> void:
	apply_jump_force(jump_force)


func apply_jump_force(jf: float) -> void:
	velocity = body.velocity
	velocity.y = jf
	body.velocity = velocity


func on_controller_just_released(key: String) -> void:
	if not enabled:
		return
	if key == jump_action_key and body.velocity.y < jump_threshold:
		apply_jump_force(cut_jump_force)
