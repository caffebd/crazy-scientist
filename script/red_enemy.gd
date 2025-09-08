extends Area2D

func _ready() -> void:
	$red_enemy.play("walk")
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GlobalSignal.life_lose.emit()
	
	if body.is_in_group("bullet"):
		body.queue_free()
		if GlobalVars.big_gun == false:
			%ProgressBar.value -= 5
		if GlobalVars.big_gun == true:
			%ProgressBar.value -= 10
			
		if %ProgressBar.value == 0:
			$red_enemy.animation = "die"
			$distroy_timer.start()
			call_deferred("disable_it")
			
func disable_it():
	%CollisionShape2D.disabled = true

func _on_distroy_timer_timeout() -> void:
	queue_free()
