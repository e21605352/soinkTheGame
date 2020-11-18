extends KinematicBody

var path = []
var path_node = 0

export var speed = 5

onready var nav = get_parent()
onready var player = $"../../Player"

onready var animation: AnimationPlayer = $Robotnik/AnimationPlayer

func _ready():
	pass
	

func _physics_process(_delta):
	if not Game.game_finished:
		if path_node < path.size():
			var direction = (path[path_node] - global_transform.origin)
			if direction.length() < 1:
				path_node += 1
			else:
				move_and_slide(direction.normalized() * speed, Vector3.UP)
				look_at(player.global_transform.origin, Vector3.UP)


func move_to_player():
	path = nav.get_simple_path(global_transform.origin, player.global_transform.origin)
	path_node = 0


func death():
	Game.game_finished = true
	animation.play("death")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "death":
		var credits = ResourceLoader.load("res://src/Menus/Credits.tscn")
		var instancedCredits = credits.instance()
		self.add_child(instancedCredits)
