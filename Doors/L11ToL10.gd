extends Node

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Transition.room_change("res://Scene/Levels/10_Cafeteria.tscn", "L11ToL10")
