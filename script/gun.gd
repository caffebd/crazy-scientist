extends Node2D

var player_in_range = false


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pickup") and player_in_range:
		GlobalVars.big_gun = true
		print("item_picked_up")
		queue_free()
