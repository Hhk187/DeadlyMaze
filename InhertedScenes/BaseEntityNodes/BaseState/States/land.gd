extends EntityState


func on_enter() -> void:
	_change_state("idle")

func on_exit() -> void:
	pass

func physics_process(delta: float) -> void:
	pass

func process(delta: float) -> void:
	pass
