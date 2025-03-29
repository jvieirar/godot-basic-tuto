extends CanvasLayer

@onready var touch_controls: CanvasLayer = $"."
@onready var button_left: TouchScreenButton = $ButtonLeft
@onready var button_right: TouchScreenButton = $ButtonRight
@onready var button_jump: TouchScreenButton = $ButtonJump

const MARGIN_Y = 30
const MARGIN_X = 50
const BUTTON_SCALE = 2.0
const BUTTON_SPACING = 10  # Space between buttons

func _ready():
	# Check if touchscreen is available
	var is_mobile = OS.get_name() == "Android" or OS.get_name() == "iOS" or OS.has_feature("web_android")or OS.has_feature("web_ios")
	print("is touch available? ", is_mobile)
	if not is_mobile:
		# Hide the controls if no touchscreen is detected
		visible = false
		return
		
	# for not touchable:
	visible = true
	
	# Apply scale to buttons
	apply_button_scale()
	# Position buttons relative to screen edges
	position_buttons()
	# Connect to window resize signal to reposition buttons when screen size changes
	get_tree().root.size_changed.connect(position_buttons)

func apply_button_scale():
	button_left.scale = Vector2(BUTTON_SCALE, BUTTON_SCALE)
	button_right.scale = Vector2(BUTTON_SCALE, BUTTON_SCALE)
	button_jump.scale = Vector2(BUTTON_SCALE, BUTTON_SCALE)

func position_buttons():
	var viewport_size = get_viewport().size

	#var BUTTON_SCALE = button_left.scale.x

	# Calculate scaled dimensions
	var left_width = button_left.texture_normal.get_width() * BUTTON_SCALE
	var left_height = button_left.texture_normal.get_height() * BUTTON_SCALE

	# Position left button at bottom left with padding
	button_left.position = Vector2(MARGIN_X, viewport_size.y - left_height - MARGIN_Y)

	# Position right button next to left button with spacing
	button_right.position = Vector2(
		button_left.position.x + left_width + BUTTON_SPACING, 
		button_left.position.y
	)

	# Position jump button at bottom right with padding
	button_jump.position = Vector2(
		viewport_size.x - (button_jump.texture_normal.get_width() * BUTTON_SCALE) - MARGIN_X,
		viewport_size.y - (button_jump.texture_normal.get_height() * BUTTON_SCALE) - MARGIN_Y
	)
