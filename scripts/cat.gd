class_name Cat
extends CharacterBody2D

@export var state_machine: StateMachine
@export var idle_state: IdleState
@export var cat_walk_state: CatWalkState
@export var cat_success_state: CatSuccessState
var path: PackedVector2Array = []
@export var speed: float = 100
@export var success_speed: float = 30

signal captured(cat: Cat)
var is_captured: bool = false
var is_at_destination: bool = false
var destination: Vector2 = Vector2.ZERO

func _ready():
	state_machine.change_state(idle_state)
	$CatInteraction.body_entered.connect(_on_player_entered)

func _physics_process(delta: float):
	if is_captured and is_at_destination:
		_on_cat_success_state_complete()
		return
	if path.is_empty():
		return
	is_at_destination = false
	var next_position = path[0]
	var direction = (next_position - global_position).normalized()
	direction.x = round(direction.x)
	direction.y = round(direction.y)

	var direction_string = ""
	if direction.x > 0:
		direction_string = "right"
	elif direction.x < 0:
		direction_string = "left"
	elif direction.y > 0:
		direction_string = "forward"
	elif direction.y < 0:
		direction_string = "backward"

	walk(direction_string)
	velocity = direction * speed
	move_and_slide()

	if global_position.distance_to(path[0]) < 2:
		path.remove_at(0)
		if path.is_empty():
			velocity = Vector2.ZERO
			_on_path_complete()

func set_path(_path: PackedVector2Array):
	path = _path
	
func _on_path_complete():
	is_at_destination = true
	if is_captured:
		_on_cat_success_state_complete()
	else:
		state_machine.change_state(idle_state)
##
## Walk in a given direction
## @param direction The direction to walk in. Can be "forward", "backward", "left", or "right"
##
func walk(direction: String):
	state_machine.change_state(cat_walk_state, {"direction": direction})

func _on_player_entered(body: Node2D):
	if body is Player:
		is_captured = true
		captured.emit(self)

func _on_cat_success_state_complete():
	state_machine.change_state(cat_success_state)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
