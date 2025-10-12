class_name StateMachine
extends Node

var current_state: State

func change_state(new_state: State):
    if current_state:
        current_state.exit()
    current_state = new_state
    current_state.enter()

func _process(delta: float):
    current_state.update(delta)

func _physics_process(delta: float):
    current_state.physics_update(delta)

func _input(event: InputEvent):
    current_state.input(event)