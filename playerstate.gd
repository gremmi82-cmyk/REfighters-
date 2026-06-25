class_name PlayerState
extends State

@onready var player: Player = get_tree().get_first_node_in_group("Player")

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity",9.8)

#Anim names
var idle_anim: String = "Idle"
var run_anim: String = "Run"
var jump_anim: String = "Jump"
var fall_anim: String = "Fall"
var attack1_anim: String = "Attack1"
var attack2_anim: String = "Attack2"
var pain_anim: String = "Pain"

#States
@export_group("States")
@export var idle_state: PlayerState
@export var run_state: PlayerState
@export var jump_state: PlayerState
@export var fall_state: PlayerState
@export var attack1_state: PlayerState
@export var attack2_state: PlayerState
@export var pain_state: PlayerState
@export var defeat_state: PlayerState

#State Variables
var sprite_flipped: bool = false
var got_hit: bool = false

#Input Keys
var movement_key: String = "Movement"
var left_key: String = "Left"
var right_key: String = "Right"
var jump_key: String = "Jump"
var attack_key: String = "Attack"

#Input Actions
var left_actions: Array = InputMap.action_get_events(left_key).map(func(action: InputEvent) -> String: return action.as_text().get_slice("-", 0).strip_edges())
var right_actions: Array = InputMap.action_get_events(right_key).map(func(action: InputEvent) -> String: return action.as_text().get_slice("-", 0).strip_edges())

#Util Fn
func determine_sprite_flipped(event_text: String) -> void:
	#print(left_actions)
	#print(right_actions)
	if left_actions.find(event_text) != -1:
		sprite_flipped = true
	elif right_actions.find(event_text) != -1:
		sprite_flipped = false
	if sprite_flipped:
		player.animation.scale.x = -1.0
		player.animation.position.x = 0.0 
	else:
		player.animation.scale.x = 1.0
		player.animation.position.x = 0.0

func take_damage() -> void:
	got_hit = true

#Base Fn
func process_frame(delta: float) -> State:
	if got_hit:
		got_hit = false
		return pain_state
	return null

func process_physics(delta: float) -> State:
	player.velocity.y += gravity * delta
	player.move_and_slide()
	return null
	
func exit(new_state: State = null) -> void:
	super()
	new_state.sprite_flipped = sprite_flipped
