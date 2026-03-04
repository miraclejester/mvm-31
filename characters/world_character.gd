extends CharacterBody2D
class_name WorldCharacter

@onready var state_machine: ActorStateMachine = %ActorStateMachine
@onready var behaviours_parent: Node = %Behaviours

var behaviours: Array[ActorBehaviour] = []

func _ready() -> void:
	behaviours.assign(behaviours_parent.get_children())
	state_machine.run()


func _process(delta: float) -> void:
	for behaviour in behaviours:
		behaviour.try_run(delta)


func _physics_process(delta: float) -> void:
	for behaviour in behaviours:
		behaviour.try_run_physics(delta)
