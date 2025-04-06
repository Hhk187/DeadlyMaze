extends PlayableEntityInput



func update(delta : float) -> void:
	super.update(delta)
	
	
	if Input.is_action_pressed("Jump"):
		playable_entity.velocity.y = data.speed 
	
	elif Input.is_action_pressed("Crouch"):
		playable_entity.velocity.y = -data.speed
	
	else:
		playable_entity.velocity.y = lerp(playable_entity.velocity.y, 0.0, 0.3)
