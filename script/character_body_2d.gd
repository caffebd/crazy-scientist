extends CharacterBody2D


const SPEED = 450.0
const CLIMB_SPEED = 50.0
const JUMP_VELOCITY = -450.0
var gravity = 150

var on_ladder: bool
var climbing: bool
var direction := Vector2.ZERO
var jump = true


@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

var bullet_scene = preload("res://scene/bullet.tscn")

func _ready() -> void:
	print("check")


func _physics_process(delta) -> void:
	direction.y += gravity * delta
	#Animation
	if (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "walk(right)"
	else:
		sprite_2d.animation = "idle"
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		sprite_2d.animation = "jump"

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
		# if can_shoot is true add animation, increse damage, player speed*2 
		var bullet = bullet_scene.instantiate()
		bullet.global_position = $Marker2D.global_position
		get_parent().add_child(bullet)
		bullet.shoot(sprite_2d.flip_h)
	
