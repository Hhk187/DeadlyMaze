@tool
extends Node3D
class_name BaseMonitor

@onready var sprite_3d: Sprite3D = $Sprite3D
@onready var back_hidder: MeshInstance3D = $BackHidder


@onready var sub_viewport: SubViewport = $SubViewport

var noise_texture : ViewportTexture

@onready var texture_rect: TextureRect = $SubViewport/TextureRect
var noise : NoiseTexture2D
var noise_seed : int = 0 
var noise_fz : float = 100

#func _ready() -> void:
	#noise_texture = ViewportTexture.new()
	#SetTogglePovOutOfSignal()
	#noise = texture_rect.texture

func SetTogglePovOutOfSignal():
	noise_texture.viewport_path = sub_viewport.get_path()
	sprite_3d.texture = noise_texture

func SetTogglePovMainMonitor(POV : SubViewport):
	noise_texture.viewport_path = POV.get_path()
	sprite_3d.texture = noise_texture

#func _physics_process(delta: float) -> void:
	#
	#noise_seed = (int(delta * noise_fz) + noise_seed) % 10
	#noise.noise.set("seed", noise_seed)
