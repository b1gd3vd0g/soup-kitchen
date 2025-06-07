class_name IngredientSpawner extends Marker2D

##This is for test purposes only, delete soon
@export var ingredients: Array[IngredientRecord]

func _ready() -> void:
	for ingredient in ingredients:
		IngredientsTracker.add_ingredient(ingredient)

##A weighted RNG machine.
##Drops ingredients randomly, weighted according to how many ingredients
##the player has prepared.

##Weighted RNG algorithm.
##Detailed explanation found on youtube and provided by Gwizz
##https://www.youtube.com/watch?v=sHHIcDG7Um0
func roll() -> IngredientRecord:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var weighted_sum = 0
	
	for ingredient in IngredientsTracker.ingredients_prepared:
		weighted_sum = weighted_sum + ingredient.quantity
	
	var roll = randi_range(0, weighted_sum)
	
	for ingredient in IngredientsTracker.ingredients_prepared:
		if roll <= ingredient.quantity:
			return ingredient
		else:
			roll = roll - ingredient.quantity
	return IngredientsTracker.ingredients_prepared[0]

#Spawns rolled ingredient and resets timer
func _on_timer_timeout() -> void:
	var ingredient = roll()
	
	var scene = load(ingredient.filepath)
	var instance = scene.instantiate()
	get_tree().root.add_child(instance)
	instance.position = position
	
	$Timer.wait_time = randf_range(1, 3)
	$Timer.start()
