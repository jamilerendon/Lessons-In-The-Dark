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

func _ready():
	add_to_group("player")
	var camera = get_node_or_null("Camera2D")
	if camera:
		camera.make_current()
	else:
		print("Camera2D not found as a child of Player!")
