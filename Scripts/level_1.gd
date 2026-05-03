extends Node2D

@onready var brick_manager = $BrickManager as BrickManager
@onready var ball = $Ball as Ball

const pause_scene = preload("res://Scenes/pause_menu.tscn")


var bricks_left: int = 0
var lives: int = 3
var points: int = 0


func _ready() -> void:
	SignalBus.brick_hit.connect(_on_brick_hit)
	bricks_left = brick_manager.create_bricks(10, 4, 4)
	lives = 3
	SignalBus.life_updated.emit(lives)
	points = 0
	SignalBus.points_updated.emit(points)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel"):
		add_child(pause_scene.instantiate())
		get_tree().root.set_input_as_handled()


func _on_death_area_body_entered(body: Node2D) -> void:
	if body is Ball:
		lives -= 1
		SignalBus.life_updated.emit(lives)
		ball.reset()


func _on_brick_hit(brick: Brick) -> void:
	bricks_left -= 1
	brick.queue_free()
	points += 5
	SignalBus.points_updated.emit(points)
	if (bricks_left <= 0):
		await get_tree().create_timer(0.5).timeout
		bricks_left = brick_manager.create_bricks(10, 4, 4)
