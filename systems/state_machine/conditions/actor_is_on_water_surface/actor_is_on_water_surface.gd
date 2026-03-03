extends StateMachineCondition
class_name ActorIsOnWaterSurface

@export var movement: ActorMovement

func evaluate() -> bool:
	return (not movement.water_marker_in_water()) and movement.underwater_marker_in_water()
