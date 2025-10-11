extends Node2D

@export var player: Player
@export var level: Level
@export var cat: Area2D
@export var pathfinder: Pathfinder

func _input(event):
	if event.is_action_pressed("click"):
		level._reset_board()
		level.highlight_path(pathfinder.get_path_array(player.global_position, get_global_mouse_position()))
	if event.is_action_pressed("reset"):
		level._reset_board()
