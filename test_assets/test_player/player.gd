extends CharacterBody2D
class_name Player

@onready var animations: AnimatedSprite2D = %Animations
@onready var state_machine: ActorStateMachine = %ActorStateMachine

func _ready() -> void:
	state_machine.context = self
	state_machine.run()
