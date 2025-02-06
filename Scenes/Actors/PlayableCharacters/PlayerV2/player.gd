@tool
class_name PlayableCharacter
extends CharacterBody3D


@onready var stats : BaseEntityStats = $Stats

@onready var inputs: PlayerInputs = $Inputs
@onready var animations : PlayerAnimations = $Animations

var honrizontal_sens = 0.07
var vertical_sens = 0.1

@onready var neck: Node3D = $Neck
@onready var camera_3d: Camera3D = $Model/Mixamo/Armature/Skeleton3D/Head/Camera3D
@onready var camera_ray_cast: RayCast3D = $Model/Mixamo/Armature/Skeleton3D/Head/CameraRayCast

var is_first_person = true
@onready var first_person = $Model/Mixamo/Armature/Skeleton3D/Head/CollectionPositions/FirstPerson
@onready var third_person = $Model/Mixamo/Armature/Skeleton3D/Head/CollectionPositions/ThirdPerson

@onready var ik_right_hand = $Model/Mixamo/Armature/Skeleton3D/IKRightHand
@onready var ik_left_hand = $Model/Mixamo/Armature/Skeleton3D/IKLeftHand
@onready var ik_right_hand_target = $Neck/IKRightHandTarget
@onready var ik_left_hand_target = $Neck/IKLeftHandTarget

@onready var default_one_handed_weapon: Marker3D = $Neck/CollectionPositions/DefaultOneHandedWeapon
@onready var default_two_handed_weapon = $Neck/CollectionPositions/DefaultTwoHandedWeapon
@onready var focus_item: Marker3D = $Neck/CollectionPositions/FocusItem
@onready var left_hand_intercation: Marker3D = $Neck/CollectionPositions/LeftHandIntercation
@onready var left_two_handed_weapon: Marker3D = $Neck/CollectionPositions/LeftTwoHandedWeapon


@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_hands: AnimationPlayer = $AnimationHands
@onready var interactions: PlayerInteractions = $Interactions
@onready var right_hand: Marker3D = $Model/Mixamo/Armature/Skeleton3D/RightHand/Item/RightHand
@onready var left_hand: Marker3D = $Model/Mixamo/Armature/Skeleton3D/LeftHand/Item/LeftHand


var input_dir : Vector2
var direction : Vector3

func _ready() -> void:
	inputs.init(self)
	interactions.init(self)
	animations.init(self)
	right_hand.init(self)

func _input(event: InputEvent) -> void:
	if Engine.is_editor_hint(): return
	inputs.input(event)

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint(): return
	inputs.update(delta)
	interactions.update(delta)
	animations.update(delta)
	move_and_slide()
