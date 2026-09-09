extends Control

@onready var game_name: Label = $"Game Name"
@onready var main_menu_buttons: VBoxContainer = $MainMenuButtons

func _ready() -> void:
	game_name.visible = true
	main_menu_buttons.visible = true

func _on_play_pressed() -> void:
	Transition.room_change("res://Scene/Tilemaps/Tilemap1.tscn", "EntryDefault")

func _on_settings_pressed() -> void:
	Transition.return_scene_path = "res://Scene/Menu/MainMenu.tscn"
	Transition.return_entry_point = "EntryDefault"
	Transition.reopen_pause_menu = false
	Transition.room_change("res://Scene/Menu/Settings.tscn", "EntryDefault")

func _on_quit_game_pressed() -> void:
	get_tree().quit()

func _notification(what):
	if what == NOTIFICATION_APPLICATION_FOCUS_IN:
		if !get_tree().paused:
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
