extends Control

func _on_back_to_menu_pressed() -> void:
	Transition.room_change(Transition.return_scene_path, Transition.return_entry_point)
