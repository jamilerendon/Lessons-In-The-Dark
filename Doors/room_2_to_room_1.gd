extends Area2D

func _on_body_entered(body):
	print("Object entered: ", body.name)
	if body.is_in_group("player"):
		print("Player confirmed, teleporting...")
		TransitionManager.go_to_room("res://Scene/Main.tscn", "EntryFromRoom2")
