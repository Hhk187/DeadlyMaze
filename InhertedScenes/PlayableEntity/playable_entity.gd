@tool
extends CharacterBody3D
class_name PlaybleEntity

@onready var data: PlayableEntityData = $Data
@onready var input: PlayableEntityInput = $Input
@onready var state: PlayableEntityState = $State


@onready var yaw: Node3D = $Yaw
@onready var pitch: Node3D = $Yaw/Pitch

@onready var camera_3d: Camera3D = $Yaw/Pitch/Camera3D

@onready var sub_viewport: SubViewport = $SubViewport
@onready var camera_view_port: Camera3D = $SubViewport/CameraViewPort

func _ready() -> void:
	if Engine.is_editor_hint() : return
	input.init(self)
	state.init(self)


func _physics_process(delta: float) -> void:
	_sync_camera()
	if Engine.is_editor_hint() : return
	input.update(delta)
	
	# Add the gravityz.
	if not is_on_floor() and not data.is_brain:
		velocity += get_gravity() * delta

	move_and_slide()


func _sync_camera():
	camera_view_port.global_position = camera_3d.global_position
	camera_view_port.global_rotation = camera_3d.global_rotation
