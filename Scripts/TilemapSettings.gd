extends Node2D

func _ready():
	var entry_name = Transition.next_poe
	var marker = get_node_or_null(entry_name)
	var player = get_node_or_null("Player")
	
	if marker and player:
		player.global_position = marker.global_position
	
	if player:
		var camera = player.get_node_or_null("CharacterBody2D/Camera2D")
		var tilemap = get_node_or_null("TileMap")
		if camera and tilemap:
			lock_camera_to_tilemap(camera, tilemap)
		else:
			print("Skipped locking, camera or tilemap was null")
	
	if Transition.reopen_pause_menu:
		Transition.reopen_pause_menu = false
		var pause_menu = get_node_or_null("Pause/PauseMenu")  # adjust to match actual path
		if pause_menu:
			pause_menu.pause()

func lock_camera_to_tilemap(camera: Camera2D, tilemap: TileMap) -> void:
	var used_rect: Rect2i = tilemap.get_used_rect()
	var cell_size: Vector2i = tilemap.tile_set.tile_size
	
	var top_left_px = Vector2(used_rect.position * cell_size) + tilemap.global_position
	var bottom_right_px = Vector2((used_rect.position + used_rect.size) * cell_size) + tilemap.global_position
	
	camera.limit_left = int(top_left_px.x)
	camera.limit_top = int(top_left_px.y)
	camera.limit_right = int(bottom_right_px.x)
	camera.limit_bottom = int(bottom_right_px.y)
