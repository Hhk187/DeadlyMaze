extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	open()

func open():
	animation_player.play('open')
func close():
	animation_player.play('close')
