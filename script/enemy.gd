extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet"):
		body.queue_free()
		if GlobalVars.big_gun == false:
			%ProgressBar.value -= 2
		if GlobalVars.big_gun == true:
			%ProgressBar.value -= 5
			
		if %ProgressBar.value == 0:
			$die_time.start()
			$Sprite2D.rotation = 20
			$CollisionShape2D.rotation = 20
			

func _on_die_time_timeout() -> void:
	queue_free()
