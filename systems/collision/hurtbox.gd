extends Area2D
class_name Hurtbox

@export var life: CharacterLife

var invincible: bool = false
var overlapping_boxes: Array[Hitbox]

func hit(hitbox: Hitbox) -> void:
	if not invincible:
		life.deal_damage(hitbox.data.damage)
		overlapping_boxes.append(hitbox)


func left_area(hitbox: Hitbox) -> void:
	overlapping_boxes.erase(hitbox)


func make_invincible() -> void:
	invincible = true


func drop_invincibility() -> void:
	invincible = false
	if overlapping_boxes.size() > 0:
		life.deal_damage(overlapping_boxes[0].data.damage)
