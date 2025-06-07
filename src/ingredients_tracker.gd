extends Node

@export var ingredients_prepared: Array[IngredientRecord]
@export var soup_prepared: IngredientRecord = IngredientRecord.new("Soup", "N/A", 0)

##Adds ingredient and sorts by quantity. The ingredients_prepared array
##needs to remain sorted descending so it can be used in weighted RNG machines.
func add_ingredient(new_ingredient: IngredientRecord):
	#Add quantity to existing instance, if it exists
	var exists = false
	
	for ingredient in ingredients_prepared:
		if new_ingredient.name == ingredient.name:
			ingredient.quantity = ingredient.quantity + new_ingredient.quantity
			exists = true
	#else add instance
	if exists == false:
		ingredients_prepared.append(new_ingredient)
	
	#sort descending by quantity
	ingredients_prepared.sort_custom(func(a, b): return a.quantity > b.quantity)
