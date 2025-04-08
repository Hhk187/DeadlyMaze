@tool
extends PlaybleEntity
class_name PlayerBrain




func _ready():
	super._ready()
	PlayerBrainServer.playerBrain = self


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
