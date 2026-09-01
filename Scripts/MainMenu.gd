extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_play_pressed() -> void:
	print("Button Play has been pressed")
	Transition.go_to_room("res://Scene/Main.tscn", "EntryDefault")

func _on_settings_pressed() -> void:
	print("Options Pressed")

func _on_quit_game_pressed() -> void:
	print("Quit Game Pressed")
	get_tree().quit()
