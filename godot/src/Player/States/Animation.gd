extends PlayerState

var index = 1

func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)


func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if player.is_on_floor() and _parent.velocity.length() > 0.01:
		_state_machine.transition_to("Move/Run")
	elif not player.is_on_floor():
		_state_machine.transition_to("Move/Air")


func enter(msg: Dictionary = {}) -> void:
	match msg:
		{"animation": var i }:
			index = i

			if index == 1:
				skin.transition_to(skin.States.ANIM1)
				MusicController.pause()
				player.sfx.get_node("Twerk-SFX").play()
				
			elif index == 2:
				skin.transition_to(skin.States.ANIM2)
				MusicController.pause()
				player.sfx.get_node("Dame-SFX").play()
				player.dameCamera.get_node("Camera").make_current()
				player.dameCamera.get_node("AnimationPlayer").play("turn-around")
				player.dameCamera.get_node("HeartParticules").emitting = true
				
			elif index == 3:
				skin.transition_to(skin.States.ANIM3)
				MusicController.pause()
				player.sfx.get_node("Rumba-SFX").play()

	_parent.enter()


func exit() -> void:
	if index == 1:
		player.sfx.get_node("Twerk-SFX").stop()
		MusicController.resume()
		
	elif index == 2:
		player.sfx.get_node("Dame-SFX").stop()
		MusicController.resume()
		player.dameCamera.get_node("AnimationPlayer").stop(true)
		player.camera.camera.make_current()
		player.dameCamera.get_node("HeartParticules").emitting = false
	
	elif index == 3:
		player.sfx.get_node("Rumba-SFX").stop()
		MusicController.resume()
		
	_parent.exit()
