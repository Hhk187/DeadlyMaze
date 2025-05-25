extends Node
class_name InputNode

# Keeps all "action_" 
@export var actions_buffer : InputBuffer 
#var INPUTS_ACTIONS : Array[StringName]

func _ready() -> void:
	actions_buffer.init()

func _unhandled_key_input(event: InputEvent) -> void:
	
	for action in actions_buffer.actions:
		if event.is_action_pressed(action):
			actions_buffer.buffer_input(action)
