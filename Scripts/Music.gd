extends AudioStreamPlayer

var current_audio: AudioStream

func _ready() -> void:
	bus = "Music"

func play_audio(track: AudioStream) -> void:
	if track == null:
		return
	if track == current_audio and playing:
		return
	current_audio = track
	stream = track
	play()
