extends Node2D
class_name BrickManager

@onready var area:= $Area2D/CollisionShape2D as CollisionShape2D
var brick_scene: PackedScene = preload("res://Scenes/brick.tscn")
var rect: Rect2
var brick_size := Vector2(48.0, 16.0)


func _ready() -> void:
	rect = area.shape.get_rect()


func create_bricks(cols: int, rows: int, gap: int) -> int:
	var total_width: float = (cols * brick_size.x) + ((cols - 1) * gap)
	var total_height: float = (rows * brick_size.y) + ((rows - 1) * gap)
	var start_x: float = area.position.x - (total_width / 2) + (brick_size.x / 2)
	var x := start_x
	var y: float = area.position.y - (total_height / 2)
	for j in rows:
		for i in cols:
			var brick: StaticBody2D = brick_scene.instantiate() as StaticBody2D
			brick.position = Vector2(x, y)
			x += brick_size.x + gap
			add_child(brick)
		x = start_x
		y += brick_size.y + gap
	return cols * rows
