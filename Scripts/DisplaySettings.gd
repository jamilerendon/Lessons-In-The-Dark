extends OptionButton

const GROUP := "display_mode_dropdown"

func _ready() -> void:
	add_to_group(GROUP)
	options()
	select_mode()
	item_selected.connect(mode_selected)
	visibility_changed.connect(visibility_change)

func options() -> void:
	clear()
	add_item("Windowed")
	add_item("Fullscreen")

func select_mode() -> void:
	var mode := DisplayServer.window_get_mode()
	if mode == DisplayServer.WINDOW_MODE_FULLSCREEN or mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		select(1)
	else:
		select(0)

func visibility_change() -> void:
	if is_visible_in_tree():
		select_mode()

func sync(index: int) -> void:
	select(index)

func mode_selected(index: int) -> void:
	apply_mode(index)
	Mouse.apply(index == 1)
	for node in get_tree().get_nodes_in_group(GROUP):
		if node != self:
			node.sync(index)

func apply_mode(index: int) -> void:
	match index:
		0: # Windowed
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			var size := Vector2i(1280, 720)
			DisplayServer.window_set_size(size)
			var screen_pos := DisplayServer.screen_get_position()
			var screen_size := DisplayServer.screen_get_size()
			DisplayServer.window_set_position(screen_pos + (screen_size - size) / 2)
		1: # Fullscreen
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
