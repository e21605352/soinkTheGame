extends Control

onready var _player: AudioStreamPlayer = $AudioStreamPlayer

func play(track_url : String):
	var track = load(track_url)
	_player.stream = track
	_player.play()


func stop():
	_player.stop()


func pause():
	_player.set_stream_paused(true)
	

func resume():
	_player.set_stream_paused(false)
