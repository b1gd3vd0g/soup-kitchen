extends Line2D

signal progress_completed

var forward = true

var progress_markers
var num_markers

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Collect and sort progress markers into an array
	progress_markers = get_children()
	progress_markers.sort_custom(func(a: ProgressMarker ,b: ProgressMarker): return a.id < b.id)
	num_markers = progress_markers.size()
	
	#Assign Behaviour for markers being hit
	for marker in progress_markers:
		marker.progress_marker_hit.connect(progress_marker_hit)
	
	progress_markers[0].set_active()
	
func progress_marker_hit(id):
	if progress_markers[id].active == true:
		print("Progress Marker Hit! [" + str(id) + "]")
		progress_markers[id].set_inactive()
		#Implement Loop
		if id >= num_markers - 1:
			id = -1
			progress_completed.emit()
		progress_markers[clamp(id + 1, 0, num_markers - 1)].set_active()

func set_active(is_active):
	if !is_active:
		#Disable all markers
		for marker in progress_markers:
			marker.set_inactive()
		visible = false
	else:
		#Enable first marker
		progress_markers[0].set_active()
		visible = true
