extends Node2D

#A vegetable which can be chopped. Used in the ChopTheVegetables minigame.

var chop_lines = 0
var chopped = 0

signal fully_chopped

##Collects all chop markers and connects them to validators.
##Validators indicate whether a chop is succesful or not.
func _ready() -> void:
	var children = get_children()
	for child in children:
		if child is Area2D:
			child.area_entered.connect(set_cut_valid)
			child.area_exited.connect(set_cut_invalid)
			chop_lines += 1

func set_cut_valid(area):
	if area is Chopper:
		area.cut_valid = true

func set_cut_invalid(area):
	if area is Chopper:
		area.cut_valid = false

##Destroys a piece of the vegetable. More specifically, it destroys a chop marker.
func _on_destroybox_area_entered(area):
	if(area is Chopper):
		chopped += 1
		if chopped == chop_lines:
			fully_chopped.emit()
			queue_free()
