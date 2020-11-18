extends Control


func _ready():
	MusicController.stop()

func _on_Timer_timeout():
	$VideoPlayer.visible = true
	$VideoPlayer.play()


func _on_VideoPlayer_finished():
	SceneChanger.change_scene('res://src/Menus/TitleScreen.tscn', 'end')
