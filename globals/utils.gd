extends Node

func switch_child(child: Node, new_parent: Node) -> void:
	child.get_parent().remove_child(child)
	new_parent.add_child(child)

func get_tile_at(layer_key: String, position: Vector2) -> TileData:
	var layer: TileMapLayer = GameManager.current_world.current_room.get_map_layer(layer_key)
	if layer == null:
		return null
	return layer.get_cell_tile_data(layer.local_to_map(position))
