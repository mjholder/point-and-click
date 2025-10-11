extends Node
class_name Pathfinder
var astar: AStar2D = AStar2D.new()
@export var level: Level

func _ready():
	_build_astar()

func _cell_to_id(cell: Vector2) -> int:
	return int(cell.x) + int(cell.y) * 100

func _build_astar():
	astar.clear()
	
	for cell in level.map.get_used_cells():
		var id = _cell_to_id(cell)
		astar.add_point(id, level.map.map_to_local(cell))

	for cell in level.map.get_used_cells():
		var id = _cell_to_id(cell)
		for dir in [
			Vector2i(1, 0), Vector2i(-1, 0),
			Vector2i(0, 1), Vector2i(0, -1)
		]:
			var neighbor = cell + dir
			if level.map.get_cell_source_id(neighbor) != -1:
				var neighbor_id = _cell_to_id(neighbor)
				if astar.has_point(neighbor_id):
					astar.connect_points(id, neighbor_id)

func get_path_array(start: Vector2, end: Vector2) -> PackedVector2Array:
	var start_tile = level.map.local_to_map(start)
	var end_tile = level.map.local_to_map(end)
	var start_id = _cell_to_id(start_tile)
	var end_id = _cell_to_id(end_tile)
	return astar.get_point_path(start_id, end_id)
