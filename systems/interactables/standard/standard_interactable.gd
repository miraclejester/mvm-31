extends Area2D
class_name StandardInteractable

@export var valid_actions: Array[String]

@onready var interact_parent: Node = %InteractBehaviour
@onready var enter_parent: Node = %EnterBehaviour
@onready var exit_parent: Node = %ExitBehaviour
@onready var setup_parent: Node = %SetupBehaviour

var interact_behaviour: ActorBehaviour
var enter_behaviour: ActorBehaviour
var exit_behaviour: ActorBehaviour
var setup_behaviour: ActorBehaviour

func _ready() -> void:
	if interact_parent.get_child_count() >= 1:
		interact_behaviour = interact_parent.get_child(0) as ActorBehaviour
	if enter_parent.get_child_count() >= 1:
		enter_behaviour = enter_parent.get_child(0) as ActorBehaviour
	if exit_parent.get_child_count() >= 1:
		exit_behaviour = exit_parent.get_child(0) as ActorBehaviour
	if setup_parent.get_child_count() >= 1:
		setup_behaviour = setup_parent.get_child(0) as ActorBehaviour
		setup_behaviour.run(0)


func interact() -> void:
	if interact_behaviour != null:
		interact_behaviour.run(0)


func receive_action(action: String) -> void:
	if action in valid_actions:
		interact()


func enter() -> void:
	if enter_behaviour != null:
		enter_behaviour.run(0)


func exit() -> void:
	if exit_behaviour != null:
		exit_behaviour.run(0)
