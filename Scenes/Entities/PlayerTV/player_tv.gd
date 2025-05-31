extends CharacterBody3D
class_name BaseEntity

const SPEED = 5.0
const JUMP_VELOCITY = 4.5


func _physics_process(delta: float) -> void:
	# Add the gravity.
	move_and_slide()
