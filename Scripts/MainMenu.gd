extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_play_pressed() -> void:
	Transition.room_change("res://Scene/Tilemaps/Tilemap1.tscn", "EntryDefault")

func _on_settings_pressed() -> void:
	pass

func _on_quit_game_pressed() -> void:
	get_tree().quit()
