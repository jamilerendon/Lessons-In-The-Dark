extends OptionButton

func _ready() -> void:
	_populate_options()
	_select_current_mode()
	item_selected.connect(_on_item_selected)

func _populate_options() -> void:
	clear()
	add_item("Windowed")
	add_item("Borderless Windowed")
	add_item("Fullscreen")

func _select_current_mode() -> void:
	var mode = DisplayServer.window_get_mode()
	var is_borderless = DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS)

	if mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
		selected = 2
	elif is_borderless:
		selected = 1
	else:
		selected = 0

func _on_item_selected(index: int) -> void:
	match index:
		0: # Windowed
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

			var size = Vector2i(1280, 720)
			DisplayServer.window_set_size(size)

			var screen_pos = DisplayServer.screen_get_position()
			var screen_size = DisplayServer.screen_get_size()
			var centered_pos = screen_pos + (screen_size - size) / 2
			DisplayServer.window_set_position(centered_pos)

		1: # Borderless Windowed
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

			var screen_pos = DisplayServer.screen_get_position()
			var screen_size = DisplayServer.screen_get_size()

			DisplayServer.window_set_size(screen_size)
			DisplayServer.window_set_position(screen_pos)

		2: # Fullscreen
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
