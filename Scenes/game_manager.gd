extends Node

var lives := 3

func _ready() -> void:
	pass # Replace with function body.


func lost_life():
	lives -= 1
	if lives == 0:
		pass
