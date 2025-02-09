@tool
extends Node3D

@export var update : bool:
	set(arg):
		_ready()
	get():
		return true

# Called when the node enters the scene tree for the first time.
var bricks_lst = []
func _ready() -> void:
	pass
	#if bricks_lst:
		#for brick in bricks_lst:
			#brick.queue_free()
		#bricks_lst.clear()
		#
	#for i in range(30):
		#var thread = Thread.new()
		#thread.start(GenBrick)
		#thread.wait_to_finish()

func GenBrick():
		var brick = MeshInstance3D.new()
		bricks_lst.append(brick)
		var mesh_box = BoxMesh.new()
		mesh_box.size = Vector3(
			randi() % 8 + 2,
			randi() % 3 + 2,
			5
		)
		var new_material = StandardMaterial3D.new()
		new_material.albedo_color = Color(0.4, 0.2, 0.1, 1)
		#new_material.albedo_texture = load("res://temp/Capture d'écran 2024-12-17 204702.png")
		mesh_box.material = new_material
		brick.mesh = mesh_box
		call_deferred("add_child", brick)
		brick.position = Vector3(
			randi() % 20 - 10,
			randi() % 100,
			-8
		)
