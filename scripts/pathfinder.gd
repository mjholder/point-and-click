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

func get_path_array(start: Vector2, end: Vector2, distance: int) -> PackedVector2Array:
	var start_tile = level.map.local_to_map(start)
	var end_tile = level.map.local_to_map(end)
	var start_id = _cell_to_id(start_tile)
	var end_id = _cell_to_id(end_tile)
	var path = astar.get_point_path(start_id, end_id)
	if distance > path.size():
		return path
	else:
		return path.slice(0, distance)

func get_retreating_path_array(target: Vector2, current: Vector2, distance: int, previous_direction: Vector2i) -> PackedVector2Array:
	var neighbors = [
		Vector2i(1, 0), Vector2i(-1, 0),
		Vector2i(0, 1), Vector2i(0, -1)
	]
	var current_tile = level.map.local_to_map(current)
	var max_distance = 0
	var furthest_neighbor = current_tile
	var furthest_neighbor_direction = Vector2i.ZERO
	var path: PackedVector2Array = []
	if distance > 0:
		for neighbor in neighbors:
			var neighbor_tile = current_tile + neighbor
			if level.map.get_cell_source_id(neighbor_tile) != -1:
				var new_distance = _calculate_distance(target, level.map.map_to_local(neighbor_tile))
				print("current", current_tile, "target", level.map.local_to_map(target), "neighbor", neighbor_tile, "new_distance", new_distance)
				if is_reversing(neighbor, previous_direction):
					continue
				elif new_distance > max_distance:
					max_distance = new_distance
					furthest_neighbor = neighbor_tile
				elif new_distance == max_distance and neighbor != previous_direction:
					furthest_neighbor_direction = neighbor
					furthest_neighbor = neighbor_tile
		print(furthest_neighbor, " is the furthest neighbor from ", level.map.local_to_map(target), " at distance ", max_distance)
		path.append(level.map.map_to_local(furthest_neighbor))
		path.append_array(get_retreating_path_array(target, level.map.map_to_local(furthest_neighbor), distance - 1, furthest_neighbor_direction))
		print(path)
		return path
	else:
		path.append(current)
		return path

func is_reversing(direction: Vector2i, previous_direction: Vector2i) -> bool:
	return direction + previous_direction == Vector2i.ZERO

func _calculate_distance(target: Vector2, current: Vector2) -> int:
	return abs(target.x - current.x) + abs(target.y - current.y)
