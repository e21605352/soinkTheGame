extends Spatial
class_name Soink

enum States { IDLE, RUN, AIR, ATTACK, ANIM1, ANIM2, ANIM3 }

onready var animation_tree: AnimationTree = $Default/AnimationTree
onready var _playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]

var move_direction := Vector3.ZERO setget set_move_direction


func _ready() -> void:
	animation_tree.active = true


func set_move_direction(direction: Vector3) -> void:
	move_direction = direction
	animation_tree["parameters/move_ground/blend_position"] = direction.length()


func transition_to(state_id: int) -> void:
	match state_id:
		States.IDLE:
			_playback.travel("idle")
		States.RUN:
			_playback.travel("move_ground")
		States.AIR:
			_playback.travel("jump")
		States.ATTACK:
			_playback.travel("attack")
		States.ANIM1:
			_playback.travel("soink-twerk")
		States.ANIM2:
			_playback.travel("soink-female-pose")
		States.ANIM3:
			_playback.travel("soink-rumba")
		_:
			_playback.travel("idle")
