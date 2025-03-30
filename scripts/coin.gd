extends Area2D

# @onready var game_manager: Node = $"../../GameManager" - never use paths like this (parents)
@onready var game_manager: Node = %GameManager # accesible only within the same scene
@onready var animation_p_pickup: AnimationPlayer = $AnimationPPickup
@onready var sound_pickup: AudioStreamPlayer2D = $SoundPickup


func _on_body_entered(body: Node2D) -> void:
	# by default, this is being signed when any body toches the coin, e.g. even platforms
	# to avoid that, we moved the player to a separated physics layer player > collision > layer 2 only
	# and the coin can stay in layer 1, but only react to layer 2 coin > collision > mask > layer 2 only
	
	# play sound immediately instead of in the animation frame
	# Play sound immediately
	sound_pickup.play()
	
	game_manager.add_point()
	animation_p_pickup.play("pickup")
	
	# we want to delete coin on pickup. This could be done with queue_free() but the audio won't work if the node is gone
	# for tricky timing, we can use an animation player, and "Add Track > Call method track" for the queue_free method after 1s
	#queue_free()
