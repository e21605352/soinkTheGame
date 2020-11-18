extends Spatial


func _ready():
	MusicController.play("res://assets/sounds/musics/lvl_1.wav")
	
	
func _on_Area_body_entered(body):
	Game.game_finished = true
	
	$Area/CollisionShape.disabled = true
	var credits = ResourceLoader.load("res://src/Menus/Credits.tscn")
	var instancedCredits = credits.instance()
	self.add_child(instancedCredits)
