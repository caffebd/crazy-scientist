extends Area2D

@export var flip_h : Sprite2D
@export var collition : CollisionShape2D

func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GlobalVars.use_ladder = true
		print(GlobalVars.use_ladder)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		GlobalVars.use_ladder = false
		print(GlobalVars.use_ladder)
