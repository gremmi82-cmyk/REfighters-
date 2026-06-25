class_name PlayerAttack1State
extends PlayerState

var has_attacked1: bool
var combo: bool
@export var hit_box: HitBox

func enter() -> void:
	has_attacked1 = false
	combo = false
	player.animation.play(attack1_anim)
	if hit_box:
		hit_box.turn_on()
	if sprite_flipped:
		hit_box.scale.x = -1
	else:
		hit_box.scale.x = 1
	player.animation.animation_finished.connect(func(): has_attacked1 = true, CONNECT_ONE_SHOT)
	
func process_input(event: InputEvent) -> State:
	super(event)
	if not has_attacked1 and event.is_action_pressed(attack_key):
		combo = true
	if has_attacked1 and event.is_action_pressed(movement_key):
		determine_sprite_flipped(event.as_text())
		return run_state
	elif has_attacked1 and event.is_action_pressed(jump_key):
		return jump_state
	return null
	
func process_frame(delta: float) -> State:
	super(delta)
	if has_attacked1:
		if combo == false:
			if hit_box:
				hit_box.turn_off()
			return idle_state
		else:
			if hit_box:
				hit_box.turn_off()
			return attack2_state
	return null
