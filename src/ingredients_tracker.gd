extends Node

@export var ingredients_prepared: Array[Ingredient]

func _ready() -> void:
	var ingredient = Ingredient.new()
	ingredient.set("name", "Meat")
	ingredient.set("filepath", "res://minigames/CatchTheIngredients/MeatIngredient.tscn")
	ingredient.set("quantity", 1)
	
	ingredients_prepared.append(ingredient)
	
	ingredient = Ingredient.new()
	ingredient.set("name", "Meat")
	ingredient.set("filepath", "res://minigames/CatchTheIngredients/VegetableIngredient.tscn")
	ingredient.set("quantity", 3)
