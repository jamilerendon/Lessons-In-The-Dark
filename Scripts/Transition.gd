extends CanvasLayer

@onready var fade_rect: ColorRect = $ColorRect
var next_poe: String = "Default" #next_poe means the next point of entry
var return_scene_path: String = "res://Scene/Menu/MainMenu.tscn"
var return_entry_point: String = "EntryDefault"
var reopen_pause_menu: bool = false

func room_change(scene: String, poe_name: String):
	next_poe = poe_name
	await fade_out()
	get_tree().call_deferred("change_scene_to_file", scene)
	await get_tree().process_frame
	await fade_in()

func fade_out() -> void:
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 0.3)
	await tween.finished

func fade_in() -> void:
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 0.0, 0.3)
	await tween.finished
