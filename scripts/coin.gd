extends Area2D


## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_body_entered(body: Node2D) -> void:
	# by default, this is being signed when any body toches the coin, e.g. even platforms
	# to avoid that, we moved the player to a separated physics layer player > collision > layer 2 only
	# and the coin can stay in layer 1, but only react to layer 2 coin > collision > mask > layer 2 only
	print("+1 coin")
	
	# we want to delete coin on pickup. This could be done with queue_free()
	queue_free()
