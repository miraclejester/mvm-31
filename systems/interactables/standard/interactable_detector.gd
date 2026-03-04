extends Area2D
class_name InteractableDetector

@export var controller: ActorController

var tracked_interactables: Array[StandardInteractable] = []

func _ready() -> void:
	controller.action_just_pressed.connect(send_action)
	GameManager.world_set.connect(on_world_set)
	area_entered.connect(on_area_entered)
	area_exited.connect(on_area_exited)


func on_area_entered(other: Area2D) -> void:
	if other is StandardInteractable:
		other.enter()
		tracked_interactables.append(other)


func on_area_exited(other: Area2D) -> void:
	if other is StandardInteractable:
		other.exit()
		tracked_interactables.erase(other)


func send_action(action: String) -> void:
	for interactable in tracked_interactables:
		interactable.receive_action(action)


func on_room_load_started(_next_room: GameWorldRoomData) -> void:
	reset_tracking()


func on_world_set() -> void:
	GameManager.current_world.room_load_started.connect(on_room_load_started)


func reset_tracking() -> void:
	tracked_interactables = []
