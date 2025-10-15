class_name WalkingState
extends State

@export var animated_sprite: AnimatedSprite2D
@export var forward_animation: String = "forward"
@export var backward_animation: String = "backward"
@export var sideways_animation: String = "sideways"

func enter(options: Dictionary = {}):
	var direction = options.get("direction")
	if direction == "forward":
		animated_sprite.play(forward_animation)
	elif direction == "backward":
		animated_sprite.play(backward_animation)
	elif direction == "left":
		animated_sprite.flip_h = true
		animated_sprite.play(sideways_animation)
	elif direction == "right":
		animated_sprite.flip_h = false
		animated_sprite.play(sideways_animation)

func exit():
	animated_sprite.stop()

func update(delta: float):
	pass

func physics_update(delta: float):
	pass
