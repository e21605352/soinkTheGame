extends Control



func _input(event):
	if event is InputEventKey or event is InputEventJoypadButton:
		if event.pressed:
			print("lol")
