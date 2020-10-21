extends PlayerState
# State for when there is no movement input.
# Supports triggering jump after the player started to fall.

func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if player.is_on_floor() and _parent.velocity.length() > 0.01:
		_state_machine.transition_to("Move/Run")
	elif not player.is_on_floor():
		_state_machine.transition_to("Move/Air")


func enter(msg: Dictionary = {}) -> void:
		match msg:
			{"is_sprinting": var sprint}:
				if is_sprinting = false:
					if _parent.velocity.length() > 0.01:
						_parent.move_speed = 50
						_parent.max_speed = 50
						_parent.is_sprinting


func exit() -> void:
	_parent.exit()
