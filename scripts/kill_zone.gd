extends Area2D

@onready var timer: Timer = $Timer

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	print("you died!!")
	timer.start()


func _on_timer_timeout() -> void:
	# restart the game
	get_tree().reload_current_scene()
