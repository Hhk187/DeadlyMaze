extends Node3D
class_name PlayerBrainRoom

@onready var main_monitor: BaseMonitor = $MainMonitor


func _ready() -> void:
	if Engine.is_editor_hint(): return
	PlayerBrainServer.playerBrainRoom = self
	
	


func SetMonitorPOV(POV : SubViewport):
	await get_tree().create_timer(1).timeout
	main_monitor.SetMonitorPOV(POV)
