class_name HurtBox
extends Area2D

@onready var pain_state: PlayerPainState
@onready var state_machine: StateMachine
signal took_damage

func _ready():
	collision_layer = 0
	collision_mask = 2
	self.area_entered.connect(on_area_entered)
	
func on_area_entered(hit_box: HitBox) -> void:
	if hit_box == null: return
	#DAMAGE
	if hit_box.owner_node == self.owner:
		return
	if owner.has_method("take_damage"):
		owner.take_damage(hit_box.damage)
