extends Control

func _update_button_interactivity():
	$PauseMenuButtons.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$PauseMenuButtons.focus_mode = Control.FOCUS_NONE
	
	if visible:
		$PauseMenuButtons.mouse_filter = Control.MOUSE_FILTER_STOP
		$PauseMenuButtons.focus_mode = Control.FOCUS_ALL


func resume():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	$AnimationPlayer.play_backwards("Blur")

func pause():
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$AnimationPlayer.play("Blur")

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			resume()
		else:
			pause()

func _on_resume_pressed():
	resume()

func _on_settings_pressed():
	Transition.room_change("res://Scene/Menu/MenuSettings.tscn", "EntryDefault")

func _on_main_menu_pressed():
	get_tree().paused = false
	Transition.room_change("res://Scene/Menu/MainMenu.tscn", "EntryDefault")

func _on_quit_and_save_pressed():
	_save_game()
	get_tree().quit()

func _save_game():
	print("Game saved!")
