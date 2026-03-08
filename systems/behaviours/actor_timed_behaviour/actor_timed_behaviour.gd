extends ActorBehaviour
class_name ActorTimedBehaviour

@export var running_rate: float = 1

@onready var behaviour_parent: Node = %Behaviour
@onready var timer: Timer = %Timer

var behaviour: ActorBehaviour
var action_available: bool;

func _ready() -> void:
	behaviour = behaviour_parent.get_child(0) as ActorBehaviour
	action_available = true
	timer.timeout.connect(on_timeout)


func run(delta: float) -> void:
	if action_available:
		action_available = false
		timer.start(running_rate)
		behaviour.run(delta)


func on_timeout() -> void:
	action_available = true
