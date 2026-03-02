extends Node2D
class_name FootstepsPlayer

@onready var sfx_manager: LocalSFXManager = %LocalSFXManager

func play_footstep_sound() -> void:
	var layer: TileMapLayer = GameManager.current_world.current_room.get_map_layer(Strings.ROOM_LAYER_TERRAIN)
	if layer == null:
		return
	var tile_data: TileData = layer.get_cell_tile_data(layer.local_to_map(global_position))
	if tile_data == null:
		return
	var sound_key: String = tile_data.get_custom_data("step_sound")
	if sound_key != null and (not sound_key.is_empty()):
		sfx_manager.play_quick_sfx(sound_key)
