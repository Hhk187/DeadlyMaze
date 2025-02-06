@tool
extends Node

@export var test : bool:
	set(value):
		Generate()
	get():
		return true

var world_gen_settings : Dictionary
var res_center_tiles : Dictionary

var tb_side_length : int
var lr_side_length : int

var t_matrix : Array = []
var b_matrix : Array = []
var l_matrix : Array = []
var r_matrix : Array = []

var small_tile = [
	[" ","M"," ","M"," "],
	["M","A","M","A","M"], # [1][1], [1][3]
	[" ","M"," ","M"," "],
	["M","A","M","A","M"], # [3][1], [3][3]
	[" ","M"," ","M"," "],
]

func Generate():
	LoadData()
	GenerateMatrix()

func ClearAll():
	pass


func LoadData():
	# Creating loader script
	var settings_loader = SettingsLoader.new()

	# Loading json files
	world_gen_settings = settings_loader.LoadSettings("WorldGenSettings")
	res_center_tiles = settings_loader.LoadResources("ResTiles")

	tb_side_length = world_gen_settings["center_platform_size"] + (world_gen_settings["layer1_layers"] * 2)
	lr_side_length = world_gen_settings["center_platform_size"]


func GenerateMatrix():
	t_matrix = GenLayer1MartixMaze("tb")
	# b_matrix = GenLayer1MartixMaze("tb")
	# l_matrix = GenLayer1MartixMaze("lr")
	# r_matrix = GenLayer1MartixMaze("lr")
	
	
	


func GenTBMetric():
	var matrix : Array
	for i in range(world_gen_settings["layer1_layers"]):
		matrix.append([])
		for j in range(tb_side_length):
			matrix[-1].append(small_tile.duplicate(true))
	return matrix

func GenLRMetric():
	var matrix : Array
	for i in range(world_gen_settings["layer1_layers"]):
		matrix.append([])
		for j in range(lr_side_length):
			matrix[-1].append(small_tile.duplicate(true))
	return matrix

func ShowMatrix():
	print("t_matrix\n")
	for i in t_matrix:
		for j in i:
			print(j)

	print("l_matrix\n")
	for i in l_matrix:
		for j in i:
			print(j)




var temp_matrix : Array
var inside_t_place = [
	[1,1],[1,3],
	[3,1],[3,3]
]
var E_lst = []

var x = 0
var y = 0
var x_inside = 0
var y_inside = 0

var last_x : int
var last_y : int
var last_x_inside : int
var last_y_inside : int

var x_len : int
var y_len : int
var x_inside_len : int
var y_inside_len : int

var possible_neighbors : Array
var rdm_n : Array

func GenLayer1MartixMaze(side : String):

	if side == "tb":
		temp_matrix = GenTBMetric()
	elif side == "lr":
		temp_matrix = GenLRMetric()
	else:
		printerr("GenLayer1MartixMaze : No such side as %s" % side)

	x_len = len(temp_matrix) - 1
	y_len = len(temp_matrix[0]) - 1
	x_inside_len = len(small_tile) - 1
	y_inside_len = len(small_tile[0]) - 1 
	
	var rdm = randi() % len(inside_t_place)
	x = randi() % x_len + 1
	y = randi() % y_len + 1
	x_inside = inside_t_place[rdm][0]
	y_inside = inside_t_place[rdm][1]

	# Start on random "A" -> Available
	# print(temp_matrix[x][y][x_inside][y_inside])
	# print("first one T0 = ", [x,y,x_inside,y_inside])
	temp_matrix[x][y][x_inside][y_inside] = "T"
	ReplaceNeighborsToE()
	
	# for iteration in range(5):
	var iteration = 0
	while !E_lst.is_empty():
	# for i in range(6):
		iteration += 1
		# Taking note of last "T" pos
		last_x = x
		last_y = y
		last_x_inside = x_inside
		last_y_inside = y_inside
		
		
		# Taking "rdm" "E" from lst
		var rdm_e = randi() % len(E_lst)
		x = E_lst[rdm_e][0]
		y = E_lst[rdm_e][1]
		x_inside = E_lst[rdm_e][2]
		y_inside = E_lst[rdm_e][3]

		temp_matrix[x][y][x_inside][y_inside] = "T"
		# print(temp_matrix[x][y][x_inside][y_inside])
		# print("T" + str(iteration), "=", E_lst[rdm_e])
		# print(E_lst)

		ReplaceNeighborsToE()
		GetPossibleTNeighbors()
		SelectAndReplaceRdmNeighbor()
		# # Replace "M" neighbor by "T" 
		# # only when just became "T"
		# # and the other "T" is last neighbor
		E_lst.remove_at(rdm_e)
		
	
	# Loop while "E" is available:
	# Choose random "E"
	# Replace by "T"
	# Replace all "A" neighbors by "E"
	# Replace all "M" neighbors by "T"
	
	

	# for i in temp_matrix:
	# 	print("\n")
	# 	for j in i:
	# 		print(j , "\n")

	return temp_matrix


func ReplaceNeighborsToE():
	# Replace neighbors by "E" -> Expend
	# inside
	if x_inside == inside_t_place[0][0]: # bottom
		if temp_matrix[x][y][x_inside + 2][y_inside] == "A":  
			temp_matrix[x][y][x_inside + 2][y_inside] = "E"
			E_lst.append([x,y,x_inside + 2,y_inside])
		if x > 0: # outside top
			if temp_matrix[x - 1][y][x_inside + 2][y_inside] == "A":
				temp_matrix[x - 1][y][x_inside + 2][y_inside] = "E"
				E_lst.append([x - 1,y,x_inside + 2,y_inside])

	elif x_inside == inside_t_place[2][0]: # top
		if temp_matrix[x][y][x_inside - 2][y_inside] == "A":
			temp_matrix[x][y][x_inside - 2][y_inside] = "E"
			E_lst.append([x,y,x_inside - 2,y_inside])
		if x < x_len: # outside bottom
			if temp_matrix[x + 1][y][x_inside - 2][y_inside] == "A":
				temp_matrix[x + 1][y][x_inside - 2][y_inside] = "E"
				E_lst.append([x + 1,y,x_inside - 2,y_inside])

	if y_inside == inside_t_place[0][1]: # right
		if temp_matrix[x][y][x_inside][y_inside + 2] == "A":
			temp_matrix[x][y][x_inside][y_inside + 2] = "E"
			E_lst.append([x,y,x_inside,y_inside + 2])
		if y > 0: # outside left
			if temp_matrix[x][y - 1][x_inside][y_inside + 2] == "A":
				temp_matrix[x][y - 1][x_inside][y_inside + 2] = "E"
				E_lst.append([x,y - 1,x_inside,y_inside + 2])

	elif y_inside == inside_t_place[1][1]: # left
		if temp_matrix[x][y][x_inside][y_inside - 2] == "A":
			temp_matrix[x][y][x_inside][y_inside - 2] = "E"
			E_lst.append([x,y,x_inside,y_inside - 2])
		if y < y_len: # outside right
			if temp_matrix[x][y + 1][x_inside][y_inside - 2] == "A":
				temp_matrix[x][y + 1][x_inside][y_inside - 2] = "E"
				E_lst.append([x,y + 1,x_inside,y_inside - 2])

func GetPossibleTNeighbors():
	possible_neighbors.clear()
	
	if x_inside == inside_t_place[0][0] and y_inside == inside_t_place[0][1]: # if he is top level and left side
		if x > 0 and temp_matrix[x-1][y][x_inside + 2][y_inside] == "T": # there is top neighbor outside
			possible_neighbors.append([x-1, y, x_inside + 2, y_inside, "top"])
		if temp_matrix[x][y][x_inside][y_inside + 2] == "T": # if right of him inside
			possible_neighbors.append([x,y,x_inside,y_inside + 2, "right"])
		if temp_matrix[x][y][x_inside + 2][y_inside] == "T": # if bottom of him inside
			possible_neighbors.append([x,y,x_inside + 2,y_inside, "bottom"])
		if y > 0 and temp_matrix[x][y - 1][x_inside][y_inside + 2] == "T": # there is left neighbor outside
			possible_neighbors.append([x,y - 1,x_inside,y_inside + 2, "left"])

	elif x_inside == inside_t_place[1][0] and y_inside == inside_t_place[1][1]: # if its top right
		if x > 0 and temp_matrix[x-1][y][x_inside + 2][y_inside] == "T": # there is top neighbor outside
			possible_neighbors.append([x-1, y, x_inside + 2, y_inside, "top"])
		if y < y_len and temp_matrix[x][y + 1][x_inside][y_inside - 2] == "T": # if right of him outside
			possible_neighbors.append([x, y + 1, x_inside, y_inside - 2, "right"])
		if temp_matrix[x][y][x_inside + 2][y_inside] == "T": # if bottom of him inside
			possible_neighbors.append([x,y,x_inside + 2,y_inside, "bottom"])
		if temp_matrix[x][y][x_inside][y_inside - 2] == "T": # if left of him inside
			possible_neighbors.append([x,y,x_inside,y_inside-2, "left"])
	
	elif x_inside == inside_t_place[2][0] and y_inside == inside_t_place[2][1]: # if its bottom left
		if temp_matrix[x][y][x_inside - 2][y_inside] == "T": # if top of him inside
			possible_neighbors.append([x,y,x_inside - 2, y_inside, "top"])
		if temp_matrix[x][y][x_inside][y_inside + 2] == "T": # if right of him inside
			possible_neighbors.append([x,y,x_inside,y_inside + 2, "right"])
		if x < x_len and temp_matrix[x + 1][y][x_inside - 2][y_inside] == "T": # there is bottom neighbor outside
			possible_neighbors.append([x+1,y,x_inside - 2,y_inside, "bottom"])
		if y > 0 and temp_matrix[x][y - 1][x_inside][y_inside + 2] == "T": # there is left neighbor outside
			possible_neighbors.append([x,y - 1,x_inside,y_inside + 2, "left"])
	
	elif x_inside == inside_t_place[3][0] and  x_inside == inside_t_place[3][1]: # if its bottom right
		if temp_matrix[x][y][x_inside - 2][y_inside] == "T": # if top of him inside
			possible_neighbors.append([x,y,x_inside - 2, y_inside, "top"])
		if y < y_len and temp_matrix[x][y + 1][x_inside][y_inside - 2] == "T": # if right of him outside
			possible_neighbors.append([x, y + 1, x_inside, y_inside - 2, "right"])
		if x < x_len and temp_matrix[x + 1][y][x_inside - 2][y_inside] == "T": # there is bottom neighbor outside
			possible_neighbors.append([x+1,y,x_inside - 2,y_inside, "bottom"])
		if temp_matrix[x][y][x_inside][y_inside - 2] == "T": # if left of him inside
			possible_neighbors.append([x,y,x_inside,y_inside-2, "left"])

func SelectAndReplaceRdmNeighbor():
	if !possible_neighbors.is_empty():
		var rdm_index = randi() % len(possible_neighbors)
		rdm_n = possible_neighbors[(rdm_index)]
		match rdm_n[4]:
			"top": # top
				temp_matrix[x][y][x_inside - 1][y_inside] = "T"
				temp_matrix[rdm_n[0]][rdm_n[1]][rdm_n[2] + 1][rdm_n[3]] = "T"
			"right": # right
				temp_matrix[x][y][x_inside][y_inside + 1] = "T"
				temp_matrix[rdm_n[0]][rdm_n[1]][rdm_n[2]][rdm_n[3] - 1]  = "T"
			"bottom": # bottom
				temp_matrix[x][y][x_inside + 1][y_inside] = "T"
				temp_matrix[rdm_n[0]][rdm_n[1]][rdm_n[2] - 1][rdm_n[3]]  = "T"
			"left": # left
				temp_matrix[x][y][x_inside][y_inside - 1] = "T"
				temp_matrix[rdm_n[0]][rdm_n[1]][rdm_n[2]][rdm_n[3] + 1]  = "T"


# Old code
func ReplaceMByT():
	# Replace by "T" -> Taken 						(random path * 4)
	# inside
	if x == last_x and y == last_y:
		print("inside")
		if x_inside - 2 == last_x_inside: # bottom
			print("bottom")
			temp_matrix[x][y][x_inside - 1][y_inside] = "T"
		elif x_inside + 2 == last_x_inside: # 
			print("top")
			temp_matrix[x][y][x_inside + 1][y_inside] = "T"
		elif y_inside - 2 == last_y_inside: # 
			print("left")
			temp_matrix[x][y][x_inside][y_inside - 1] = "T"
		elif y_inside + 2 == last_y_inside: # 
			print("right")
			temp_matrix[x][y][x_inside][y_inside + 1] = "T"
	# outside
	else :
		print("oustside")
		if x - 1 == last_x: # if new bottom last
			print("new bottom last")
			temp_matrix[x][y][x_inside - 1][y_inside] = "T"
			temp_matrix[last_x][last_y][last_x_inside + 1][last_y_inside] = "T"
		elif x + 1 == last_x: # if new top last
			print("new top last")
			temp_matrix[x][y][x_inside + 1][y_inside] = "T"
			temp_matrix[last_x][last_y][last_x_inside - 1][last_y_inside] = "T"
		elif y - 1 == last_y: # if new left last
			print("new left last")
			temp_matrix[x][y][x_inside][y_inside - 1] = "T"
			temp_matrix[last_x][last_y][last_x_inside][last_y_inside + 1] = "T"
		elif y + 1 == last_y: # if new right last
			print("new right last")
			temp_matrix[x][y][x_inside][y_inside + 1] = "T"
			temp_matrix[last_x][last_y][last_x_inside][last_y_inside - 1] = "T"
