extends RigidBody2D

var speed = 1250

func _ready() -> void:
	pass
	
func shoot(is_left):
	var direction = 1.0
	if is_left:
		direction = -1.0
	linear_velocity.x = speed * direction


func _on_bullet_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		queue_free()
	if body.is_in_group("tilemap"):
		queue_free()
