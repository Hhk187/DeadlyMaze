extends Node



@export var sens : float = 2.0

var _mouse_mode : bool = true
var _full_screen : bool = true


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("fullscreen"):
			_toggle_fulllscreen()
	
		if event.is_action_pressed("F1"):
			_toggle_mouse_mode()

func _toggle_fulllscreen():
	_full_screen = !_full_screen
	if _full_screen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _toggle_mouse_mode():
	_mouse_mode = !_mouse_mode
	if _mouse_mode:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
