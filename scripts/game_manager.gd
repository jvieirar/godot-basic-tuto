extends Node

var score := 0

@onready var label_end_level_score: Label = $LabelEndLevelScore

func add_point():
	score += 1
	label_end_level_score.text = "You collected " + str(score) + " coins!"
	print(label_end_level_score.text)
