extends Node2D
class_name BrickManager

@export var area :CollisionShape2D
var brick_scene: PackedScene = preload("res://Scenes/brick.tscn")
var rect: Rect2
var brick_size: Vector2 = Vector2(48.0, 16.0)


func _ready() -> void:
	rect = area.shape.get_rect()


func create_bricks(cols: int, rows: int, h_gap: int, v_gap: int) -> int:
	var total_width: float = (cols * brick_size.x) + ((cols - 1) * h_gap)
	var total_height: float = (rows * brick_size.y) + ((rows - 1) * v_gap)
	var start_x: float = area.position.x - (total_width / 2) + (brick_size.x / 2)
	var x: float = start_x
	var y: float = area.position.y - (total_height / 2)
	@warning_ignore("integer_division")
	var mod: int = rows / 3
	for j: int in rows:
		@warning_ignore("integer_division")
		var level: int = (rows - (j + 1)) / mod
		for i: int in cols:
			var brick: Brick = brick_scene.instantiate() as Brick
			brick.position = Vector2(x, y)
			brick.level = level
			x += brick_size.x + h_gap
			add_child(brick)
		x = start_x
		y += brick_size.y + v_gap
	return cols * rows
