@tool
extends Node3D
class_name BaseMonitor

@onready var back_hidder: MeshInstance3D = $BackHidder
@onready var sprite_3d: Sprite3D = $Sprite3D

@onready var sub_viewport: SubViewport = $SubViewport

@onready var texture_rect: TextureRect = $SubViewport/TextureRect
var noise : NoiseTexture2D
var noise_seed : int = 0 
var noise_fz : float = 100

var noise_texture : ViewportTexture


func _ready() -> void:
	noise = texture_rect.texture
	if Engine.is_editor_hint():
		sprite_3d.texture.viewport_path = sub_viewport.get_path()
		return
	SetMonitorPOV(sub_viewport)

func SetMonitorPOV(POV : SubViewport):
	
	sprite_3d.texture.viewport_path = POV.get_path()
	#sprite_3d.texture.viewport_path = get_tree().root.get_path_to(POV).slice(1)


func _physics_process(delta: float) -> void:
	
	noise_seed = (int(delta * noise_fz) + noise_seed) % 10
	noise.noise.set("seed", noise_seed)
