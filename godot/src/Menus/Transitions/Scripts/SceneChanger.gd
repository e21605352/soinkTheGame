extends CanvasLayer

onready var animationPlayer : AnimationPlayer = $Control/AnimationPlayer
var scene : String


func change_scene(new_scene, anim):
	scene = new_scene
	animationPlayer.play(anim)


func _new_scene():
	if get_tree().change_scene(scene) != OK:
		print ("An unexpected error occured when trying to switch to " + scene + " scene")
