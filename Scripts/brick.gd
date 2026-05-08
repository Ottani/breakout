extends StaticBody2D
class_name Brick

@onready var sprite_2d: Sprite2D = $Sprite2D as Sprite2D

var xp = 1

var level: int = 0:
	set(value):
		level = clampi(value, 0, 2)
		xp = (level * 2) + 1
		if level == 2:
			xp = 7
		if is_inside_tree():
			sprite_2d.frame = level


func _ready() -> void:
	sprite_2d.frame = level
