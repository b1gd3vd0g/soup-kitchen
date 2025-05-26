class_name Chopper extends Node2D

@export var debug = false

var y_transform = 0
var animation_progress
var cut_valid = false

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

func _draw() -> void:
	if debug == true:
		draw_circle($CollisionShape2D.position,10,Color.AQUA)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "chop" or anim_name == "error":
		$AnimationPlayer.play("alternate")
		$AnimationPlayer.advance(animation_progress)
