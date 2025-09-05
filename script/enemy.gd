extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet"):
		%ProgressBar.value -= 5
		if %ProgressBar.value == 0:
			queue_free()
