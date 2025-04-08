extends Node
class_name PlayableEntityData

func _updateSettings():
	pass

@export var is_brain : bool = false # set the camera so it doesnt render brain room

@export var og_speed : float
@export var run_speed : float

@export var health : int 
var speed : float
func _ready() -> void:
	speed = og_speed

@export var jump_vel : float
