extends PlayerState

func physics_process(delta: float) -> void:
	if not $Timer.is_stopped():
		if not Game.game_finished:
			for body in player.hitbox.get_overlapping_bodies():
				if body.is_in_group("Enemy"):
					body.death()
	
	else:
		if player.is_on_floor() and _parent.velocity.length() > 0.01:
			_state_machine.transition_to("Move/Run")
		else:
			_state_machine.transition_to("Move/Air")
		_parent.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	skin.transition_to(skin.States.ATTACK)
	$Timer.start()
	player.sfx.get_node("Attack-SFX").play()
	_parent.enter()


func exit() -> void:	
	_parent.exit()
