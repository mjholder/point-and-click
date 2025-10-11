class_name Level    
extends Node2D

@export var map: TileMapLayer
var atlas_coords = Vector2(0, 0)
var TILE: int = 0
var HIGHLIGHT: int = 1
var EMPTY: Vector2 = Vector2(-1, -1)

func _get_tile(coords: Vector2) -> Vector2:
	var cell = map.local_to_map(coords)
	var cell_data = map.get_cell_tile_data(cell)
	if cell_data:
		return cell
	return EMPTY

func onClick(coords: Vector2):
	var tile = _get_tile(coords)
	if tile != EMPTY:
		map.set_cell(tile, HIGHLIGHT, atlas_coords)
			
func _reset_board():
	for tile in map.get_used_cells():
		var source_id = map.get_cell_source_id(tile)
		if source_id == HIGHLIGHT:
			map.set_cell(tile, TILE, atlas_coords)