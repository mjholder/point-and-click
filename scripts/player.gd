class_name Player
extends CharacterBody2D

@export var state_machine: StateMachine
@export var idle_state: IdleState
@export var walking_state: WalkingState
@export var success_state: SuccessState
var path: PackedVector2Array = []
@export var speed: float = 100
var is_success: bool = false
var is_begin_turn: bool = false

func _ready():
	state_machine.change_state(idle_state)

func _physics_process(delta: float):
	if path.is_empty() or not is_begin_turn:
		return
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
	if is_success:
		state_machine.change_state(success_state)
	else:
		state_machine.change_state(idle_state)

	is_success = false
	is_begin_turn = false
##
## Walk in a given direction
## @param direction The direction to walk in. Can be "forward", "backward", "left", or "right"
##
func walk(direction: String):
	state_machine.change_state(walking_state, {"direction": direction})

func success():
	is_success = true

func idle():
	state_machine.change_state(idle_state)

func begin_turn():
	is_begin_turn = true
