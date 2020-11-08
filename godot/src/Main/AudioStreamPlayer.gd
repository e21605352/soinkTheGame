extends AudioStreamPlayer


func _ready():
	pass


func _process(delta):
	if playing == false:
		play()


func _on_sprint_started():
	set_stream_paused(true)



func _on_sprint_finished():
	set_stream_paused(false)
