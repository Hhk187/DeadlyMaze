@tool
extends Node3D

var screen_mode = false
var mouse_focus = true

@onready var structures: Node3D = $Structures

@onready var map_gen_manager = $GameLogique/MapGenManager




@export var ClearAll : bool :
	set(value):
		seed(1)
		if map_gen_manager and map_gen_manager.has_method("ClearAll"):
			map_gen_manager.ClearAll()
		
	get():
		return true

@export var GenerateCenterSpawn : bool:
	set(value):
		if map_gen_manager and map_gen_manager.has_method("GenerateCenterSpawn"):
			map_gen_manager.GenerateCenterSpawn()
	get():
		return true

@export var GenerateMazeLayer1 : bool:
	set(value):
		if map_gen_manager and map_gen_manager.has_method("GenerateMazeLayer1"):
			map_gen_manager.GenerateMazeLayer1()
	get():
		return true



func _ready():
	if Engine.is_editor_hint(): 
		map_gen_manager.GenerateCenterSpawn()
		return


	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	map_gen_manager.GenerateCenterSpawn()
	map_gen_manager.GenerateMazeLayer1()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# FullScreen Input
	if Engine.is_editor_hint(): return

	if Input.is_action_just_pressed("fullscreen"):
		screen_mode = !screen_mode
		if screen_mode:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else :
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	# Debug (Remove later)
	if Input.is_action_just_pressed("F1"):
		mouse_focus = !mouse_focus
		if mouse_focus:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
