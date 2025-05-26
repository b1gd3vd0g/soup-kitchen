class_name FryingPan extends CharacterBody2D

signal fryable_cooked

func _physics_process(_delta: float) -> void:
	var velocity = get_global_mouse_position() - global_position
	move_and_collide(velocity)
	
	move_and_slide()


func _on_frying_area_body_exited(_body: Node2D) -> void:
	var bodies = $FryingArea.get_overlapping_bodies()
	#Activate aesthetic indicator
	$OilParticle.emitting = false
	$ProgressMarkerHitbox/CollisionShape2D.set_deferred("disabled", true)
	for the_body in bodies:
		if the_body is Fryable:
			$OilParticle.emitting = true
			$ProgressMarkerHitbox/CollisionShape2D.set_deferred("disabled", false)
	


func _on_frying_area_body_entered(body: Node2D) -> void:
	if body is Fryable:
		$OilParticle.emitting = true
		$ProgressMarkerHitbox/CollisionShape2D.set_deferred("disabled", false)


func _on_progress_route_progress_completed() -> void:
	var bodies = $FryingArea.get_overlapping_bodies()
	for body in bodies:
		if body is Fryable:
			body.cook()
