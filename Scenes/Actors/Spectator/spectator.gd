extends Node3D

var SPEED = 0.5

var honrizontal_sens = 0.07
var vertical_sens = 0.1

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-deg_to_rad(event.relative.x * honrizontal_sens))
		$Neck.rotate_x(-deg_to_rad(event.relative.y * vertical_sens))


func _process(delta: float) -> void:
	var input_elevation = Input.get_axis("spectator_descend","spectator_ascend")
	if input_elevation == -1:
		global_position.y -= 0.2
	elif input_elevation == 1:
		global_position.y += 0.2

	var input_dir = Input.get_vector("left", "right", "forward", "backword")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		global_position.x += direction.x * SPEED
		global_position.z += direction.z * SPEED
