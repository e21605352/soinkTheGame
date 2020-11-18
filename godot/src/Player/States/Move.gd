extends PlayerState
# Parent state for all movement-related states for the Player.
# Holds all of the base movement logic.
# Child states can override this state's functions or change its properties.
# This keeps the logic grouped in one location.

export var run_speed = 10.0
export var sprint_speed = 50.0
export var gravity = -80.0
export var jump_impulse = 25
export(float, 0.1, 20.0, 0.1) var rotation_speed_factor: = 10.0

var move_speed: float

var is_sprinting = false
var velocity: = Vector3.ZERO

func _ready() -> void:
	move_speed = run_speed


func unhandled_input(event: InputEvent) -> void:
	if not Game.game_finished:
		
		if event.is_action_pressed("jump"):
			_state_machine.transition_to("Move/Air", { velocity = velocity, jump_impulse = jump_impulse })
			
		elif event.is_action_pressed("toggle_sprint"):
			if not is_sprinting:
				default_to_roll()
			else:
				roll_to_default()
			_state_machine.transition_to("Move/Idle")
			
		elif not is_sprinting:
			if event.is_action_pressed("click"):
				_state_machine.transition_to("Move/Attack")
			
			if event.is_action_pressed("animation_1"):
				_state_machine.transition_to("Move/Animation", { animation = 1})
				
			elif event.is_action_pressed("animation_2"):
				_state_machine.transition_to("Move/Animation", { animation = 2})
				
			elif event.is_action_pressed("animation_3"):
				_state_machine.transition_to("Move/Animation", { animation = 3})


func physics_process(delta: float) -> void:
	if not Game.game_finished:
		var input_direction: = get_input_direction()

		# Calculate a move direction vector relative to the camera
		# The basis stores the (right, up, -forwards) vectors of our camera.
		var forwards: Vector3 = player.camera.global_transform.basis.z * input_direction.z
		var right: Vector3 = player.camera.global_transform.basis.x * input_direction.x
		var move_direction: = forwards + right
		if move_direction.length() > 1.0:
			move_direction = move_direction.normalized()
		move_direction.y = 0
		skin.move_direction = move_direction

		# Rotation
		if move_direction:
			var target_direction: = player.transform.looking_at(player.global_transform.origin + move_direction, Vector3.UP)
			player.transform = player.transform.interpolate_with(target_direction, rotation_speed_factor * delta)

		# Movement
		velocity = calculate_velocity(velocity, move_direction, delta)
		velocity = player.move_and_slide(velocity, Vector3.UP)
		
	elif is_sprinting:
		roll_to_default()


func calculate_velocity(velocity_current: Vector3, move_direction: Vector3, delta: float) -> Vector3:
	var velocity_new := move_direction * move_speed
	if velocity_new.length() > move_speed:
		velocity_new = velocity_new.normalized() * move_speed
	velocity_new.y = velocity_current.y + gravity * delta
	return velocity_new


func default_to_roll():
	player.skin.get_node("Default").visible = false
	player.skin.get_node("Roll").visible = true
	player.skin_shape.cshape.height = 1.65
	move_speed = sprint_speed
	MusicController.pause()
	player.sfx.get_node("Sprint-SFX").play()
	is_sprinting = true


func roll_to_default():
	player.skin.get_node("Default").visible = true
	player.skin.get_node("Roll").visible = false
	player.skin_shape.cshape.height = 2.2
	move_speed = run_speed
	player.sfx.get_node("Sprint-SFX").stop()
	MusicController.resume()
	is_sprinting = false


static func get_input_direction() -> Vector3:
	return Vector3(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			0,
			Input.get_action_strength("move_back") - Input.get_action_strength("move_front")
		)
