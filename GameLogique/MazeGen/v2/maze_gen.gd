@tool
class_name MazeGen
extends Node

var world_gen_settings : Dictionary
var res_center_tiles : Dictionary

@onready var maze_algo : MazeAlgoLayer1 = $"../MazeAlgoLayer1"
@onready var layer_1 : Node3D = $"../../../Structures/MazeTiles/Layer1"



func LoadData():
	# Creating loader script
	var settings_loader = SettingsLoader.new()

	# Loading json files
	world_gen_settings = settings_loader.LoadSettings("WorldGenSettings")
	res_center_tiles = settings_loader.LoadResources("ResTiles")

func Generate():
	LoadData()
	_GenerateTilesFromMatrix(maze_algo.layer1_matrix)

func _GenerateTilesFromMatrix(matrix : Array):
	var world_coord = WorldCoord.new()

	var length = world_gen_settings["center_platform_size"]
	var spawn_border = (length - 1) / 2

	var top_left_maze_border = spawn_border + world_gen_settings["layer1_layers"]
	var top_left_maze_border_coord = [-top_left_maze_border,-top_left_maze_border]
	var bottom_right_maze_border = [top_left_maze_border,top_left_maze_border - 2]

	for layer in len(matrix):
		for tile in len(matrix[0]):
			if matrix[layer][tile][0][1] == " " : continue
			# spawn layer 1 tile and give matrix	
			var new_tile = res_center_tiles["layer1_tile_maze"].instantiate()
			layer_1.add_child(new_tile)
			new_tile.DeHashMazeMtrix(matrix[layer][tile])
			# place it in the right pos
			var grid_coord = world_coord.NewGridVector(
				top_left_maze_border_coord[0] + tile,
				0,
				top_left_maze_border_coord[1] + layer)
			new_tile.global_position = world_coord.GridToWolrd(grid_coord)

#func _SpawnTile(matrix, layer, tile, top_left_maze_border_coord, world_coord):


func ClearAll():
	if layer_1.get_children():
		for child in layer_1.get_children():
			child.queue_free()
