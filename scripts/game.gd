extends Node2D

@export var player: Player
@export var level: Level
@export var cat: Area2D

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("click"):
		var mouse_pos = get_global_mouse_position()
		level.onClick(mouse_pos)
	if event.is_action_pressed("reset"):
		level._reset_board()