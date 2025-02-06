class_name BaseEntityStats
extends Node

###### Stats
@export var BASE_HEALTH : float

###### Movement
@export var WALK_SPEED : float
@export var RUN_SPEED : float
@export var JUMP_HEIGHT : float


####### Info
var SPEED : float
var HEALTH : float = BASE_HEALTH : 
	set(value):
		if HEALTH <= 0:
			ALIVE = false
		else :
			ALIVE = true
	get():
		return HEALTH

var ALIVE : bool

# Used for inertactions and animations as well
enum EQUIPED_WEAPON_TYPE {NONE, ONE_HANDED_WEAPON_EQUIPED, TWO_HANDED_WEAPON_EQUIPED}
var EQUIPED_WEAPON : EQUIPED_WEAPON_TYPE = EQUIPED_WEAPON_TYPE.NONE

enum EQUIPED_ITEM_TYPE {NONE, ONE_HANDED_ITEM_EQUIPED, TWO_HANDED_ITEM_EQUIPED}
var EQUIPED_ITEM : EQUIPED_ITEM_TYPE = EQUIPED_ITEM_TYPE.NONE

enum POSSIBLE_INERACTION_TYPE {NONE, CAN_PICKUP_WEAPON, CAN_PICKUP_ITEM, CAN_INTERCAT}
var POSSIBLE_INTERCATION : POSSIBLE_INERACTION_TYPE = POSSIBLE_INERACTION_TYPE.NONE

var RIGHT_HAND_OCCUPIED : bool = false
var LEFT_HAND_OCCUPIED : bool = false

######
@export var CAN_LOOK_AROUND : bool = true
@export var CAN_MOVE : bool = true
@export var CAN_MAIN_ACTION : bool = true
@export var CAN_SECONDAIRE_ACTION : bool = true


######
enum MOVEMENT_TYPES {IDLE, WALKING, RUNNING}
var MOVEMENT_STATE : MOVEMENT_TYPES 
