extends Node2D
class_name BrickManager

@onready var area:= $Area2D/CollisionShape2D as CollisionShape2D
var brick_scene: PackedScene = preload("res://Scenes/brick.tscn")


func create_bricks(cols: int, rows: int, gap: int):
	var brick: StaticBody2D = brick_scene.instantiate()
	brick.position = area.position
	add_child(brick)
	
