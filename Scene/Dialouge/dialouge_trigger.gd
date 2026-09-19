extends Node2D

@onready var dialogueUI = get_tree().current_scene.get_node("dialouge_ui/Canvas")
@onready var speaker_name: RichTextLabel = get_tree().current_scene.get_node("dialouge_ui/Canvas/SpeakerName")
@onready var dialouge_text: RichTextLabel = get_tree().current_scene.get_node("dialouge_ui/Canvas/DialougeText")
@onready var player:CharacterBody2D = get_tree().current_scene.get_node("Player/CharacterBody2D")

@export var dialouges: Array[String]
@export var speakerNames: Array[String]
@export var speaker: Node2D

var currentDialouge = -1
var started = false

func _ready() -> void:
	dialogueUI.get_node("Button").connect("pressed", Callable(self, "continue_dialouge"))
	dialogueUI.visible = false

func start_dialogue(body):
	if body == player and !started:
		started = true
		if !dialogueUI.visible:
			dialogueUI.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		pass

func end_dialogue():
	dialogueUI.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func continue_dialouge():
		currentDialouge += 1
		if currentDialouge < dialouges.size():
			dialouge_text.text = dialouges[currentDialouge]
			speaker_name.text = speakerNames[currentDialouge]
		else:
			end_dialogue()
