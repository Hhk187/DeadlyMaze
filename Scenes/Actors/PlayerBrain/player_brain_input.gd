extends PlayableEntityInput



func update(delta : float) -> void:
	super.update(delta)
	
	
	var direction : float = 0
	if Input.is_action_pressed("Jump"):
		direction += 1
	
	if Input.is_action_pressed("Crouch"):
		direction -= 1
		
	playable_entity.velocity.y = lerp(direction, direction * data.speed, 0.1)

	if Input.is_action_pressed("run"):
		data.speed = data.run_speed
	else :
		data.speed = data.og_speed
