extends StateMachineCondition
class_name ActorDetectorCondition

enum EDetectorOperation {
	HasCharacter,
	DistanceIsLessThanXY
}

@export var detector: ActorDetector
@export var operation: EDetectorOperation

func evaluate() -> bool:
	return detector.has_detected_character()
