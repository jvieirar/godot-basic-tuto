extends Area2D

@onready var timer: Timer = $Timer

func _on_timer_timeout() -> void:
	# restart the game
	Engine.time_scale = 1
	get_tree().reload_current_scene()


func _on_body_entered(body: Node2D) -> void:
	print("you died!!")
	Engine.time_scale = 0.5
	
	## Instead of just freeing the collision shape, disable the player's script
	#if body.has_method("set_physics_process"):
		#body.set_physics_process(false)
		#body.set_process(false)
	#
	## Free the collision shape to prevent further collisions
	#var collision = body.get_node_or_null("CollisionShape2D")
	#if collision:
		#collision.queue_free()
	
	# Instead of freeing the collision shape, disable collision detection
	if body.has_method("set_collision_layer"):
		body.set_collision_layer(0)
		body.set_collision_mask(0)
	
	# Store a reference to the collision shape but don't free it
	var collision = body.get_node_or_null("CollisionShape2D")
	if collision:
		collision.disabled = true  # Disable instead of freeing
	
	# body is our player (only thing that collides with killing zone
	#body.get_node("CollisionShape2D").queue_free()
	
	timer.start()
