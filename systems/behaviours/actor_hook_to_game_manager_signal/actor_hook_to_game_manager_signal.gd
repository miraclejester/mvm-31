extends ActorBehaviour
class_name ActorHookToGameManagerSignal

enum EHookedSignal {
	GameSaved,
	WorldSet
}

@export var hooked_signal: EHookedSignal

var action_to_run: ActorBehaviour


func _ready() -> void:
	action_to_run = get_child(0) as ActorBehaviour
	match hooked_signal:
		EHookedSignal.GameSaved:
			GameManager.game_saved.connect(on_signal_emitted)
		EHookedSignal.WorldSet:
			GameManager.game_saved.connect(on_signal_emitted)


func on_signal_emitted() -> void:
	action_to_run.run(0)
