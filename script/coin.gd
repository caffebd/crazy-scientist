extends Area2D

func _ready() -> void:
	$coin_anim.play("animation")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GlobalSignal.update_score.emit()
		queue_free()
