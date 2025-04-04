@tool
extends Node3D
class_name BaseMonitor

@onready var sprite_3d: Sprite3D = $Sprite3D
@onready var back_hidder: MeshInstance3D = $BackHidder

@onready var sub_viewport_container: SubViewportContainer = $SubViewportContainer
@onready var sub_viewport: SubViewport = $SubViewportContainer/SubViewport
@onready var label: Label = $SubViewportContainer/SubViewport/Label

@export var frame : bool = false :
	set(value):
		_updateFrame()

@export var size : Vector2 = Vector2(50, 50) :
	set(value):
		size = value
		sub_viewport_container.size = value
		if frame:
			_updateFrame()

func _updateFrame():
	back_hidder.mesh.set("size", Vector3(size.x * 0.01, size.y * 0.01, 0.01))
