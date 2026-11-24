extends HSlider

@export var audio_bus_name: String
@export var preview_player: AudioStreamPlayer
@export var preview_stream: AudioStream

const PREVIEW_SOUND_PATH := "res://Assets/Music/Fart.mp3"
var audio_bus_id: int

func _ready() -> void:
	if preview_player == null and owner:
		preview_player = owner.find_child("SFXPreview", true, false) as AudioStreamPlayer
	drag_ended.connect(_on_drag)
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)
	if audio_bus_id == -1:
		push_warning("Bus not found: '%s'" % audio_bus_name)
		print("SFX slider ready | bus: '", audio_bus_name, "' id: ", audio_bus_id, " | preview: ", preview_player)
		return
	set_value_no_signal(db_to_linear(AudioServer.get_bus_volume_db(audio_bus_id)))

func _on_value_changed(new_value: float) -> void:
	if audio_bus_id == -1:
		return
	AudioServer.set_bus_volume_db(audio_bus_id, linear_to_db(new_value))

func _on_drag(_value_changed: bool) -> void:
	print("drag ended | slider: ", name, " | bus: '", audio_bus_name, "'")
	if audio_bus_name != "SFX":
		return
	var s := load(PREVIEW_SOUND_PATH) as AudioStream
	print("loaded stream: ", s)
	if s == null:
		return
	var p := AudioStreamPlayer.new()
	p.stream = s
	p.bus = "SFX"
	p.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(p)
	p.finished.connect(p.queue_free)
	p.play()
