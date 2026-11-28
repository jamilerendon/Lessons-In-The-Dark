extends Node2D

@onready var speaker_name: RichTextLabel = get_tree().current_scene.get_node("dialogue_ui/Canvas/SpeakerName")
@onready var dialogueUI = get_tree().current_scene.get_node("dialogue_ui/Canvas")
@onready var dialogue_text: RichTextLabel = get_tree().current_scene.get_node("dialogue_ui/Canvas/DialogueText")
@onready var left_character: TextureRect = get_tree().current_scene.get_node("dialogue_ui/Canvas/Left Character")
@onready var right_character: TextureRect = get_tree().current_scene.get_node("dialogue_ui/Canvas/Right Character")
@onready var player:CharacterBody2D = get_tree().current_scene.get_node("Player/CharacterBody2D")

@export var speakerNames: Array[String]
@export var dialogues: Array[String]
@export var voicelines: Array[AudioStream]
@export var leftPortraits: Array[Texture2D]
@export var rightPortraits: Array[Texture2D]

var currentDialogue = -1
var started = false
var active := false
var key: String
var voice_actor: AudioStreamPlayer

func _ready() -> void:
	key = str(get_path())
	if Transition.seen_dialogues.has(key):
		started = true
	dialogueUI.get_node("Button").connect("pressed", Callable(self, "continue_dialogue"))
	dialogueUI.visible = false
	set_character(left_character, null)
	set_character(right_character, null)
	voice_actor = AudioStreamPlayer.new()
	add_child(voice_actor)
	if AudioServer.get_bus_index("Voice") != -1:
		voice_actor.bus = "Voice"

func start_dialogue(body):
	if body == player and !started:
		started = true
		active = true
		currentDialogue = -1
		player.velocity = Vector2.ZERO
		player.set_physics_process(false)
		dialogueUI.visible = true
		Mouse.apply_current()
		continue_dialogue()

func continue_dialogue():
	if !active:
		return
	currentDialogue += 1
	if currentDialogue < dialogues.size():
		dialogue_text.text = dialogues[currentDialogue]
		speaker_name.text = speakerNames[currentDialogue]
		set_character(left_character, character(leftPortraits, currentDialogue))
		set_character(right_character, character(rightPortraits, currentDialogue))
		play_voice(voice(voicelines, currentDialogue))
	else:
		end_dialogue()

func end_dialogue():
	Transition.seen_dialogues[key] = true
	active = false
	player.set_physics_process(true)
	dialogueUI.visible = false
	set_character(left_character, null)
	set_character(right_character, null)
	voice_actor.stop()
	Mouse.apply_current()

func character(characters: Array[Texture2D], index: int) -> Texture2D:
	if index >= 0 and index < characters.size():
		return characters[index]
	return null

func set_character(rect: TextureRect, texture: Texture2D) -> void:
	rect.texture = texture
	rect.visible = texture != null

func voice(tracks: Array[AudioStream], index: int) -> AudioStream:
	if index >= 0 and index < tracks.size():
		return tracks[index]
	return null

func play_voice(track: AudioStream) -> void:
	voice_actor.stop()
	if track == null:
		return
	voice_actor.stream = track
	voice_actor.play()
