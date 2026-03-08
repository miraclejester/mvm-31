extends Node
class_name CharacterLife

signal damage_dealt(amount: int)
signal died()
signal hurt()
signal life_changed(current: int)

@onready var on_hurt_parent: Node = %OnHurt

@export var starting_max_life: int = 3
@export var debug_logs: bool = false

var max_life: int
var life: int
var on_hurt_behaviour: ActorBehaviour = null

func _ready() -> void:
	max_life = starting_max_life
	life = starting_max_life
	if on_hurt_parent.get_child_count() >= 1:
		on_hurt_behaviour = on_hurt_parent.get_child(0) as ActorBehaviour


func is_dead() -> bool:
	return life <= 0


func set_life(val: int) -> void:
	life = clamp(val, 0, max_life)
	life_changed.emit(life)


func deal_damage(amount: int) -> void:
	set_life(life - amount)
	damage_dealt.emit(amount)
	if debug_logs:
		print("%s received %d damage. Life left: %d" % [get_parent().name, amount, life])
	if life <= 0:
		died.emit()
	else:
		on_hurt()


func on_hurt() -> void:
	hurt.emit()
	if on_hurt_behaviour != null:
		on_hurt_behaviour.run(0)


func heal_damage(amount: int) -> void:
	set_life(life + amount)
