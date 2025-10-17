class_name CatWalkState
extends State

@export var animated_sprite: AnimatedSprite2D
@export var animation_name: String = "walk"

func enter(options: Dictionary = {}):
	var direction = options.get("direction")
	if direction == "forward":
		animated_sprite.play(animation_name)
		animated_sprite.flip_v = false
		animated_sprite.rotation_degrees = 0
	elif direction == "backward":
		animated_sprite.play(animation_name)
		animated_sprite.flip_v = true
		animated_sprite.rotation_degrees = 0
	elif direction == "left":
		animated_sprite.rotation_degrees = 90
		animated_sprite.play(animation_name)
	elif direction == "right":
		animated_sprite.rotation_degrees = -90
		animated_sprite.play(animation_name)

func exit():
	animated_sprite.stop()

func update(delta: float):
	pass