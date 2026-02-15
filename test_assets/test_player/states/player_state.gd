@abstract
extends Node
class_name PlayerState

@export var state_id: String

func on_enter(_player: PlayerStateMachine) -> void:
	pass


func on_exit(_player: PlayerStateMachine) -> void:
	pass


func on_process(_player: PlayerStateMachine, _delta: float) -> void:
	pass


func on_physics_process(_player: PlayerStateMachine, _delta: float) -> void:
	pass

#
