@tool
class_name CenterGen
extends Node

var world_gen_settings : Dictionary
var res_center_tiles : Dictionary

@onready var center_tiles: Node3D = $"../../../Structures/CenteTiles"
# @onready var maze_platforms: Node3D = $"../../../Structures/MazeTiles"

var matrix : Array = []


func Generate():
	LoadData()
	GenerateMatrix()
	# ShowMatrix()
	InsertTilesIntoMatrix()
	GenerateCenterSpawn()

func ClearAll():
	if center_tiles.get_children():
		for tile in center_tiles.get_children():
			tile.queue_free()
	matrix.clear()

func LoadData():
	# Creating loader script
	var settings_loader = SettingsLoader.new()

	# Loading json files
	world_gen_settings = settings_loader.LoadSettings("WorldGenSettings")
	res_center_tiles = settings_loader.LoadResources("ResTiles")


func GenerateMatrix():
	for i in range(world_gen_settings["center_platform_size"]):
		matrix.append([])
		for j in world_gen_settings["center_platform_size"]:
			matrix[i].append([])


func ShowMatrix():
	for i in matrix:
		print(i)

func InsertTilesIntoMatrix():
	var length = len(matrix)
	var half = (length - 1) / 2
	var middle = half

	# Center Tiles
	for i in range(length):
		for j in range(length):
			matrix[i][j] = [res_center_tiles['center_tile']]

	# Elevator Tile
	matrix[middle][middle] = [res_center_tiles['center_elevator']]

	# Inner Walls
	for i in range(length):
		for j in range(i):
			if j != 0 and j != length - 1:
				matrix[0][j] = [res_center_tiles["inner_wall"]]
				matrix[-1][j] = [res_center_tiles["inner_wall"]]
				
			if i != 0 and i != length - 1:
				matrix[i][0] = [res_center_tiles["inner_wall"]]
				matrix[i][-1] = [res_center_tiles["inner_wall"]]
	
	# InnerDoor and Center Tiles
	matrix[0][middle] = [
		res_center_tiles["inner_door"],
		res_center_tiles["center_tile"]
	]
	matrix[-1][middle] = [
		res_center_tiles["inner_door"],
		res_center_tiles["center_tile"]
	]
	matrix[middle][0] = [
		res_center_tiles["inner_door"],
		res_center_tiles["center_tile"]
	]
	matrix[middle][-1] = [
		res_center_tiles["inner_door"],
		res_center_tiles["center_tile"]
	]


func GenerateCenterSpawn():
	var world_coord = WorldCoord.new()

	var length = len(matrix)
	var border_pos = len(matrix) - 1
	var offset = (length - 1) / 2


	for x in length:
		for y in length:
			for packed_scene in matrix[x][y]:
				var new_scene : Node3D = packed_scene.instantiate()
				center_tiles.add_child(new_scene)

				var grid_coord = world_coord.NewGridVector(x - offset, 0, y - offset)
				new_scene.global_position = world_coord.GridToWolrd(grid_coord)

				if packed_scene == res_center_tiles["inner_door"] or packed_scene == res_center_tiles["inner_wall"]:
					match x:
						0:
							new_scene.rotate_y(deg_to_rad(-90))
						border_pos:
							new_scene.rotate_y(deg_to_rad(90))

					match y:
						0:
							new_scene.rotate_y(deg_to_rad(180))
						border_pos:
							pass # Right oriantation
