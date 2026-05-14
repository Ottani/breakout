extends StaticBody2D
class_name Brick

@export var sprite_2d: Sprite2D

var xp: int = 1

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
