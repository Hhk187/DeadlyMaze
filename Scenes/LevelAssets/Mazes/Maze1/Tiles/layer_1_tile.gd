@tool
extends Node3D

@onready var walls: Node3D = $Walls
var walls_nodes : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for wall in walls.get_children():
		walls_nodes.append(wall)


func DeHashMazeMtrix(matrix : Array):
	for wall in walls_nodes:
		var wall_name = str(wall.name)
		if matrix[int(wall_name[0])][int(wall_name[1])] == "T":
			wall.queue_free()
