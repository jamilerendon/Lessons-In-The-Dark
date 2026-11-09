extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		Transition.room_change("res://Scene/Levels/2_KikiHouseOutside.tscn", "L1ToL2")
