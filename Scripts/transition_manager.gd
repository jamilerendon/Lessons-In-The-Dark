extends CanvasLayer

@onready var fade_rect: ColorRect = $ColorRect
var next_entry_point: String = "EntryDefault"

func go_to_room(scene_path: String, entry_point_name: String):
	next_entry_point = entry_point_name
	print("go_to_room called with entry point: ", entry_point_name)
	await fade_out()
	get_tree().call_deferred("change_scene_to_file", scene_path)
	await get_tree().process_frame # wait a frame for new scene to load
	await fade_in()

func fade_out() -> void:
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 0.3)
	await tween.finished

func fade_in() -> void:
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 0.0, 0.3)
	await tween.finished
