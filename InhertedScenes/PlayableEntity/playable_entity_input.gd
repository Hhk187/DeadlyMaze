extends Node
class_name PlayableEntityInput

var playable_entity : PlaybleEntity
var data : PlayableEntityData

var _yaw : Node3D
var _pitch : Node3D

func init(node : PlaybleEntity):
	playable_entity = node
	data = playable_entity.data
	_yaw = node.yaw
	_pitch = node.pitch

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		playable_entity.rotate_y((-event.relative.x * 0.001)* data.sens * 0.5)
		_pitch.rotate_x((-event.relative.y * 0.001)* data.sens)

func  _ready() -> void:
	Input.mouse_mode = Input.MouseMode.MOUSE_MODE_CAPTURED

func update():
	pass
