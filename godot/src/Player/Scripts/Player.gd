tool
class_name Player
extends KinematicBody
# Helper class for the Player scene's scripts to be able to have access to the
# camera and its orientation.

onready var camera: CameraRig = $CameraRig
onready var skin: Soink = $Soink
onready var skin_roll: SoinkRoll = $SoinkRoll
onready var state_machine: StateMachine = $StateMachine
onready var sfx: Node = $SFX
onready var c_shape: CollisionShape = $CollisionShape
