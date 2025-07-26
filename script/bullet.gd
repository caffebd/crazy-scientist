extends RigidBody2D

var speed = 1350

func _ready() -> void:
	pass
	
func shoot(is_left):
	var direction = 1.0
	if is_left:
		direction = -1.0
	linear_velocity.x = speed * direction
