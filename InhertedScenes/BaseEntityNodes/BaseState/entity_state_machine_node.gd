extends Node
class_name EntityStateMachineNode

const PATH = "res://InhertedScenes/BaseEntityNodes/BaseState/States/"

var entity_input_node : EntityInputNode

var states_dict : Dictionary

var last_state : EntityState
var current_state : EntityState

func _ready() -> void:
	_setup_states()
	find_dependencies()

func find_dependencies():
	if owner.find_child("EntityInputNode"):
		entity_input_node = owner.find_child("EntityInputNode")

func _setup_states():
	if owner is not BaseEntity : printerr("ERORR : owner is not EntiyBase - ", self)
	if owner.find_child("EntityInputNode"):
		entity_input_node = owner.find_child("EntityInputNode")
	
	var dir := ResourceLoader.list_directory(PATH)
	
	for file in dir:
		if file.begins_with("entity_state.gd"): continue
		var state : EntityState = ResourceLoader.load(PATH+file).new()
		state.init(self, owner, entity_input_node)
		states_dict[file.get_basename()] = state
	
	change_state("idle")


func change_state(state : String):
	var new_state = states_dict[state]
	
	if current_state == null:
		current_state = new_state
		last_state = current_state
		current_state.on_enter()
		
	elif current_state != new_state:
		current_state.on_exit()
		last_state = current_state
		current_state = new_state
		current_state.on_enter()

func _physics_process(delta: float) -> void:
	current_state.physics_process(delta)


func _process(delta: float) -> void:
	current_state.process(delta)
