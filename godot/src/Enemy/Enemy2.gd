extends KinematicBody

export var speed = 5

onready var player = $"../Player"


#func _physics_process(_delta):
#	var direction = (player.global_transform.origin - global_transform.origin)
#	move_and_slide(direction.normalized() * speed, Vector3.UP)
#	look_at(player.global_transform.origin, Vector3.UP)
