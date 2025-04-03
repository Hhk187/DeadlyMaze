extends CharacterBody3D
class_name PlaybleEntity

@onready var data: PlayableEntityData = $Data
@onready var input: PlayableEntityInput = $Input
@onready var state: PlayableEntityState = $State


@onready var yaw: Node3D = $Yaw
@onready var pitch: Node3D = $Yaw/Pitch



func _ready() -> void:
	input.init(self)


func _physics_process(delta: float) -> void:
	input.update()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = data.jump_vel

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("strafe_left", "strafe_right", "forward", "backword")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = lerp(direction.x, direction.x * data.speed, 0.1)
		velocity.z = lerp(direction.z, direction.z * data.speed, 0.1)
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.3)
		velocity.z = lerp(velocity.z, 0.0, 0.3)

	move_and_slide()
