extends Area2D

func _on_body_entered(body):
	print("Object entered: ", body.name)#Shows if anything enters collision area for debugging purposes
	if body.is_in_group("player"):
		print("Player confirmed, teleporting...")#Shows that Player has been teleported to a location for debugging purposes
		Transition.go_to_room("res://Scene/Room2.tscn", "EntryFromRoom1")#Teleports Player to specific tileset using a Marker2D
