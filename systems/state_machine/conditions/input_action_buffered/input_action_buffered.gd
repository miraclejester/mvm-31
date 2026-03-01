extends StateMachineCondition
class_name InputActionBuffered

@export var controller: ActorController
@export var action: String
@export var buffer_time: float

func evaluate() -> bool:
	return controller.action_buffered(action, buffer_time)
