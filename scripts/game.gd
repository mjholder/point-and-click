extends Node2D

@export var player: Player
@export var level: Level
@export var cat: Cat
@export var pathfinder: Pathfinder

@export var player_distance: int = 4
@export var cat_distance: int = 3

func _input(event):
	if event.is_action_pressed("click"):
		if not pathfinder.is_valid_cell(level.map.local_to_map(level.map.to_local(get_global_mouse_position()))):
			return
		level._reset_board()
		var path = pathfinder.get_path_array(player.global_position, get_global_mouse_position(), player_distance)
		level.highlight_path(path)
		var cat_path = pathfinder.get_retreating_path_array(player.global_position, cat.global_position, cat_distance, Vector2i.ZERO)
		level.highlight_path(cat_path)
		player.set_path(path)
		cat.set_path(cat_path)
	if event.is_action_pressed("reset"):
		level._reset_board()


func _on_cat_captured(_cat: Cat) -> void:
	player.success()


func _on_end_turn_button_pressed() -> void:
	player.begin_turn()
	cat.begin_turn()
