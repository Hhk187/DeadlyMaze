extends Node3D

var screen_mode = false
var mouse_focus = true


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
#	FullScreen Input
	if Input.is_action_pressed("fullscreen"):
		screen_mode = !screen_mode
		if screen_mode:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else :
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

#	Debug (Remove later)
	if Input.is_action_pressed("alt"):
		mouse_focus = !mouse_focus
		if mouse_focus:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
