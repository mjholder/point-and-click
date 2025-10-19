class_name SuccessState
extends State

@export var animated_sprite: AnimatedSprite2D
@export var animation_name: String = "success"

func enter(options: Dictionary = {}):
	animated_sprite.play(animation_name)

func exit():
	animated_sprite.stop()

func update(delta: float):
	pass

func physics_update(delta: float):
	pass
