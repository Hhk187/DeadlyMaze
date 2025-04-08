extends Node
class_name PlayableEntityInput

var playable_entity : PlaybleEntity
var data : PlayableEntityData
var state : PlayableEntityState

var _yaw : Node3D
var _pitch : Node3D

func init(node : PlaybleEntity):
	playable_entity = node
	data = playable_entity.data
	state = playable_entity.state
	_yaw = node.yaw
	_pitch = node.pitch

func _input(event: InputEvent) -> void:
	if not state.is_controlled: return
	if event is InputEventMouseMotion:
		playable_entity.rotate_y((-event.relative.x * 0.001)* PlayerSettings.sens * 0.5)
		_pitch.rotate_x((-event.relative.y * 0.001)* PlayerSettings.sens)


func update(_delta : float) -> void:
	if not state.is_controlled: return


	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and playable_entity.is_on_floor():
		playable_entity.velocity.y = data.jump_vel

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("strafe_left", "strafe_right", "forward", "backword")
	var direction := (playable_entity.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		playable_entity.velocity.x = lerp(direction.x, direction.x * data.speed, 0.1)
		playable_entity.velocity.z = lerp(direction.z, direction.z * data.speed, 0.1)
	else:
		playable_entity.velocity.x = lerp(playable_entity.velocity.x, 0.0, 0.3)
		playable_entity.velocity.z = lerp(playable_entity.velocity.z, 0.0, 0.3)
