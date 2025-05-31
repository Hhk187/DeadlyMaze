extends Resource
class_name BufferedInput


var action : String
var time_msec : float
var end_time_msec : float = 200

func init(new_action : String) -> void:
	action = new_action
	time_msec = Time.get_ticks_msec()
