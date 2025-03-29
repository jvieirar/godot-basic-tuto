extends CanvasLayer

@onready var touch_controls: CanvasLayer = $"."
@onready var button_left: TouchScreenButton = $ButtonLeft
@onready var button_right: TouchScreenButton = $ButtonRight
@onready var button_jump: TouchScreenButton = $ButtonJump

func _ready():
	# Position buttons relative to screen edges
	position_buttons()
	# Connect to window resize signal to reposition buttons when screen size changes
	get_tree().root.size_changed.connect(position_buttons)

func position_buttons():
	var viewport_size = get_viewport().size
	
	# Position left button at bottom left with padding
	button_left.position = Vector2(50, viewport_size.y - button_left.texture_normal.get_height() - 50)
	
	# Position right button next to left button
	button_right.position = Vector2(
		button_left.position.x + button_left.texture_normal.get_width() + 20, 
		button_left.position.y
	)
	
	# Position jump button at bottom right with padding
	button_jump.position = Vector2(
		viewport_size.x - button_jump.texture_normal.get_width() - 50,
		viewport_size.y - button_jump.texture_normal.get_height() - 50
	)
