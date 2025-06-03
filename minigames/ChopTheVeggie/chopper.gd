class_name Chopper extends Node2D

##A knife used for chopping veggies. Used in ChopTheVegetables
##minigame.

@export var debug = false

##We cache the y-position so we can return to the same position after 
##playing the chop animation.
var y_transform = 0
##We also cache the animation progress of 'alternate' for the same reason
var animation_progress
var cut_valid = false

##In summary, we set the chop as valid when we hover over a chop marker
##and invalid when we don't
func _process(_delta: float) -> void:
	position.y = y_transform
	if Input.is_action_just_pressed("left_click"):
		$AnimationPlayer.pause()
		animation_progress = $AnimationPlayer.current_animation_position  
		if cut_valid == true:
			$AnimationPlayer.play("chop")
		else:
			$AnimationPlayer.play("error")
	if cut_valid == true:
		modulate = Color.GREEN
	else:
		modulate = Color.WHITE
	queue_redraw()

##Debug information
func _draw() -> void:
	if debug == true:
		draw_circle($CollisionShape2D.position,10,Color.AQUA)

##After we play the 'chop' animation, we pick up the 'alternate' from where
##it left off.
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "chop" or anim_name == "error":
		$AnimationPlayer.play("alternate")
		$AnimationPlayer.advance(animation_progress)
