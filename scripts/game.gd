extends Node2D

@export var player: Player
@export var level: Level
@export var cat: Area2D

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var mouse_pos = get_global_mouse_position()
		level.onClick(mouse_pos)
