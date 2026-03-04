extends StateMachineCondition
class_name MarkerIsOnTerrain

@export var marker: Node2D

func evaluate() -> bool:
	var tile: TileData = Utils.get_tile_at(Strings.ROOM_LAYER_TERRAIN, marker.global_position)
	return tile != null
