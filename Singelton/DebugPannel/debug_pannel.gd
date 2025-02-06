extends Control

@onready var v_box_container: VBoxContainer = $MarginContainer/PanelContainer/VBoxContainer

var debug_dict : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add("Fps")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update("Fps", Engine.get_frames_per_second())


func add(key, value = null):
	var label = Label.new()
	label.add_theme_font_size_override("font_size", 18)
	label.add_theme_color_override("font_color", Color(0,1,0))
	v_box_container.add_child(label)
	
	debug_dict[key] = label
	
	update(key, label)

func update(key, value):
	debug_dict[key].text = str(key) + " : " + str(value)

func remove(key):
	debug_dict.erase(key)
