class_name Cat
extends CharacterBody2D

@export var state_machine: StateMachine
@export var idle_state: IdleState
@export var cat_walk_state: CatWalkState
var path: PackedVector2Array = []
@export var speed: float = 100

func _ready():
	state_machine.change_state(idle_state)

func _physics_process(delta: float):
	if path.is_empty():
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
	state_machine.change_state(idle_state)
##
## Walk in a given direction
## @param direction The direction to walk in. Can be "forward", "backward", "left", or "right"
##
func walk(direction: String):
	state_machine.change_state(cat_walk_state, {"direction": direction})
