extends Node2D

func _ready():
	var entry_name = Transition.next_entry_point
	var marker = get_node_or_null(entry_name)
	var player = get_node_or_null("Player")
	
	if marker and player:
		player.global_position = marker.global_position

	if player:
		var camera = player.get_node_or_null("Camera2D")
		var tilemap = get_node_or_null("TileMap")
		if camera and tilemap:
			set_camera_behavior(camera, tilemap)

func set_camera_behavior(camera: Camera2D, tilemap: TileMap) -> void:
	var used_rect: Rect2i = tilemap.get_used_rect()
	var cell_size: Vector2i = tilemap.tile_set.tile_size
	
	var top_left_px = Vector2(used_rect.position * cell_size) + tilemap.global_position
	var bottom_right_px = Vector2((used_rect.position + used_rect.size) * cell_size) + tilemap.global_position
	
	var room_width = bottom_right_px.x - top_left_px.x
	var room_height = bottom_right_px.y - top_left_px.y
	var viewport_size = camera.get_viewport_rect().size
	
	print("--- Camera Debug ---")
	print("top_left_px: ", top_left_px)
	print("bottom_right_px: ", bottom_right_px)
	print("room size: ", room_width, "x", room_height)
	print("viewport size: ", viewport_size)
	print("camera global_position BEFORE: ", camera.global_position)
	
	camera.top_level = false
	camera.position = Vector2.ZERO
	
	if room_width <= viewport_size.x and room_height <= viewport_size.y:
		# Small room — clamp tightly to room bounds; Camera2D auto-centers
		# when the limited area is smaller than the viewport
		camera.limit_left = int(top_left_px.x)
		camera.limit_top = int(top_left_px.y)
		camera.limit_right = int(bottom_right_px.x)
		camera.limit_bottom = int(bottom_right_px.y)
		camera.position_smoothing_enabled = false
	else:
		# Big room — no clamping at all, camera follows player freely,
		# even outside the tilemap if a bug ever sends them there
		camera.limit_left = -10000000
		camera.limit_top = -10000000
		camera.limit_right = 10000000
		camera.limit_bottom = 10000000
		camera.position_smoothing_enabled = true

	camera.limit_left = int(top_left_px.x)
	camera.limit_top = int(top_left_px.y)
	camera.limit_right = int(bottom_right_px.x)
	camera.limit_bottom = int(bottom_right_px.y)
