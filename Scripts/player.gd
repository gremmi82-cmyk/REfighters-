class_name Player
extends CharacterBody2D

@onready var state_machine: StateMachine = $'StateMachine'
@onready var animation: AnimatedSprite2D = $AnimatedSprite

@export var max_health: int = 100
var current_health: int
signal health_changed(new_health: int)

func _ready(): 
	state_machine.init($StateMachine/Idle)
	current_health = max_health
	await get_tree().process_frame
	health_changed.emit(current_health)

func _process(delta): state_machine.process_frame(delta)

func _physics_process(delta): state_machine.process_physics(delta)

func _input(event): state_machine.process_input(event)

func handle_hit():
	if state_machine and state_machine.current_state:
		state_machine.current_state.take_damage()

func take_damage(amount: int) -> void:
	if current_health <= 0:
		return
	current_health -= amount
	health_changed.emit(current_health)
	#print('Got damage',amount,'hp:',current_health)
	if current_health <= 0:
		defeat()
	else:
		handle_hit()

func defeat() -> void:
	print('Игрок 1 сражён')
	if state_machine and state_machine.has_method("change_state"):
		var defeat_node = state_machine.get_node_or_null("Defeat")
		if defeat_node:
			state_machine.change_state(defeat_node)
