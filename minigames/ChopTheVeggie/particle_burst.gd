class_name ParticleBurst extends CPUParticles2D

func burst(the_color: Color):
	color = the_color
	emitting = true

func _on_finished() -> void:
	queue_free()
