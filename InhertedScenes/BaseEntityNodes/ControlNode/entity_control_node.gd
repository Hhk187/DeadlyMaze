extends Node
class_name EntityControleNode

var entity : BaseEntity
var yaw : Node3D
var pitch : Node3D

func _ready() -> void:
	find_dependencies()

func find_dependencies():
	if owner is not BaseEntity: printerr("ERROR : Owner is not BaseEntity - on", self)
	entity = owner
	yaw = entity.find_child("Yaw") 
	pitch = yaw.find_child("Pitch") 

# Camera Rotation
func set_camera_x_rotation_degree(degree : float):
	if not yaw: return
	pitch.rotation_degrees.x = degree

func set_camera_x_rotation(rad : float):
	if not yaw: return
	pitch.rotate_x(rad)


func move_direction(direction : Vector2):
	var dir = (entity.transform.basis * Vector3(direction.x ,0 ,direction.y)).normalized()
	entity.velocity.z = lerp(dir.z, dir.z * 3, 0.1)
	entity.velocity.z = lerp(dir.x, dir.x * 3, 0.1)

func go_to(position : Vector3):
	entity.global_position = position

#if direction:
		#playable_entity.velocity.x = lerp(direction.x, direction.x * data.speed, 0.1)
		#playable_entity.velocity.z = lerp(direction.z, direction.z * data.speed, 0.1)
	#else:
		#playable_entity.velocity.x = lerp(playable_entity.velocity.x, 0.0, 0.3)
		#playable_entity.velocity.z = lerp(playable_entity.velocity.z, 0.0, 0.3)
