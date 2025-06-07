extends CharacterBody2D

##This is a soup pot.
##You move the pot left and right with the arrow keys to catch ingredients.

##Controls how fast the soup pot moves left and right.
@export var speed = 50

##CharacterBodies are objects within the physics engine whose behaviour
##we dictate through code. As with all physics objects, there
##are rules to this which must be followed.
##The general algorithm for moving a CharacterBody goes like this:
##	[1]: Calculate the direction (hereto called velocity) you want to move ur CharacterBody
##	[2]: Apply that new velocity using either move_and_slide() or move_and_collide()
##
##	[!]: Remember, position updates have to be done in the _physics_process() call.

##Here, we will setup the pot to be controlled by our user.

func _physics_process(_delta: float) -> void:
	#First we begin calculating a velocity, starting at zero.
	var velocity = Vector2.ZERO
	#We then check what input's been called, either left or right, and add that to our velocity
	if Input.is_action_pressed("move_right"):
		velocity += Vector2.RIGHT
	if Input.is_action_pressed("move_left"):
		velocity += Vector2.LEFT
	#Before sending that new velocity out, we may want to have some control over how fast our pot moves.
	#To do this, we are going to normalize our velocity vector and then multiply it by our speed scalar,
	#defined above.
	velocity = velocity.normalized() * speed
	
	#Now, we send our new velocity out to the physics engine. We let the physics engine handle 
	#the job of detecting collisions and tings.
	move_and_collide(velocity)

func _on_collection_zone_body_entered(body: Node2D) -> void:
	if body is Ingredient:
		if body.record.name == "Veggie":
			$CanvasLayer/Recipe.collect_veggie()
		if body.record.name == "Meat":
			$CanvasLayer/Recipe.collect_meat()
		body.queue_free()
	

func _on_recipe_recipe_completed() -> void:
	IngredientsTracker.soup_prepared.quantity += 1
