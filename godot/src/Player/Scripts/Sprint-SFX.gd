extends AudioStreamPlayer


func _ready():
	pass


func _on_sprint_started():
	play()


func _on_sprint_finished():
	stop()
