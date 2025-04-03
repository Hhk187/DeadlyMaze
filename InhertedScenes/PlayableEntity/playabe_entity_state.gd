extends Node
class_name PlayableEntityState

var playable_entity : PlaybleEntity

@onready var camera_3d : Camera3D 

func init(node : PlaybleEntity):
	playable_entity = node
	camera_3d = playable_entity.camera_3d

@export var is_controlled : bool = false 
	#set(value):
		#if not camera_3d : return
		#is_controlled = value
		#if value:
			#camera_3d.make_current()
		#else:
			#camera_3d.clear_current()
