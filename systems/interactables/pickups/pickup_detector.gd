extends Area2D
class_name PickupDetector

func _ready() -> void:
	area_entered.connect(on_area_detected)


func on_area_detected(other: Area2D) -> void:
	if other is GamePickup:
		other.pickup()
