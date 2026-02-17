extends BoolRetriever
class_name ActorTileBoolRetriever

@export var actor: Node2D
@export var key: String

func retrieve_bool() -> bool:
	var layer: TileMapLayer = GameManager.current_world.current_room.near_foreground_layer
	if layer == null:
		return false
	var tile_data: TileData = layer.get_cell_tile_data(layer.local_to_map(actor.global_position))
	return tile_data != null and tile_data.get_meta(key, false)
