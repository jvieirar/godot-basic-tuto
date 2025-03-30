extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -350.0
const MAX_TILT_ANGLE = 15.0  # Maximum tilt angle in degrees

@onready var animated_sprite = $AnimatedSprite2D

# Track jump state
var is_jumping = false
var jump_peak_reached = false
var previous_y_velocity = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		# Track jump state for tilt animation
		if velocity.y > 0 and previous_y_velocity <= 0:
			# We've reached the peak of our jump
			jump_peak_reached = true
		
		# Apply tilt based on jump state
		apply_jump_tilt()
	else:
		# Reset jump tracking when on floor
		is_jumping = false
		jump_peak_reached = false
		animated_sprite.rotation_degrees = 0  # Reset rotation when on ground
	
	# Store previous velocity for peak detection
	previous_y_velocity = velocity.y

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		jump_peak_reached = false

	# Get the input direction and handle the movement/deceleration.
	# direction is -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
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

func apply_jump_tilt():
	if not is_jumping:
		return
		
	# Calculate tilt based on vertical velocity
	var tilt_factor = 0.0
	
	if not jump_peak_reached:
		# First half of jump (going up) - tilt upward
		# Map from JUMP_VELOCITY to 0
		tilt_factor = remap(velocity.y, JUMP_VELOCITY, 0, -1.0, 0.0)
	else:
		# Second half of jump (falling) - tilt downward
		# Map from 0 to some positive value (e.g., 400)
		tilt_factor = remap(velocity.y, 0, 400, 0.0, 1.0)
	
	# Clamp the tilt factor between -1 and 1
	tilt_factor = clamp(tilt_factor, -1.0, 1.0)
	
	# Apply rotation based on tilt factor
	animated_sprite.rotation_degrees = tilt_factor * MAX_TILT_ANGLE
	
	# If sprite is flipped, reverse the tilt
	if animated_sprite.flip_h:
		animated_sprite.rotation_degrees *= -1
