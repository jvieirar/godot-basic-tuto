extends Node

var score := 0

@onready var label_end_level_score: Label = $LabelEndLevelScore

var is_mobile = OS.get_name() == "Android" or OS.get_name() == "iOS" or OS.has_feature("web_android")or OS.has_feature("web_ios")

func add_point():
	score += 1
	label_end_level_score.text = "You collected " + str(score) + " coins!"
	print(label_end_level_score.text)
