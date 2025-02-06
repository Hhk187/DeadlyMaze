class_name TilesRes
extends Node

# Global path for tiles
const PATH = "res://Scenes/LevelAssets/"

# Paths for center tiles
const CenterPath = "Center/Center1/"
const CenterTiles : Dictionary = {
	"basic" : PATH + CenterPath + "Tiles/Center1.tscn",
	"elevator" : "",
	"wall" : PATH + CenterPath + "Center/Center1/Tiles/InnerWall.tscn",
	"small_wall" : PATH + CenterPath + "Center/Center1/Tiles/SmallWall.tscn"
}
