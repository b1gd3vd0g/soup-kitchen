"""
A Counter is a versatile class that has these primary functionalities:
1) It is a decoration that makes the scene appear more like a kitchen.
2) It acts as a barrier that the Chef cannot walk through.
3) Certain counters (CUTTING_BOARD and STOVE) can be interacted with to launch
minigames.
"""
extends Node2D

## The types of counters that can be drawn.
enum CounterType {
	CUTTING_BOARD,
	FRIDGE,
	SINK,
	STANDARD,
	STOVE
}

@export var type: CounterType

var minigame_filepath: String = ""

var has_chef: bool = false

## This function prepares the counter, based on its given `type`. It will:
## 1) Configure the sprite properly
## 2) 
func _ready() -> void:
	# Set the minigame filepath (when required) and the animation.
	var animation
	match type:
		CounterType.CUTTING_BOARD:
			minigame_filepath = "res://minigames/ChopTheVeggie/Main.tscn"
			animation = "cutting_board"
		CounterType.FRIDGE:
			animation = "fridge"
		CounterType.SINK:
			animation = "sink"
		CounterType.STANDARD:
			animation = "standard"
		CounterType.STOVE:
			minigame_filepath = "res://minigames/FryTheMeat/Main.tscn"
			animation = "stove"
	# Make sure to actually apply the animation:
	$Sprite.animation = animation
	if not minigame_filepath:
		$InteractionArea.hide()

func start_minigame() -> void:
	get_tree().change_scene_to_file(minigame_filepath)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and has_chef:
		start_minigame()


func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body is Chef:
		has_chef = true;


func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body is Chef:
		has_chef = false
