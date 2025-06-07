extends Node2D

enum CounterType {
	CUTTING_BOARD,
	FRIDGE,
	SINK,
	STANDARD,
	STOVE_OFF,
	STOVE_ON
}

@export var type: CounterType = CounterType.STANDARD

@export var filepath: String

var has_chef: bool = false

func start_minigame(filepath: String) -> void:
	get_tree().change_scene_to_file("res://minigames/CatchTheIngredients/Main.tscn")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and has_chef:
		start_minigame(":)")


func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body is Chef:
		has_chef = true;


func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body is Chef:
		has_chef = false
