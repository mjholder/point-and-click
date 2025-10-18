extends Node2D

@export var player: Player
@export var level: Level
@export var cat: Cat
@export var pathfinder: Pathfinder

func _input(event):
	if event.is_action_pressed("click"):
		level._reset_board()
		var path = pathfinder.get_path_array(player.global_position, get_global_mouse_position(), 4)
		#level.highlight_path(path)
		var cat_path = pathfinder.get_retreating_path_array(player.global_position, cat.global_position, 3, Vector2i.ZERO)
		#level.highlight_path(cat_path)
		player.set_path(path)
		cat.set_path(cat_path)
	if event.is_action_pressed("reset"):
		level._reset_board()


func _on_cat_captured(_cat: Cat) -> void:
	player.success()
