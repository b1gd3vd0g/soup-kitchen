class_name FryingPan extends CharacterBody2D

##Cooks fryables. It does this by having the player hit progress markers.
##Upon hitting a progress marker, it will call cook on all fryables withing the cooking area
##And then advance the active progress marker.

##Controls how many times a progress bar needs to be completed before fryables get cooked.
var progress_hits_needed = 5
var progress_hits = 0

##Sets up progress bars.
func _ready():
	var progress_bars = $CanvasLayer.get_children()
	for bar in progress_bars:
		bar.set_active(false)
	var roll = randi_range(0,1)
	progress_bars[roll].set_active(true)

##Moves pan to mouse position
func _physics_process(_delta: float) -> void:
	var velocity = get_global_mouse_position() - global_position
	move_and_collide(velocity)
	
	move_and_slide()

##Determines when progress bars can be successfully hit. The player
##needs to keep the fryable in the pan while hitting progress bars to succeed.
func _on_frying_area_body_exited(_body: Node2D) -> void:
	var bodies = $FryingArea.get_overlapping_bodies()
	#Activate aesthetic indicator
	$OilParticle.emitting = false
	$ProgressMarkerHitbox/CollisionShape2D.set_deferred("disabled", true)
	for the_body in bodies:
		if the_body is Fryable:
			$OilParticle.emitting = true
			$ProgressMarkerHitbox/CollisionShape2D.set_deferred("disabled", false)
	
##See above.
func _on_frying_area_body_entered(body: Node2D) -> void:
	if body is Fryable:
		$OilParticle.emitting = true
		$ProgressMarkerHitbox/CollisionShape2D.set_deferred("disabled", false)


##When progress bars are completed it will cycle between verticle and horizontal progress bars.
func _on_horizontal_progress_completed() -> void:
	var bodies = $FryingArea.get_overlapping_bodies()
	for body in bodies:
		if body is Fryable:
			body.cook()
	progress_hits = progress_hits + 1
	if progress_hits >= progress_hits_needed:
		var progress_bars = $CanvasLayer.get_children()
		for bar in progress_bars:
			bar.set_active(false)
		var roll = randi_range(0,1)
		progress_bars[1].set_active(true)
		progress_hits = 0

func _on_vertical_progress_completed() -> void:
	var bodies = $FryingArea.get_overlapping_bodies()
	for body in bodies:
		if body is Fryable:
			body.cook()
	progress_hits = progress_hits + 1
	if progress_hits >= progress_hits_needed:
		var progress_bars = $CanvasLayer.get_children()
		for bar in progress_bars:
			bar.set_active(false)
		progress_bars[0].set_active(true)
		progress_hits = 0
