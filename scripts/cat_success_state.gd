class_name CatSuccessState
extends State
@export var animated_sprite: AnimatedSprite2D
@export var animation_name: String = "idle"
@export var animation_player: AnimationPlayer
@export var success_animation: String = "success"

func enter(options: Dictionary = {}):
	animated_sprite.play(animation_name)
	animated_sprite.speed_scale = 1.5
	animated_sprite.rotation_degrees = 0
	animation_player.play(success_animation)
func exit():
	animated_sprite.stop()

func update(delta: float):
	pass

func physics_update(delta: float):
	pass
