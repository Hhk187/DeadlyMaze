@tool
class_name PlayerAnimations
extends Node

var parent : PlayableCharacter

func init(node):
	self.parent = node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(delta: float) -> void:
	movement()
	CheckForInteraction()



func EquipOneHandedWeapon():
	parent.animation_tree.set("parameters/RotateShoulder/blend_amount", 0)
	parent.animation_hands.play("Weapons/EquipOneHandedWeapon")

func FireOneHandedWeapon():
	parent.animation_hands.stop()
	parent.animation_hands.play("Weapons/FireOneHandedWeapon")


func EquipTwoHandedWeapon():
	parent.animation_tree.set("parameters/RotateShoulder/blend_amount", 1)
	parent.animation_hands.play("Weapons/EquipTwoHandedWeapon")


func FireTwoHandedWeapon():
	parent.animation_hands.stop()
	parent.animation_hands.play("Weapons/FireTwoHandedWeapon")

# 1 = DefaultOneHanded
# 2 = DefaultTwoHanded
func SetIkRightHand(arg):
	match arg:
		1:
			parent.ik_right_hand_target.global_position = parent.default_one_handed_weapon.global_position
		2:
			parent.ik_right_hand_target.global_position = parent.default_two_handed_weapon.global_position
		_:
			printerr("SetIkRightHand inside PlayerAnimations, argument doesn't existe")


func SetHandInfluance(influence : float):
	var amount : float
	if influence:
		amount = 0.95
	else:
		amount = 0.0
	# Hand Influance
	parent.ik_left_hand.influence = lerp(
		parent.ik_left_hand.influence, 
		amount, 
		0.1
	)
func SetLeftHandAnimationReach(active : bool):
	var amount : float
	if active:
		amount = 1.0
	else:
		amount = 0.0
	# Hand animation
	parent.animation_tree.set("parameters/ReachHandInteraction/blend_amount", 
		lerp(parent.animation_tree.get("parameters/ReachHandInteraction/blend_amount"), 
		amount, 
		0.1
		)
	)
func SetLeftHandPositionSmooth(position : Vector3):
	# Hand position
	parent.ik_left_hand_target.global_position = lerp(
		parent.ik_left_hand_target.global_position,
		position,
		0.1
	)
func SetLeftHandRotationSmooth(rotation : Vector3):
	# Hand rotation
	parent.ik_left_hand_target.global_rotation = lerp(
		parent.ik_left_hand_target.global_rotation,
		rotation,
		0.1
	)


# Hand animation for interaction
# Monkey code, re-visit if possible
func CheckForInteraction():
	var collider : Node3D
	
	if parent.camera_ray_cast.is_colliding() and parent.camera_ray_cast.get_collider():
		collider = parent.camera_ray_cast.get_collider()
		
		if "Interact" in collider.get_groups():
			# Hand Influance
			SetHandInfluance(true)

			# Hand animation
			SetLeftHandAnimationReach(true)

			# Hand position
			SetLeftHandPositionSmooth(parent.left_hand_intercation.global_position)
			# Hand rotation
			SetLeftHandRotationSmooth(parent.left_hand_intercation.global_rotation)
		else:
			# Hand animation
			SetLeftHandAnimationReach(false)
			if parent.stats.EQUIPED_WEAPON == parent.stats.EQUIPED_WEAPON_TYPE.TWO_HANDED_WEAPON_EQUIPED:
				# Hand position
				SetLeftHandPositionSmooth(parent.left_two_handed_weapon.global_position)
				# Hand rotation
				SetLeftHandRotationSmooth(parent.left_two_handed_weapon.global_rotation)
			else:
				# Hand Influance
				SetHandInfluance(false)
	elif not parent.camera_ray_cast.is_colliding():
		# Hand animation
		SetLeftHandAnimationReach(false)
		if parent.stats.EQUIPED_WEAPON == parent.stats.EQUIPED_WEAPON_TYPE.TWO_HANDED_WEAPON_EQUIPED:
			# Hand position
			SetLeftHandPositionSmooth(parent.left_two_handed_weapon.global_position)
			# Hand rotation
			SetLeftHandRotationSmooth(parent.left_two_handed_weapon.global_rotation)
		else:
			# Hand Influance
			SetHandInfluance(false)

func movement():
	parent.animation_tree.set(
	"parameters/Run/blend_position", 
	lerp(parent.animation_tree.get("parameters/Run/blend_position"),
	parent.input_dir, 
	0.1))
	parent.animation_tree.set(
	"parameters/Walk/blend_position", 
	lerp(parent.animation_tree.get("parameters/Walk/blend_position"),
	parent.input_dir, 
	0.2))
