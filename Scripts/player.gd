extends CharacterBody2D

var direction : Vector2 = Vector2()

func read_input():
	direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * 200
	
func _physics_process(_delta):
	read_input()
	move_and_slide() #allows the character to move using the self velocity.

func _notification(what):
	if what == NOTIFICATION_APPLICATION_FOCUS_IN:
		# Game window is focused
		if !get_tree().paused:
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		# Game window lost focus (Alt-Tab, Windows key, clicking outside)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _ready():
	add_to_group("player")
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

	var room: Node = self
	while room.get_parent() != null and room.get_parent() != get_tree().root:
		room = room.get_parent()

	var marker := room.find_child(Transition.next_poe, true, false) as Node2D
	if marker:
		global_position = marker.global_position
