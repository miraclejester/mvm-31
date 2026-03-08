extends Area2D
class_name ActorDetector

signal character_detected(character: WorldCharacter)

@export var debug_logs: bool = false

var detected_object: ActorDetectable

func _ready() -> void:
	area_entered.connect(on_area_entered)
	area_exited.connect(on_area_exited)

func on_area_entered(other: Area2D) -> void:
	if other is ActorDetectable:
		if debug_logs:
			print("Detected actor")
		detected_object = other
		character_detected.emit()


func on_area_exited(other: Area2D) -> void:
	if other == detected_object:
		detected_object = null


func has_detected_character() -> bool:
	return detected_object != null


func get_vector_to_target() -> Vector2:
	if detected_object == null:
		return Vector2.ZERO
	return detected_object.global_position - global_position
