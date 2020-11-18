tool
class_name Player
extends KinematicBody

# Cameras
onready var camera: CameraRig = $CameraRig
onready var dameCamera: Spatial = $DameCam

# Body
onready var skin: Soink = $Soink
onready var skin_shape: CollisionShape = $CollisionShape
onready var hitbox: Area = $HitBox

# State Machine
onready var state_machine: StateMachine = $StateMachine

# Sound effects
onready var sfx: Node = $SFX
