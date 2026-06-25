class_name PlayerAttack2State
extends PlayerState

var has_attacked2: bool
@export var hit_box: HitBox

func enter() -> void:
	super()
	has_attacked2 = false
	player.animation.play(attack2_anim)
	if hit_box:
		hit_box.turn_on()
	if sprite_flipped:
		hit_box.scale.x = -1
	else:
		hit_box.scale.x = 1
	player.animation.animation_finished.connect(func(): has_attacked2 = true)

func process_input(event: InputEvent) -> State:
	if has_attacked2:
		if event.is_action_pressed(movement_key):
			determine_sprite_flipped(event.as_text())
			return run_state
		elif event.is_action_pressed(jump_key):
			return jump_state
	return super(event)

func process_frame(delta: float) -> State:
	if has_attacked2:
		if hit_box:
			hit_box.turn_off()
		return idle_state
	return null
