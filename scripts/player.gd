extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -350.0

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# direction is -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif  direction < 0:
		animated_sprite.flip_h = true
	
	# animations
	if is_on_floor():
		if direction == 0:
			# still
			animated_sprite.play("idle")
		else: 
			animated_sprite.play("running")
	else:
		animated_sprite.play("jumping")
	
	# apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
