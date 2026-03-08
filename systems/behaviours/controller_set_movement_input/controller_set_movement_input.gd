extends ActorBehaviour
class_name ControllerSetMovementInput

enum EMovementOperation {
	Direct,
	ToTarget,
	Stop,
	ToStaticPosition
}

@export var controller: ActorController
@export var input: Vector2
@export var operation: EMovementOperation
@export var source: ActorRetriever
@export var target: ActorRetriever
@export var static_target: StaticPositionRetriever

func run(_delta: float) -> void:
	match operation:
		EMovementOperation.ToStaticPosition:
			var s: Node2D = source.get_actor()
			if s == null:
				return
			controller.set_movement_input(s.global_position.direction_to(static_target.get_cached_position()))
		EMovementOperation.Stop:
			controller.set_movement_input(Vector2.ZERO)
			controller.direction = Vector2.ZERO
		EMovementOperation.Direct:
			controller.set_movement_input(input)
		EMovementOperation.ToTarget:
			var s: Node2D = source.get_actor()
			var t: Node2D = target.get_actor()
			if (s == null) or (t == null):
				return
			controller.set_movement_input(s.global_position.direction_to(t.global_position))
