@tool
extends Node3D

@onready var camera_3d: Camera3D = $Yaw/Pitch/Camera3D
@onready var camera_view_port: Camera3D = $SubViewport/CameraViewPort

func _process(delta: float) -> void:
	_sync_camera()


func _sync_camera():
	camera_view_port.global_position = camera_3d.global_position
	camera_view_port.global_rotation = camera_3d.global_rotation
