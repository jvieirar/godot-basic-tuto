extends Node2D


@onready var game_manager = %GameManager
@onready var player1_area = $Players/Player1/Area2D
@onready var player2_area = $Players/Player2/Area2D

var can_swap = true
var swap_cooldown: Timer

func _ready():
	# Connect player collision signals to game manager
	if player1_area:
		player1_area.player_collision.connect(_on_player_collision)
	if player2_area:
		player2_area.player_collision.connect(_on_player_collision)
	
	# Create a timer programmatically
	swap_cooldown = Timer.new()
	swap_cooldown.name = "SwapCooldown"
	swap_cooldown.wait_time = 2
	swap_cooldown.one_shot = true
	swap_cooldown.autostart = false
	add_child(swap_cooldown)
	swap_cooldown.timeout.connect(_on_swap_cooldown_timeout)

func _on_player_collision(_other_player):
	if game_manager and can_swap:
		can_swap = false
		game_manager.swap_player()
		swap_cooldown.start()

func _on_swap_cooldown_timeout():
	can_swap = true
