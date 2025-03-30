extends Area2D

signal player_collision(other_player)

@onready var game_manager: Node = %GameManager

func _ready():
	# Connect the body_entered signal
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# Check if the body is Player2
	print("[Player 1] collision with body: " + body.name)
	if body.name == "Player2":
		emit_signal("player_collision", body)
