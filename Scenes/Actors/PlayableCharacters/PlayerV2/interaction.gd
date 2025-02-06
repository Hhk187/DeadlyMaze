class_name PlayerInteractions
extends Node

var parent : PlayableCharacter

func init(node):
	self.parent = node


func update(delta : float):
	CheckForInteractions()


func CheckForInteractions():
	# Chacking if colliding or its not null, very important
	if !parent.camera_ray_cast.is_colliding() or !parent.camera_ray_cast.get_collider(): 
		parent.stats.POSSIBLE_INTERCATION = BaseEntityStats.POSSIBLE_INERACTION_TYPE.NONE
		return

	# Checking if its interactible
	if !parent.camera_ray_cast.get_collider().is_in_group("Interact"):
		parent.stats.POSSIBLE_INTERCATION = BaseEntityStats.POSSIBLE_INERACTION_TYPE.NONE
		return
	# Checking type
	if parent.camera_ray_cast.get_collider().is_in_group("Weapon"):
		parent.stats.POSSIBLE_INTERCATION = BaseEntityStats.POSSIBLE_INERACTION_TYPE.CAN_PICKUP_WEAPON

	elif parent.camera_ray_cast.get_collider().is_in_group("Item"):
		parent.stats.POSSIBLE_INTERCATION = BaseEntityStats.POSSIBLE_INERACTION_TYPE.CAN_PICKUP_ITEM
