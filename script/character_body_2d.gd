extends CharacterBody2D


const SPEED = 450.0
const CLIMB_SPEED = 50.0
const JUMP_VELOCITY = -450.0
var gravity = 150

var on_ladder: bool
var climbing: bool
var direction := Vector2.ZERO
var jump = true
var bullet_pos := 0
var bullet_shot = true

@onready var sprite_2d: AnimatedSprite2D = %player_anim

var bullet_scene = preload("res://scene/bullet.tscn")

func _ready() -> void:
	GlobalSignal.life_lose.connect(_life_lose)
	print("check")

func _life_lose():
	%my_life.value -= 10
	if %my_life.value == 0:
		call_deferred("reload")

func reload():
	get_tree().reload_current_scene()

func _physics_process(delta) -> void:
	direction.y += gravity * delta
	#Animation
	if (velocity.x > 1 || velocity.x < -1):
		if GlobalVars.big_gun == false:
			sprite_2d.animation = "walk(right)"
			
		if GlobalVars.big_gun == true:
			sprite_2d.animation = "big_gun_walk"
			
	else:
		if GlobalVars.big_gun == false:
			sprite_2d.animation = "idle"
			
		if GlobalVars.big_gun == true:
			sprite_2d.animation = "big_gun_idle"
			
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		bullet_shot = false
		if GlobalVars.big_gun == false:
			sprite_2d.animation = "jump"
		if GlobalVars.big_gun == true:
			sprite_2d.animation = "jump2"
	if is_on_floor():
		bullet_shot = true

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if jump == true:
			velocity.y = JUMP_VELOCITY
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		var isLeft = velocity.x < 0 
		sprite_2d.flip_h = isLeft
		bullet_pos = isLeft
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	
	
	
	if Input.is_action_just_pressed("up"):
		if GlobalVars.use_ladder == true:
			velocity.y -= SPEED
		
	if Input.is_action_just_pressed("down"):
		if GlobalVars.use_ladder == true:
			velocity.y += SPEED
			

	move_and_slide()
	
func _input(evemt : InputEvent) -> void:
	if Input.is_action_just_pressed("attack"):
		if bullet_shot == true:
			# if can_shoot is true add animation, increse damage, player speed*2 
			var bullet = bullet_scene.instantiate()
			if bullet_pos <= 0:
				bullet.global_position = %Marker2D.global_position
			if bullet_pos > 0:
				bullet.global_position = %Marker2D2.global_position
			get_parent().add_child(bullet)
			bullet.shoot(sprite_2d.flip_h)
	
