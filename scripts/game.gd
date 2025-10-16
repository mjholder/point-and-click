extends Node2D

@export var player: Player
@export var level: Level
@export var cat: Area2D
@export var pathfinder: Pathfinder

func _input(event):
	if event.is_action_pressed("click"):
		level._reset_board()
		var path = pathfinder.get_path_array(player.global_position, get_global_mouse_position())
		level.highlight_path(path)
		var cat_path = pathfinder.get_retreating_path_array(player.global_position, cat.global_position, 3)
		level.highlight_path(cat_path)
		player.set_path(path)
	if event.is_action_pressed("reset"):
		level._reset_board()
