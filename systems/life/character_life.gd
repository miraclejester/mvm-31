extends Node
class_name CharacterLife

signal damage_dealt(amount: int)
signal died()
signal life_changed(current: int)

@export var starting_max_life: int = 3

var max_life: int = starting_max_life
var life: int = starting_max_life

func is_dead() -> bool:
	return life <= 0


func set_life(val: int) -> void:
	life = clamp(val, 0, max_life)
	life_changed.emit(life)


func deal_damage(amount: int) -> void:
	set_life(life - amount)
	damage_dealt.emit(amount)
	print("%s received %d damage" % [get_parent().name, amount])
	if life <= 0:
		print("%s died" % [get_parent().name])
		died.emit()


func heal_damage(amount: int) -> void:
	set_life(life + amount)
