extends Node2D

@onready var bgm_player: FmodEventEmitter2D = %BGMPlayer

func play_bgm(key: String) -> void:
	bgm_player.event_guid = key
	bgm_player.play(false)
