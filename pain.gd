class_name PlayerPainState
extends PlayerState

@onready var hurt_box: HurtBox
var has_pained: bool

func enter() -> void:
	has_pained = false
	player.animation.play(pain_anim)
	player.animation.animation_finished.connect(func(): has_pained  = true, CONNECT_ONE_SHOT)

func process_input(event: InputEvent) -> State:
	super(event)
	if has_pained and event.is_action_pressed(movement_key):
		determine_sprite_flipped(event.as_text())
		return run_state
	elif has_pained and event.is_action_pressed(jump_key):
		return jump_state
	return null
	
func process_frame(delta: float) -> State:
	super(delta)
	if has_pained:
		return idle_state
	return null
