extends Area2D
class_name Hitbox

@export var data: HitboxData

func _ready() -> void:
	area_entered.connect(on_area_entered)
	area_exited.connect(on_area_exited)


func on_area_entered(other: Area2D) -> void:
	if other is Hurtbox:
		other.hit(self)


func on_area_exited(other: Area2D) -> void:
	if other is Hurtbox:
		other.left_area(self)
