extends Node2D

var chop_lines = 0
var chopped = 0

signal fully_chopped

# Called when the node enters the scene tree for the first time.
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

func _on_destroybox_area_entered(area):
	if(area is Chopper):
		chopped += 1
		if chopped == chop_lines:
			fully_chopped.emit()
			queue_free()
