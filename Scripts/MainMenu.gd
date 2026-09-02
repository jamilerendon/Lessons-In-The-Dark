extends Control

@onready var game_name: Label = $"Game Name"
@onready var main_menu_buttons: VBoxContainer = $MainMenuButtons
@onready var settings: Panel = $Settings


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_name.visible=true
	main_menu_buttons.visible=true
	settings.visible=false

func _on_play_pressed() -> void:
	Transition.room_change("res://Scene/Tilemaps/Tilemap1.tscn", "EntryDefault")

func _on_settings_pressed() -> void:
	game_name.visible=false
	main_menu_buttons.visible=false
	settings.visible=true

func _on_quit_game_pressed() -> void:
	get_tree().quit()

func _on_back_to_menu_pressed() -> void:
	_ready()

func _notification(what):
	if what == NOTIFICATION_APPLICATION_FOCUS_IN:
		# Game window is focused
		if !get_tree().paused:
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		# Game window lost focus (Alt-Tab, Windows key, clicking outside)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
