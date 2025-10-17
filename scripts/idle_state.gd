class_name IdleState
extends State

@export var animated_sprite: AnimatedSprite2D
@export var animation_name: String = "idle"

func enter(options: Dictionary = {}):
	animated_sprite.flip_h = false
	animated_sprite.flip_v = false
	animated_sprite.rotation_degrees = 0
	animated_sprite.play(animation_name)

func exit():
	animated_sprite.stop()

func update(delta: float):
	pass

func physics_update(delta: float):
	pass
