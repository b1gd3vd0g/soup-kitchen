extends Area2D

##The piece of a chop marker which will destroy it upon being chopped.

func _on_destroybox_area_entered(area):
	if area is Chopper:
		var scene = load("res://minigames/ChopTheVeggie/ParticleBurst.tscn")
		var instance= scene.instantiate()
		get_tree().root.add_child(instance)
		instance.position = position
		instance.burst(Color.ORANGE)
		queue_free()
