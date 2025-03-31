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
	#if player2_area:
		#player2_area.player_collision.connect(_on_player_collision)
	
	# Create a timer programmatically
	swap_cooldown = Timer.new()
	swap_cooldown.name = "SwapCooldown"
	swap_cooldown.wait_time = 2
	swap_cooldown.one_shot = true
	swap_cooldown.autostart = false
	add_child(swap_cooldown)
	swap_cooldown.timeout.connect(_on_swap_cooldown_timeout)
	
	# Window size
	_set_window_size()
	

func _on_player_collision(_other_player):
	if game_manager and can_swap:
		can_swap = false
		game_manager.swap_player()
		swap_cooldown.start()

func _on_swap_cooldown_timeout():
	can_swap = true

func _set_window_size():
	# Get the screen size
	var screen_size = DisplayServer.screen_get_size()
	
	# Calculate window size (e.g., 80% of screen width)
	var scale_factor = 0.4  # 80% of screen size
	var window_width = int(screen_size.x * scale_factor)
	# Calculate height to maintain 16:9 ratio
	var window_height = int(window_width * 9.0 / 16.0)
	
	# Make sure the height doesn't exceed screen height
	if window_height > screen_size.y:
		window_height = int(screen_size.y * scale_factor)
		window_width = int(window_height * 16.0 / 9.0)
	
	# Set the window size
	DisplayServer.window_set_size(Vector2i(window_width, window_height))
	
	# Center the window
	var centered_pos = (screen_size - Vector2i(window_width, window_height)) / 2
	DisplayServer.window_set_position(centered_pos)
