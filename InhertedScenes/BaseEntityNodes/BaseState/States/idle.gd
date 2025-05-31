extends EntityState


func on_enter() -> void:
	pass

func on_exit() -> void:
	pass

func physics_process(delta: float) -> void:
	
	
	if _check_input("action_jump") and _entity.is_on_floor():
		_change_state("jump")

func process(delta: float) -> void:
	pass
