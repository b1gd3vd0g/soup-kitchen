extends Area2D

## Tells us whether the Kitchen is active (Whether user input is able to affect
## the Kitchen or its entities)
var active: bool = true

## This activates the kitchen, which means it is listening for user input and
## objects can be interacted with.
func activate(fr: bool) -> void:
	$Chef.listen(fr)

func interact() -> void:
	#if $Chef.listening and not $Chef/ActionIcon.hidden:
		$MinigameWindow.show()

func _ready() -> void:
	$Shape.shape.size = get_viewport_rect().size
	$Chef.set_bounds($Shape.shape.size)
	$MinigameWindow.hide()

func _process(_delta: float) -> void:
	if Input.is_action_pressed("interact"):
		print("interacted")
		interact()

## This function makes it so that the "interact" input will work.
func _on_interactable_zone_body_entered(body: Node2D) -> void:
	if body is Chef:
		$Chef.display_action_icon()


func _on_interactable_zone_body_exited(body: Node2D) -> void:
	if body is Chef:
		$Chef.display_action_icon(false)


func _on_minigame_window_exit_minigame() -> void:
	pass # Replace with function body.
