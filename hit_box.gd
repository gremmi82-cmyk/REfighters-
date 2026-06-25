class_name HitBox
extends Area2D

var owner_node: Node2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@export var damage: int = 10

func turn_off():
	if collision_shape:
		collision_shape.set_deferred("disabled", true)

func turn_on():
	if collision_shape:
		collision_shape.set_deferred("disabled", false)

func _ready():
	collision_layer = 2
	collision_mask = 0
	owner_node = owner
