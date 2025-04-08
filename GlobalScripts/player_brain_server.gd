extends Node

signal pov_changed(pov)

var PlayerTV : PlayerTV
var PlayerBrain : PlayerBrain
var Other : PlaybleEntity

enum POV_TYPE {BRAIN, TV, OTHER}
var last_pov : POV_TYPE = POV_TYPE.BRAIN
var current_pov : POV_TYPE = POV_TYPE.BRAIN :
	set(value):
		if current_pov != value:
			last_pov = current_pov
			current_pov = value
			emit_signal("pov_changed", current_pov)

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("switch_between_pov"):
			if self.PlayerTV and self.PlayerBrain:
				# The pov would switch to brain/tv
				match current_pov:
					POV_TYPE.BRAIN:
						_switch_pov_to_tv()
					POV_TYPE.TV:
						_switch_pov_to_brain()
					POV_TYPE.OTHER:
						pass
					_:
						printerr(name + " : a new POV_TYPE was found, this souldn't happen")
			else:
				printerr(name + " : player or tv arent initilized correctly")

func _switch_pov_to_tv():
	current_pov = POV_TYPE.TV
	self.PlayerBrain.SetInControl(false)
	self.PlayerTV.SetInControl(true)

func _switch_pov_to_brain():
	current_pov = POV_TYPE.BRAIN
	self.PlayerBrain.SetInControl(true)
	self.PlayerTV.SetInControl(false)
