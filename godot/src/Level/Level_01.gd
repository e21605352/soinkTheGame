extends Spatial


func _on_Area_body_entered(body):
	Game.game_finished = true
	
	$Area/CollisionShape.disabled = true
	var credits = ResourceLoader.load("res://src/Menus/Credits.tscn")
	var instancedCredits = credits.instance()
	self.add_child(instancedCredits)
	$AudioStreamPlayer.free()
