extends Area2D

@onready var timer: Timer = $Timer

func _on_timer_timeout() -> void:
	# restart the game
	Engine.time_scale = 1
	get_tree().reload_current_scene()


func _on_body_entered(body: Node2D) -> void:
	print("you died!!")
	Engine.time_scale = 0.5
	
	# body is our player (only thing that collides with killing zone
	body.get_node("CollisionShape2D").queue_free()
	
	timer.start()
