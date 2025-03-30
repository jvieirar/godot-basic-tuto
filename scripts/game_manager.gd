extends Node

var score := 0

@onready var game_manager: Node = %GameManager
@onready var player_1: CharacterBody2D = $"../Players/Player1"
@onready var player_2: CharacterBody2D = $"../Players/Player2"
@onready var camera_player_1: Camera2D = $"../Players/Player1/CameraPlayer1"
@onready var camera_player_2: Camera2D = $"../Players/Player2/CameraPlayer2"
@onready var label_end_level_score: Label = $LabelEndLevelScore

var selected_player: CharacterBody2D

var is_mobile = OS.get_name() == "Android" or OS.get_name() == "iOS" or OS.has_feature("web_android")or OS.has_feature("web_ios")

func _ready():
	set_player_1()

func add_point():
	score += 1
	label_end_level_score.text = "You collected " + str(score) + " coins!"
	print(label_end_level_score.text)

func swap_player():
	if selected_player.name == player_1.name:
		set_player_2()
	else:
		set_player_1()

func set_player_1():
	print("Setting active player to Player1")
	selected_player = player_1
	
	# Explicitly disable Player2's camera first
	camera_player_2.enabled = false
	# Then enable Player1's camera
	camera_player_1.enabled = true
	
	# Set input processing
	player_1.can_process_input = true
	player_2.can_process_input = false

func set_player_2():
	print("Setting active player to Player2")
	selected_player = player_2
	
	# Explicitly disable Player1's camera first
	camera_player_1.enabled = false
	# Then enable Player2's camera
	camera_player_2.enabled = true
	
	# Set input processing
	player_1.can_process_input = false
	player_2.can_process_input = true
