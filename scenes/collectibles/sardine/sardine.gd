extends Area2D

func _on_body_entered(_body: Node2D) -> void:
	queue_free()
	Events.sardine_taken.emit()
	var sardines = get_tree().get_nodes_in_group("Sardines")
	if sardines.size() == 1:
		Events.level_completed.emit()
