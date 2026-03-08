extends ActorRetriever
class_name DetectorActorRetriever

@export var detector: ActorDetector

func get_actor() -> Node2D:
	return detector.detected_object
