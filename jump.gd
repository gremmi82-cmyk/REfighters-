class_name PlayerJumpState
extends PlayerState

const AIR_SPEED: float = 250
const JUMP_FORCE: float = -350

func enter() -> void:
	super()
	player.velocity.y = JUMP_FORCE
	player.animation.play(jump_anim)

func exit(new_state: State = null) -> void:
	super(new_state)
	player.velocity.x = 0.0

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed(movement_key):
		determine_sprite_flipped(event.as_text())
	super(event)
	return null

func process_physics(delta: float) -> State:
	#print(player.velocity)
	do_move(get_move_dir())
	super(delta)
	#if player.is_on_floor():
		#if get_move_dir() != 0.0:
			#return run_state
		#return idle_state
	if player.velocity.y > 0.0:
		return fall_state
	return null
	#return super(delta)

func get_move_dir() -> float:
	return Input.get_axis(left_key,right_key)

func do_move(move_dir: float) -> void:
	player.velocity.x = move_dir * AIR_SPEED
