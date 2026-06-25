class_name PlayerDefeatState
extends PlayerState

func enter() -> void:
	player.animation.play("Defeat")
	
	var hurt_box = player.get_node_or_null("HurtBox")
	if hurt_box:
		var shape = hurt_box.get_node_or_null("CollisionShape2D")
		if shape:
			shape.set_deferred("disabled", true)

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	player.velocity.y += gravity * delta
	player.velocity.x = move_toward(player.velocity.x, 0, 10) # Плавно останавливаем по горизонтали
	player.move_and_slide()
	return null
