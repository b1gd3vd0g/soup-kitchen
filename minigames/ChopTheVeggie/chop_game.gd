extends Minigame

##Driver for ChopTheVegetables.
##Tracks score and manages respawning choppable ingredients.

var vegetables_chopped = 0

##Wait a little bit before spawning new vegetable.
func _on_choppable_fully_chopped() -> void:
	vegetables_chopped = vegetables_chopped + 1
	$CanvasLayer/VegetablesChoppedScore.text = "x" + str(vegetables_chopped)
	update_ingredients_tracker("Veggie", 1)
	$ChoppableRespawnTimer.start()

##Spawn new vegetable.
func _on_choppable_respawn_timer_timeout() -> void:
	var scene = load("res://minigames/ChopTheVeggie/Carrot.tscn")
	var instance = scene.instantiate()
	get_tree().root.add_child(instance)
	instance.fully_chopped.connect(_on_choppable_fully_chopped)
