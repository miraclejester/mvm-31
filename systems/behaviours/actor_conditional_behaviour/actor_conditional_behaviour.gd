extends ActorBehaviour
class_name ActorConditionalBehaviour

@onready var condition_parent: Node = %Condition
@onready var behaviour_parent: Node = %Behaviour

var condition: StateMachineCondition
var behaviour: ActorBehaviour

func _ready() -> void:
	condition = condition_parent.get_child(0) as StateMachineCondition
	behaviour = behaviour_parent.get_child(0) as ActorBehaviour


func run(delta: float) -> void:
	if condition.evaluate():
		behaviour.run(delta)
