class_name Minigame extends Node2D

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("return_to_kitchen")):
		pass

func update_ingredients_tracker(name: String, quantity: int):
	for record in IngredientsTracker.ingredients_prepared:
		if record.name == "name":
			record.quantity += quantity
			return
