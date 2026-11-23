extends Node2D

@onready var dialogueUI = get_tree().current_scene.get_node("dialogue_ui/Canvas")
@onready var speaker_name: RichTextLabel = get_tree().current_scene.get_node("dialogue_ui/Canvas/SpeakerName")
@onready var dialogue_text: RichTextLabel = get_tree().current_scene.get_node("dialogue_ui/Canvas/DialogueText")
@onready var player:CharacterBody2D = get_tree().current_scene.get_node("Player/CharacterBody2D")

@export var dialogues: Array[String]
@export var speakerNames: Array[String]
@export var speaker: Node2D

var currentDialogue = -1
var started = false
var active := false
var key: String

func _ready() -> void:
	key = str(get_path())
	if Transition.seen_dialogues.has(key):
		started = true
	dialogueUI.get_node("Button").connect("pressed", Callable(self, "continue_dialogue"))
	dialogueUI.visible = false

func start_dialogue(body):
	if body == player and !started:
		started = true
		active = true
		currentDialogue = -1
		player.velocity = Vector2.ZERO
		player.set_physics_process(false)
		dialogueUI.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		continue_dialogue()

func end_dialogue():
	Transition.seen_dialogues[key] = true
	active = false
	player.set_physics_process(true)
	dialogueUI.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

func continue_dialogue():
	if !active:
		return
	currentDialogue += 1
	if currentDialogue < dialogues.size():
		dialogue_text.text = dialogues[currentDialogue]
		speaker_name.text = speakerNames[currentDialogue]
	else:
		end_dialogue()
