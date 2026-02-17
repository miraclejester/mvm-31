extends Node2D
class_name ProjectileEmitter

@export var emitter_data: ProjectileEmitterData

@onready var muzzle: Marker2D = %Muzzle
@onready var fire_rate_timer: Timer = %FireRateTimer

var can_fire: bool = true

func _ready() -> void:
	fire_rate_timer.timeout.connect(on_fire_rate_timer_timeout)


func fire_projectile():
	if not can_fire:
		return
	var projectile: Projectile = emitter_data.projectile_scene.instantiate() as Projectile
	
	var data: ProjectileShotData = ProjectileShotData.new()
	data.projectile = projectile
	data.position = muzzle.global_position
	data.direction = Vector2.RIGHT * sign(global_scale.y)
	projectile.initialize(emitter_data, data)
	
	EventBroadcaster.emit_projectile_shot(data)
	can_fire = false
	fire_rate_timer.start(emitter_data.fire_rate)


func on_fire_rate_timer_timeout() -> void:
	can_fire = true
