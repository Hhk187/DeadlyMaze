@tool
class_name MapGen
extends Node



@onready var center_gen: CenterGen = $CenterGen
@onready var maze_algo_layer1  : MazeAlgoLayer1 = $MazeAlgoLayer1
@onready var maze_gen : MazeGen = $MazeGen



func GenerateCenterSpawn():
	center_gen.Generate()

func GenerateMazeLayer1():
	maze_algo_layer1.Generate()
	maze_gen.Generate()

func ClearAll():
	center_gen.ClearAll()
	maze_algo_layer1.ClearAll()
	maze_gen.ClearAll()
