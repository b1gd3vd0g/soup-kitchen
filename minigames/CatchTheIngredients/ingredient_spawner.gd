extends Marker2D


func _on_timer_timeout() -> void:
	var scene = load("res://minigames/CatchTheIngredients/Ingredient.tscn")
	var instance = scene.instantiate()
	get_tree().root.add_child(instance)
	instance.position = position
	
	$Timer.wait_time = randi_range(1, 10)
	$Timer.start()
