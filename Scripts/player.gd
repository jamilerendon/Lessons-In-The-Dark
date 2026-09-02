extends CharacterBody2D

var direction : Vector2 = Vector2()

func read_input():
	velocity = Vector2()
	direction = Vector2.ZERO
	
	if Input.is_action_pressed("Up"):
		velocity.y -= 1
		direction = Vector2(0, -1)
		
	if Input.is_action_pressed("Down"):
		velocity.y += 1
		direction = Vector2(0, 1)
		
	if Input.is_action_pressed("Left"):
		velocity.x -= 1
		direction = Vector2(-1, 0)
		
	if Input.is_action_pressed("Right"):
		velocity.x += 1
		direction = Vector2 (1, 0)
		
	direction = direction.normalized()
	velocity = direction * 200 #sets the built-in CharacterBody2D velocity
	
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
