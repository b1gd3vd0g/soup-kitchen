class_name Ingredient 
extends RigidBody2D

@export var record: IngredientRecord

func _on_despawn_timer_timeout() -> void:
	queue_free()
