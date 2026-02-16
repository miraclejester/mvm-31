extends Area2D
class_name DoorwayDetector

func _ready() -> void:
	area_entered.connect(on_area_detected)
	
func on_area_detected(other: Area2D) -> void:
	if other is Doorway:
		other.trigger_door()
