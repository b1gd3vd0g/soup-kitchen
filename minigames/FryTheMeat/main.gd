extends Minigame

const MAX_FRYABLES = 4
var fryables_in_scene = 0

var score = 0

func _ready() -> void:
	for i in range(0, 4):
		call_deferred("spawn_fryable")

func spawn_fryable():
	var scene = load("res://minigames/FryTheMeat/Meat.tscn")
	var instance = scene.instantiate()
	get_tree().root.call_deferred("add_child", instance)
	instance.position = $FryableSpawnMarker.position + Vector2(randf_range(0,1), randf_range(0,1))
	print(instance.position)
	
	instance.fryable_cooked.connect(spawn_fryable)
	instance.fryable_cooked.connect(update_score_counter)
	instance.fryable_cooked.connect(update_ingredients_tracker("Meat", 1))
	
	fryables_in_scene = fryables_in_scene + 1

func update_score_counter():
	score = score + 1
	$Label.text = "x" + str(score)


func _on_fryable_loss_area_body_entered(body: Node2D) -> void:
	if body is Fryable:
		body.queue_free()
		spawn_fryable()
