extends Node3D


var parent : PlayableCharacter

func init(node):
	self.parent = node


func UpdateLeftHandPos():
	if get_children():
		var item = get_child(0)
		var target : Marker3D = item.get_node("LeftHandTarget")
		parent.ik_left_hand_target.global_position = target.global_position
		parent.ik_left_hand_target.global_rotation = target.global_rotation
