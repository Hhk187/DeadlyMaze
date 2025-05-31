extends Resource
class_name EntityState


var _entity : BaseEntity
var _state_machine : EntityStateMachineNode
var _entity_input_node : EntityInputNode
var _input_actions : Array[BufferedInput]

func init(state_machine : EntityStateMachineNode, entity : BaseEntity, entity_input_node : EntityInputNode = null) -> void:
	_state_machine = state_machine
	_entity = entity
	_entity_input_node = entity_input_node
	_input_actions = entity_input_node.actions_input_buffer.inputs

func on_enter() -> void:
	pass

func on_exit() -> void:
	pass

func physics_process(delta: float) -> void:
	pass

func process(delta: float) -> void:
	pass


func _check_input(input : StringName) -> bool:
	for i in _input_actions:
		if i.action == input:
			_input_actions.erase(i)
			return true
	return false

func _change_state(state : String):
	_state_machine.change_state(state)
