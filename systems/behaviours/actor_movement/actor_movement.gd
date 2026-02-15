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
@export var jump_force = -700
@export var jump_started: bool = false

var velocity: Vector2

func _ready() -> void:
	body.floor_snap_length = floor_snap_length
	body.up_direction = Vector2.UP
	body.floor_constant_speed = true


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
	
	if body.is_on_floor():
		jump_started = false


func start_jump(_delta: float) -> void:
	if not jump_started:
		jump_started = true
		apply_jump_force(jump_force)


func apply_jump_force(jf: float) -> void:
	velocity = body.velocity
	velocity.y = jf
	body.velocity = velocity
