extends CanvasLayer

@onready var fade_rect: ColorRect = $ColorRect
var next_poe: String = "Default" #next_poe means the next point of entry

func room_change(scene: String, _poe_name: String):
	await fade_out()
	get_tree().call_deferred("change_scene_to_file", scene)
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
