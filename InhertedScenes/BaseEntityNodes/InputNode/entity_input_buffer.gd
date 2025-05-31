extends Resource
class_name InputBuffer

const PATH = "res://InhertedScenes/BaseEntityNodes/InputNode/buffered_input.gd"
@export var action_filter : String

var actions : Array[StringName]
var inputs : Array[BufferedInput]


func init() -> void:
	actions = InputMap.get_actions().filter(
		func(a: String): return a.begins_with(action_filter)
	)

func buffer_input(action : StringName):
	var buffered_input : BufferedInput = ResourceLoader.load(PATH).new()
	buffered_input.init(action)
	inputs.append(buffered_input)

func physics_process():
	for i in inputs:
		if i.time_msec + i.end_time_msec <= Time.get_ticks_msec():
			inputs.erase(i)
