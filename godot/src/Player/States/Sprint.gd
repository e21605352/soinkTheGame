extends PlayerState

signal sprint_started
signal sprint_finished

func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if player.is_on_floor() and _parent.velocity.length() > 0.01:
		_state_machine.transition_to("Move/Run")
	elif not player.is_on_floor():
		_state_machine.transition_to("Move/Air")


func enter(msg: Dictionary = {}) -> void:
		match msg:
			{"is_sprinting": var sprint}:
				
				var s :CylinderShape = player.c_shape.shape
				
				if sprint == false:	
					if _parent.velocity.length() > 0.01:
						# Change visibility : Normal -> Roll
						player.skin.visible = false
						player.skin_roll.visible = true
						
						# Change collision shape
						s.height = 1.6
						
						# Change speed : Normal -> Fast
						_parent.move_speed = _parent.sprint_speed
						_parent.is_sprinting = true
						
						# Play epic gotta go fast music
						player.sfx.get_node("Sprint-SFX").play()
						emit_signal("sprint_started")
				else:
					# Change visibility : Roll -> Normal
					player.skin_roll.visible = false
					player.skin.visible = true

					# Change collision shape
					s.height = 2.2
					
					# Change speed : Fast -> Normal
					_parent.move_speed = _parent.run_speed
					_parent.is_sprinting = false
					
					# Stop epic gotta go fast music
					player.sfx.get_node("Sprint-SFX").stop()
					emit_signal("sprint_finished")
					
		_parent.enter()

func exit() -> void:
	_parent.exit()

func _process(delta):
	if player.sfx.get_node("Sprint-SFX").playing == false and _parent.is_sprinting == true:
		player.sfx.get_node("Sprint-SFX").play()
