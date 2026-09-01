extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		Transition.room_change("res://Scene/Tilemaps/TestTilemap.tscn", "EntryFromRoom1")#Teleports Player to specific tileset using a Marker2D
