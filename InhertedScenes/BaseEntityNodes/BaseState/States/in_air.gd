extends EntityState


func on_enter() -> void:
	pass

func on_exit() -> void:
	pass

func physics_process(delta: float) -> void:
	if not _entity.is_on_floor():
		_entity.velocity += _entity.get_gravity() * delta
	else:
		_change_state("land")


func process(delta: float) -> void:
	pass
