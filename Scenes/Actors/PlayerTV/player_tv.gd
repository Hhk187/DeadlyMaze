@tool
extends PlaybleEntity
class_name PlayerTV

func _ready():
	super._ready()
	
	if Engine.is_editor_hint(): return
	PlayerBrainServer.playerTV = self


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
