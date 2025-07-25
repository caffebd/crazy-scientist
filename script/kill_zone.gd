extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		call_deferred("reload")
	

func reload():
	get_tree().reload_current_scene()
