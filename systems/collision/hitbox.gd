extends Area2D
class_name Hitbox

@export var data: HitboxData
@export var disable_on_ready: bool = false

@onready var collider: CollisionShape2D = %Collider

func _ready() -> void:
	area_entered.connect(on_area_entered)
	area_exited.connect(on_area_exited)
	if disable_on_ready:
		set_collider_enabled(false)


func on_area_entered(other: Area2D) -> void:
	if other is Hurtbox:
		other.hit(self)


func on_area_exited(other: Area2D) -> void:
	if other is Hurtbox:
		other.left_area(self)


func set_collider_enabled(enabled: bool) -> void:
	collider.disabled = not enabled
