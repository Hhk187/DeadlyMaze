@tool
extends Node3D
class_name BaseMonitor

@onready var sprite_3d: Sprite3D = $Sprite3D
@onready var back_hidder: MeshInstance3D = $BackHidder

@onready var sub_viewport_container: SubViewportContainer = $SubViewportContainer
@onready var sub_viewport: SubViewport = $SubViewportContainer/SubViewport

@onready var texture_rect: TextureRect = $SubViewportContainer/SubViewport/TextureRect
var noise : NoiseTexture2D
var noise_seed : int = 0 
var noise_fz : float = 10

func _ready() -> void:
	noise = texture_rect.texture



func _physics_process(delta: float) -> void:
	
	noise_seed = int(delta * 100) + noise_seed % 10
	noise.noise.set("seed", noise_seed)
