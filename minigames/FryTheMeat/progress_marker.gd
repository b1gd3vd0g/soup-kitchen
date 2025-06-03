class_name ProgressMarker extends Area2D

##Progress markers. These are used to guide the players pan to simulate the motions
##of stir frying meet.
signal progress_marker_hit(id: int)

@export var id: int

var active = false

func _on_area_entered(_area: Area2D) -> void:
	progress_marker_hit.emit(id)

func set_active():
	active = true
	$GraphicalMarker.default_color = Color.GREEN

func set_inactive():
	active = false
	$GraphicalMarker.default_color = Color.WHITE
