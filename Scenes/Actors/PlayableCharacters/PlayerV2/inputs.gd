class_name PlayerInputs
extends Node






var parent : PlayableCharacter

func init(node):
	self.parent = node


func input(event: InputEvent) -> void:
	if parent.stats.CAN_LOOK_AROUND: 
	# Camera rotation
		if event is InputEventMouseMotion:
			parent.rotate_y(-deg_to_rad(event.relative.x * parent.honrizontal_sens))
			parent.neck.rotate_x(-deg_to_rad(event.relative.y * parent.vertical_sens))
			parent.neck.rotation_degrees.x = clamp(parent.neck.rotation_degrees.x, -70, 70)
	
	
	# Mouse inputs
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed() and parent.stats.CAN_MAIN_ACTION: # Right click
			
			if parent.stats.EQUIPED_WEAPON == BaseEntityStats.EQUIPED_WEAPON_TYPE.ONE_HANDED_WEAPON_EQUIPED:
				parent.animations.FireOneHandedWeapon()
			elif parent.stats.EQUIPED_WEAPON == BaseEntityStats.EQUIPED_WEAPON_TYPE.TWO_HANDED_WEAPON_EQUIPED:
				parent.animations.FireTwoHandedWeapon()
			
			elif parent.stats.EQUIPED_ITEM == BaseEntityStats.EQUIPED_ITEM_TYPE.ONE_HANDED_ITEM_EQUIPED:
				print("Right click on ONE handed item")
			elif parent.stats.EQUIPED_ITEM == BaseEntityStats.EQUIPED_ITEM_TYPE.TWO_HANDED_ITEM_EQUIPED:
				print("Right click on TWO handed item")
				
		elif event.button_index == 1 and event.is_released() and parent.stats.CAN_MAIN_ACTION:
			pass

		if event.button_index == 2 and event.is_pressed() and parent.stats.CAN_SECONDAIRE_ACTION: # Left click
			parent.ik_right_hand_target.global_position = parent.focus_item.global_position
		elif event.button_index == 2 and event.is_released() and parent.stats.CAN_SECONDAIRE_ACTION:
			parent.ik_right_hand_target.global_position = parent.default_one_handed_weapon.global_position


func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("Change persperctive"): 
			parent.is_first_person = !parent.is_first_person
			if parent.is_first_person:
				parent.camera_3d.global_position = parent.first_person.global_position
			else:
				parent.camera_3d.global_position = parent.third_person.global_position
		
		# Can only press "Pickup" when he can intercat with an item/weapon
		if event.is_action_pressed("Pickup"):
		
			if parent.stats.POSSIBLE_INTERCATION == BaseEntityStats.POSSIBLE_INERACTION_TYPE.CAN_PICKUP_WEAPON:
				PickupWeapon()
		
			elif parent.stats.POSSIBLE_INTERCATION == BaseEntityStats.POSSIBLE_INERACTION_TYPE.CAN_PICKUP_ITEM: 
				PickupItem()
			
			elif parent.stats.POSSIBLE_INTERCATION == BaseEntityStats.POSSIBLE_INERACTION_TYPE.CAN_INTERCAT: 
				print("Interacting")
				pass
		
		if event.is_action_pressed("DropSecondary"):
			DropLeftHand()
		elif event.is_action_pressed("DropPrimary"):
			DropRightHand()


func CanPickupItem():
	pass

func IsRightHandOccupied():
	return parent.stats.RIGHT_HAND_OCCUPIED

func IsLeftHandOccupied():
	return parent.stats.LEFT_HAND_OCCUPIED

func DropRightHand():
	if IsRightHandOccupied():
		var child : RigidBody3D = parent.right_hand.get_child(0)
		
		parent.right_hand.remove_child(child)
		parent.get_parent().add_child(child)
		child.global_position = parent.right_hand.global_position
		child.global_rotation = parent.right_hand.global_rotation

		child.freeze = false

		child.linear_velocity = (child.transform.basis * Vector3(0, 0, 1))

		parent.stats.EQUIPED_WEAPON = BaseEntityStats.EQUIPED_WEAPON_TYPE.NONE
		parent.stats.RIGHT_HAND_OCCUPIED = false
		SwitchItemFromLeftToRight()

func DropLeftHand():
	print("alt + drop")


func SwitchItemFromRightToLeft():
	if IsLeftHandOccupied() : return

	# Exctracting item from right hand
	var item = parent.right_hand.get_child(0)
	parent.right_hand.remove_child(item)

	# Giving it to left Hand
	parent.left_hand.add_child(item)
	item.rotation = Vector3.ZERO
	item.position = Vector3.ZERO
	parent.stats.LEFT_HAND_OCCUPIED = true


func SwitchItemFromLeftToRight():
	if IsRightHandOccupied() or not IsLeftHandOccupied() : return
	
	# Exctracting item from right hand
	var item = parent.left_hand.get_child(0)
	parent.left_hand.remove_child(item)

	# Giving it to right Hand
	parent.right_hand.add_child(item)
	item.rotation = Vector3.ZERO
	item.position = Vector3.ZERO
	parent.stats.LEFT_HAND_OCCUPIED = false
	parent.stats.RIGHT_HAND_OCCUPIED = true

func PickupWeapon():
	# Getting item
	var item = parent.camera_ray_cast.get_collider()
	if item is not BaseWeapon:
		print("not BaseWeapon")
		return

	var stats : BaseWeaponStats = item.get_child(0)
			
	if stats.HELD == BaseWeaponStats.HELD_TYPE.ONE_HAND and not parent.stats.EQUIPED_WEAPON: # If the weapon is one handed
		parent.stats.EQUIPED_WEAPON = BaseEntityStats.EQUIPED_WEAPON_TYPE.ONE_HANDED_WEAPON_EQUIPED
		parent.animations.EquipOneHandedWeapon()

	elif stats.HELD == BaseWeaponStats.HELD_TYPE.TWO_HAND and not parent.stats.EQUIPED_WEAPON: # If the weapon is two handed
		parent.stats.EQUIPED_WEAPON = BaseEntityStats.EQUIPED_WEAPON_TYPE.TWO_HANDED_WEAPON_EQUIPED
		parent.animations.EquipTwoHandedWeapon()
		parent.right_hand.UpdateLeftHandPos()
	
	else :
		print("Cant pickup weapon")
		return

	
	if not IsRightHandOccupied():
		# Adding to hand and putting as side body
		item.get_parent().remove_child(item) # Extracting from entity node
		parent.right_hand.add_child(item)
		item.freeze = true
		item.rotation = Vector3.ZERO
		item.position = Vector3.ZERO
		parent.stats.RIGHT_HAND_OCCUPIED = true
	
	elif not IsLeftHandOccupied():
		SwitchItemFromRightToLeft()
		item.get_parent().remove_child(item) # Extracting from entity node
		parent.right_hand.add_child(item)
		item.freeze = true
		item.rotation = Vector3.ZERO
		item.position = Vector3.ZERO
	
	else:
		print("Both hands are occupied")

func PickupItem():
	# Getting item
	var item = parent.camera_ray_cast.get_collider()
	if item is not BaseItem:
		print("not BaseItem")
		return


	var stats : BaseItemStats = item.get_child(0)

	
	# Adding to hand and putting as side body
	if not IsRightHandOccupied():
		item.get_parent().remove_child(item) # Extracting from entity node
		parent.right_hand.add_child(item)
		item.freeze = true
		item.rotation = Vector3.ZERO
		item.position = Vector3.ZERO
		parent.stats.RIGHT_HAND_OCCUPIED = true
	
	elif not IsLeftHandOccupied():
		item.get_parent().remove_child(item) # Extracting from entity node
		parent.left_hand.add_child(item)
		item.freeze = true
		item.rotation = Vector3.ZERO
		item.position = Vector3.ZERO
		parent.stats.LEFT_HAND_OCCUPIED = true
	
	else:
		print("Both hands are occupied")


func movement(delta : float):
	if !parent.stats.CAN_MOVE: return

	# Add the gravity.
	if not parent.is_on_floor():
		parent.velocity += parent.get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and parent.is_on_floor():
		parent.velocity.y = parent.stats.JUMP_HEIGHT


	parent.input_dir = Input.get_vector("strafe_left", "strafe_right", "forward", "backword")
	parent.direction = (parent.transform.basis * Vector3(parent.input_dir.x, 0, parent.input_dir.y)).normalized()

	if Input.is_action_pressed("run"):
		parent.stats.SPEED = parent.stats.RUN_SPEED
		parent.animation_tree.set("parameters/LocomotionTransition/transition_request", "Running")
	else :
		parent.stats.SPEED = parent.stats.WALK_SPEED
		parent.animation_tree.set("parameters/LocomotionTransition/transition_request", "Walking")

func update(delta : float) -> void:
	movement(delta)

	if parent.direction:
		parent.velocity.x = parent.direction.x * parent.stats.SPEED
		parent.velocity.z = parent.direction.z * parent.stats.SPEED
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, parent.stats.SPEED)
		parent.velocity.z = move_toward(parent.velocity.z, 0, parent.stats.SPEED)
