extends StateMachineCondition
class_name ActorLifeCondition

enum ECheckOperation {
	IsHurt,
	IsDead
}

@export var life: CharacterLife
@export var operation: ECheckOperation

var condition_fulfilled: bool = false


func state_entered() -> void:
	condition_fulfilled = false
	life.hurt.connect(on_hurt)
	life.died.connect(on_dead)


func evaluate() -> bool:
	return condition_fulfilled


func state_exited() -> void:
	condition_fulfilled = false
	life.hurt.disconnect(on_hurt)
	life.died.disconnect(on_dead)


func on_hurt() -> void:
	condition_fulfilled = operation == ECheckOperation.IsHurt


func on_dead() -> void:
	condition_fulfilled = operation == ECheckOperation.IsDead
