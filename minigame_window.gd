extends Control

signal exit_minigame

func _on_button_pressed() -> void:
	exit_minigame.emit()
