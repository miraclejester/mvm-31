extends Node
class_name InvincibilityTimer

@export var hurtbox: Hurtbox
@export var life: CharacterLife
@export var invincibility_time: float = 1

@onready var timer: Timer = %Timer


func _ready() -> void:
	life.damage_dealt.connect(on_damage_dealt)
	timer.timeout.connect(on_timeout)


func on_damage_dealt(_amount: int) -> void:
	if not life.is_dead():
		hurtbox.make_invincible()
		timer.start(invincibility_time)


func on_timeout() -> void:
	hurtbox.drop_invincibility()
