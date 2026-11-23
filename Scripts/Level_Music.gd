extends Node

@export var track: AudioStream

func _ready() -> void:
	Music.play_audio(track)
