class_name PlayerIdleState
extends PlayerState

func enter() -> void:
	super()
	player.animation.play(idle_anim)

func exit(new_state: State = null) -> void:
	super(new_state)

func process_input(event: InputEvent) -> State:
	super(event)
	if event.is_action_pressed(movement_key):
		determine_sprite_flipped(event.as_text())
		return run_state
	elif event.is_action_pressed(jump_key): 
		return jump_state
	elif event.is_action_pressed(attack_key):
		return attack1_state
	return null

func process_physics(delta: float) -> State:
	super(delta)
	if not player.is_on_floor():
		return fall_state
	return null
