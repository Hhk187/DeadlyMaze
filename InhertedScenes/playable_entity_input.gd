extends Node
class_name PlayableEntityInput

var player_tv : PlaybleEntity
var _yaw : Node3D
var _pitch : Node3D

func init(node : PlaybleEntity):
	player_tv = node
	_yaw = node.yaw
	_pitch = node.pitch

func  _ready() -> void:
	Input.mouse_mode = Input.MouseMode.MOUSE_MODE_CAPTURED

func update():
	pass


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		player_tv.rotate_y(-event.relative.x * player_tv.sens * 0.5)
		_pitch.rotate_x(-event.relative.y * player_tv.sens)
