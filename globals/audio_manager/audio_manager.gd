extends Node2D

@onready var bgm_player: FmodEventEmitter2D = %BGMPlayer

var bgm_initialized: bool = false

func play_bgm(key: String) -> void:
	bgm_player.set_parameter_by_id(4800832153492976375, key)
	if not bgm_initialized:
		bgm_player.play()
		bgm_initialized = true
