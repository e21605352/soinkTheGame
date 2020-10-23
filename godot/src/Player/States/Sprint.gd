extends PlayerState

func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if player.is_on_floor() and _parent.velocity.length() > 0.01:
		_state_machine.transition_to("Move/Run")
	elif not player.is_on_floor():
		_state_machine.transition_to("Move/Air")


func enter(msg: Dictionary = {}) -> void:
		match msg:
			{"is_sprinting": var sprint}:
				if sprint == false:
					if _parent.velocity.length() > 0.01:
						_parent.move_speed = _parent.sprint_speed
						_parent.is_sprinting = true
						player.sfx.get_node("Sprint-SFX").play()
				else:
					_parent.move_speed = _parent.run_speed
					_parent.is_sprinting = false
					player.sfx.get_node("Sprint-SFX").stop()
		_parent.enter()

func exit() -> void:
	_parent.exit()

func _process(delta):
	if player.sfx.get_node("Sprint-SFX").playing == false and _parent.is_sprinting == true:
		player.sfx.get_node("Sprint-SFX").play()
