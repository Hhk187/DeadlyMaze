extends Node
class_name EntityInputNode

# Keeps all "action_" 
@export var actions_input_buffer : InputBuffer 

func _ready() -> void:
	actions_input_buffer.init()

func _unhandled_key_input(event: InputEvent) -> void:
	for action in actions_input_buffer.actions:
		if event.is_action_pressed(action):
			actions_input_buffer.buffer_input(action)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		pass
		#-event.relative.x * 0.001 * PlayerSettings.sens * 0.5
		#-event.relative.y * 0.001 * PlayerSettings.sens
		#playable_entity.rotate_y((-event.relative.x * 0.001)* PlayerSettings.sens * 0.5)
		#_pitch.rotate_x((-event.relative.y * 0.001)* PlayerSettings.sens)

func _physics_process(delta: float) -> void:
	actions_input_buffer.physics_process()
