extends Node3D
class_name PlayerBrainRoom

@onready var main_monitor: BaseMonitor = $MainMonitor


func _ready() -> void:
	#await get_tree().create_timer(5).timeout
	PlayerBrainServer.playerBrainRoom = self


func SetTogglePovMainMonitor(POV : SubViewport):
	main_monitor.SetTogglePovMainMonitor(POV)
