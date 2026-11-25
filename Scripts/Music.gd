extends AudioStreamPlayer

var audio: AudioStream

func _ready() -> void:
	bus = "Music"
	process_mode = Node.PROCESS_MODE_ALWAYS
	finished.connect(replay)
	
func play_audio(track: AudioStream) -> void:
	if track == null:
		return
	if track == audio and playing:
		return
	audio = track
	stream = track
	play()

func replay() -> void:
	play()
