extends StateMachineCondition
class_name ConditionInputIsMoving

@export var controller: ActorController
@export var check_horizontal: bool = true
@export var check_vertical: bool = false

func evaluate() -> bool:
	var h: bool = (not check_horizontal) or (controller.direction.x != 0)
	var v: bool = (not check_vertical) or (controller.direction.y != 0)
	return h and v
