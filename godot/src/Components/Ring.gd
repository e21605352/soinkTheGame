extends Area

func _ready():
	pass

func _physics_process(delta):
	rotate_y(deg2rad(3))


func _on_Ring_body_entered(body):
	if body.name == "Player":
		$AudioStreamPlayer.play()
		emit_signal("ringCollected")
		visible = false

func _on_AudioStreamPlayer_finished():
	queue_free()
