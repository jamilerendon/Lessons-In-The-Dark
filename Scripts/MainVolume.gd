extends HSlider

@export var audio_bus_name: String
@export var preview_player: AudioStreamPlayer

var audio_bus_id: int

func _ready() -> void:
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)
	if audio_bus_id == -1:
		push_warning("Bus not found: '%s'" % audio_bus_name)
		return
	set_value_no_signal(db_to_linear(AudioServer.get_bus_volume_db(audio_bus_id)))
	drag_ended.connect(_on_drag)

func _on_value_changed(new_value: float) -> void:
	if audio_bus_id == -1:
		return
	AudioServer.set_bus_volume_db(audio_bus_id, linear_to_db(new_value))

func _on_drag(_value_changed: bool) -> void:
	if preview_player:
		preview_player.play()
