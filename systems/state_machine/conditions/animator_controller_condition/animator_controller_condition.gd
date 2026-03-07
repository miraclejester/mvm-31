extends StateMachineCondition
class_name AnimatorControllerCondition

enum EAnimatorControllerConditionOperation {
	StateFinished
}

@export var animator_controller: ActorAnimationController
@export var operation: EAnimatorControllerConditionOperation
@export var target_state: String

var condition_fulfilled: bool = false

func state_entered() -> void:
	condition_fulfilled = false
	animator_controller.get_playback().state_finished.connect(on_state_finished)


func evaluate() -> bool:
	return condition_fulfilled


func state_exited() -> void:
	condition_fulfilled = false
	animator_controller.get_playback().state_finished.disconnect(on_state_finished)


func on_state_finished(state: String) -> void:
	match operation:
		EAnimatorControllerConditionOperation.StateFinished:
			if state == target_state:
				condition_fulfilled = true
		
