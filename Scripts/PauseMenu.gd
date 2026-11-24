extends Control

const IGNORED_SCENES := ["res://Scene/Menu/MainMenu.tscn","res://Scene/Menu/Settings.tscn"]

func _is_ignored_scene() -> bool:
	var scene := get_tree().current_scene
	return scene != null and scene.scene_file_path in IGNORED_SCENES

func _hide_immediately():
	$AnimationPlayer.stop()
	$PanelContainer.visible = false
	_update_button_interactivity()

func _update_button_interactivity():
	var buttons = $PanelContainer/PauseMenuButtons
	var paused := get_tree().paused

	mouse_filter = Control.MOUSE_FILTER_STOP if paused else Control.MOUSE_FILTER_IGNORE
	buttons.mouse_filter = Control.MOUSE_FILTER_STOP if paused else Control.MOUSE_FILTER_IGNORE
	buttons.focus_mode = Control.FOCUS_ALL if paused else Control.FOCUS_NONE

func resume():
	get_tree().paused = false
	Mouse.apply_current()
	$AnimationPlayer.play_backwards("Blur")
	await $AnimationPlayer.animation_finished
	$PanelContainer.visible = false
	_update_button_interactivity()

func pause():
	get_tree().paused = true
	$PanelContainer.visible = true
	Mouse.apply_current()
	$AnimationPlayer.play("Blur")
	_update_button_interactivity()

func _input(event):
	if _is_ignored_scene():
		return
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			resume()
		else:
			pause()

func _ready():
	$PanelContainer.visible = false
	_update_button_interactivity()

func _on_resume_pressed():
	resume()

func _on_settings_pressed():
	Transition.return_scene_path = get_tree().current_scene.scene_file_path
	Transition.return_entry_point = "EntryDefault"
	Transition.reopen_pause_menu = true
	get_tree().paused = false
	_hide_immediately()
	Transition.room_change("res://Scene/Menu/Settings.tscn", "EntryDefault")

func _on_main_menu_pressed():
	get_tree().paused = false
	_hide_immediately()
	Transition.room_change("res://Scene/Menu/MainMenu.tscn", "EntryDefault")

func _on_quit_and_save_pressed():
	_save_game()
	get_tree().quit()

func _save_game():
	print("Game saved!")
