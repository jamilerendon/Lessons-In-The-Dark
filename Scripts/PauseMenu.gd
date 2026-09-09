extends Control

func _update_button_interactivity():
	var buttons = $PanelContainer/PauseMenuButtons
	buttons.mouse_filter = Control.MOUSE_FILTER_IGNORE
	buttons.focus_mode = Control.FOCUS_NONE
	
	if get_tree().paused:
		buttons.mouse_filter = Control.MOUSE_FILTER_STOP
		buttons.focus_mode = Control.FOCUS_ALL

func resume():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	$AnimationPlayer.play_backwards("Blur")
	await $AnimationPlayer.animation_finished
	$PanelContainer.visible = false
	_update_button_interactivity()

func pause():
	get_tree().paused = true
	$PanelContainer.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$AnimationPlayer.play("Blur")
	_update_button_interactivity()

func _input(event):
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
	Transition.room_change("res://Scene/Menu/Settings.tscn", "EntryDefault")

func _on_main_menu_pressed():
	get_tree().paused = false
	Transition.room_change("res://Scene/Menu/MainMenu.tscn", "EntryDefault")

func _on_quit_and_save_pressed():
	_save_game()
	get_tree().quit()

func _save_game():
	print("Game saved!")
