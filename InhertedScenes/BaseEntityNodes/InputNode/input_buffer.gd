extends Resource
class_name InputBuffer

@export var action_filter : String

var actions : Array[StringName]
var _inputs : Array[Dictionary]


func init() -> void:
	actions = InputMap.get_actions().filter(
		func(a: String): return a.begins_with(action_filter)
	)

func buffer_input(action : StringName):
	_inputs.append({"action" : action, "time" : Time.get_ticks_msec()})

func get_valid_inputs(expire_ms: int = 200) -> Array:
	var now = Time.get_ticks_msec()
	_inputs = _inputs.filter(func(i): return now - i.time < expire_ms)
	return _inputs.map(func(i): return i.action) 

func clear():
	_inputs.clear()
