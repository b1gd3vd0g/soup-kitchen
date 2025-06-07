extends Node2D

##A recipe that can be filled by collecting ingredients in a pot.

signal recipe_completed

var meat_required
var veggies_required

var meat_collected = 0
var veggies_collected = 0

func _ready() -> void:
	generate_recipe()

func generate_recipe():
	meat_required = randi_range(3, 15)
	veggies_required = randi_range(3, 15)
	update_view()

func collect_veggie():
	veggies_collected += 1
	if(veggies_collected > veggies_required):
		generate_recipe()
		reset()
		return
	elif(veggies_collected == veggies_required && meat_collected == meat_required):
		recipe_completed.emit()
		generate_recipe()
		reset()
		return
	update_view()

func collect_meat():
	meat_collected += 1
	if(meat_collected > meat_required):
		generate_recipe()
		reset()
		return
	elif(veggies_collected == veggies_required && meat_collected == meat_required):
		recipe_completed.emit()
		generate_recipe()
		reset()
	update_view()

func update_view():
	$Background/VeggieLabel.text = str(veggies_collected) + "/" + str(veggies_required)
	$Background/MeatLabel.text = str(meat_collected) + "/" + str(meat_required)

func reset():
	veggies_collected = 0
	meat_collected = 0
	generate_recipe()
	update_view()
