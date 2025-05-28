extends CharacterBody2D

func _physics_process(_delta: float) -> void:
	var velocity = get_global_mouse_position() - global_position
	move_and_collide(velocity)
	
	move_and_slide()
