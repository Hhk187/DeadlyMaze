extends PhysicalBoneSimulator3D

@onready var physical_bone_head: PhysicalBone3D = $"Physical Bone Head"
@onready var collision_shape_3d: CollisionShape3D = $"../../../../CollisionShape3D"
@onready var player_tv: CharacterBody3D = $"../../../../.."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	physical_bones_start_simulation()
	await get_tree().create_timer(2).timeout
	physical_bone_head.linear_velocity = Vector3(0,300,-300)
	physical_bone_head.angular_velocity = Vector3(0,50,0)
	
	await get_tree().create_timer(10).timeout
	active = false
	for i : PhysicalBone3D in get_children():
		i.get_child(0).disabled = true
	player_tv.global_position = physical_bone_head.global_position
	player_tv.global_position.y -= 2
	player_tv.set_physics_process(true)
	collision_shape_3d.disabled = false
	
