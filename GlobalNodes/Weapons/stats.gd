class_name BaseWeaponStats
extends Node

@export var NAME : String

var TYPE = "Weapon"

enum WEAPON_TYPE {NONE, RANGED, MELEE}
@export var WEAPON : WEAPON_TYPE

enum HELD_TYPE {NONE, ONE_HAND, TWO_HAND}
@export var HELD : HELD_TYPE

enum FIRING_TYPE {SEMI_AUTO, AUTO}
@export var FIRING : FIRING_TYPE

@export var MAX_AMMO : int
@export var AMMO : int
