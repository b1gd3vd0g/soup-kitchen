# The Chef is the character which is controlled by the user.
# The Chef moves around with the WASD/arrow keys.
# The Chef can interact with various items in the kitchen in order to feed the
# most Mouths.

extends CharacterBody2D

@export var speed = 200
var screen_size

func _ready():
	screen_size = get_viewport().size()
	hide()

func _process(delta: float) -> void:
	# Move the chef according to user input.
	var chef_velocity: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		chef_velocity.y -= 1
		$Sprite.animation = "walk_up"
	if Input.is_action_pressed("move_down"):
		chef_velocity.y += 1
		$Sprite.animation = "walk_down"
	if Input.is_action_pressed("move_left"):
		chef_velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		chef_velocity.x += 1
	if chef_velocity.length() > 0:
		chef_velocity = chef_velocity.normalized() * speed
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
