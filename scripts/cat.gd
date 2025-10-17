class_name Cat
extends CharacterBody2D

@export var state_machine: StateMachine
@export var idle_state: IdleState
@export var cat_walk_state: CatWalkState

func _ready():
	state_machine.change_state(idle_state)

func _physics_process(delta: float):
	pass
