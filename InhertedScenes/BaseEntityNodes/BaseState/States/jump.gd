extends EntityState


func on_enter() -> void:
	_entity.velocity.y = 5

func on_exit() -> void:
	pass

func physics_process(delta: float) -> void:
	if not _entity.is_on_floor():
		_change_state("in_air")
	else:
		_change_state("idle")

func process(delta: float) -> void:
	pass
