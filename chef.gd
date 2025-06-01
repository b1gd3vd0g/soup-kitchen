class_name Chef
extends CharacterBody2D

## The speed of the chef when moving (in pixels per second).
@export var speed: int = 200

## Is the chef currently listening for user input?
var listening: bool = true

var bound_a: Vector2 = Vector2.ZERO
var bound_b: Vector2

## Make the chef start (or stop) listening for human input.
func listen(fr: bool = true) -> void:
	listening = fr

func display_action_icon(fr: bool = true) -> void:
	if fr:
		$ActionIcon.show()
	else:
		$ActionIcon.hide()

func set_bounds(upper_bound: Vector2) -> void:
	bound_b = upper_bound

func _ready():
	display_action_icon(false)

func _process(delta: float) -> void:
	# Calculate velocity according to user input:
	var chef_velocity: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		chef_velocity.y -= 1
		$Sprite.animation = "walk_up"
	if Input.is_action_pressed("move_down"):
		chef_velocity.y += 1
		$Sprite.animation = "walk_down"
	if Input.is_action_pressed("move_left"):
		chef_velocity.x -= 1
		$Sprite.animation = "walk_left"
	if Input.is_action_pressed("move_right"):
		chef_velocity.x += 1
		$Sprite.animation = "walk_right"
	 
	# Normalize the speed and play/stop the animation
	if chef_velocity.length() > 0:
		chef_velocity = chef_velocity.normalized() * speed
		$Sprite.play()
	else:
		$Sprite.stop()
	
	# Actually move the guy.
	position += chef_velocity * delta
	position = position.clamp(bound_a, bound_b)
