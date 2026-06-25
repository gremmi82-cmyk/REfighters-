class_name PlayerFallState
extends PlayerState

const AIR_SPEED: float = 250

func enter() -> void:
	super()
	player.animation.play(fall_anim)

func exit(new_state: State = null) -> void:
	super(new_state)
	#player.velocity.x = 0.0

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed(movement_key):
		determine_sprite_flipped(event.as_text())
	super(event)
	return null

func process_physics(delta: float) -> State:
	#print(player.velocity)
	do_move(get_move_dir())
	if player.is_on_floor():
		if get_move_dir() != 0.0:
			return run_state
		else:
			return idle_state
	player.velocity.y += gravity * delta
	player.move_and_slide()
	return null

func get_move_dir() -> float:
	return Input.get_axis(left_key,right_key)

func do_move(move_dir: float) -> void:
	player.velocity.x = move_dir * AIR_SPEED
