class_name WorldCoord 
extends Resource


func NewGridVector(x,y,z):
	return {"x" : x, "y" : y, "z" : z}

func WoldToGrid(coord : Vector3):
	var c = (coord / 20).floor()
	var GridCoord = {"x" : c.x, "y" : c.y, "z" : c.z}
	return GridCoord

func GridToWolrd(coord : Dictionary):
	var Worldcoord = Vector3(coord.x, coord.y, coord.z) * 20
	return Worldcoord
