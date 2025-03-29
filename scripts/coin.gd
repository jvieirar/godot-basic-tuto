extends Area2D

# @onready var game_manager: Node = $"../../GameManager" - never use paths like this (parents)
@onready var game_manager: Node = %GameManager # accesible only within the same scene

func _on_body_entered(body: Node2D) -> void:
	# by default, this is being signed when any body toches the coin, e.g. even platforms
	# to avoid that, we moved the player to a separated physics layer player > collision > layer 2 only
	# and the coin can stay in layer 1, but only react to layer 2 coin > collision > mask > layer 2 only
	game_manager.add_point()
	
	# we want to delete coin on pickup. This could be done with queue_free()
	queue_free()
