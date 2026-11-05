@tool
extends EditorScript

func _run() -> void:
	var tm: TileMap = EditorInterface.get_edited_scene_root().get_node("TileMap")
	print("layers before: ", tm.get_layers_count())
	if tm.get_layers_count() != 19:
		print("expected 19, aborting")
		return
	for k in range(1, 10):
		if tm.get_used_cells(k).size() != tm.get_used_cells(k + 9).size():
			print("cell count mismatch at ", k, ", aborting")
			return
	for i in range(18, 9, -1):
		tm.remove_layer(i)
	print("layers after: ", tm.get_layers_count())
