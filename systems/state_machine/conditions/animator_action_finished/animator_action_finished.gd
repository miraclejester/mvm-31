extends StateMachineCondition
class_name AnimatorActionFinished

@export var animation_controller: ActorAnimationController
@export var action: String

var checking: bool = false
var finished: bool = false

func _ready() -> void:
	animation_controller.action_finished.connect(on_action_finished)


func state_entered() -> void:
	checking = true
	finished = false


func state_exited() -> void:
	checking = false
	finished = false


func evaluate() -> bool:
	return finished


func on_action_finished(action_key: String) -> void:
	if action_key == action:
		finished = true 
