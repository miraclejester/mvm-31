extends Node2D

@onready var bgm_player: FmodEventEmitter2D = %BGMPlayer

var bgm_initialized: bool = false


func _ready() -> void:
	GameManager.world_set.connect(set_signals)


func play_bgm(key: String) -> void:
	bgm_player.set_parameter_by_id(4800832153492976375, key)
	bgm_player.set_parameter_by_id(8004776284960007233, 0)
	if not bgm_initialized:
		bgm_player.play()
		bgm_initialized = true


func set_signals() -> void:
	GameManager.current_world.entered_water.connect(on_entered_water)
	GameManager.current_world.exited_water.connect(on_exited_water)


func on_entered_water() -> void:
	bgm_player.set_parameter_by_id(8004776284960007233, 1)


func on_exited_water() -> void:
	bgm_player.set_parameter_by_id(8004776284960007233, 0)
