extends Node

func _on_body_entered(body):
	if body.is_in_group("player"):
		Transition.room_change("res://Scene/Levels/3_BusStation.tscn", "L2ToL3")
