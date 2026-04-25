extends Node2D

@onready var brick_manager = $BrickManager as BrickManager
@onready var ball: Ball = $Ball

var bricks_left: int = 0


func _ready() -> void:
	SignalBus.brick_hit.connect(_on_brick_hit)
	bricks_left = brick_manager.create_bricks(10, 4, 4)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("cancel"):
		get_tree().quit()


func _on_death_area_body_entered(body: Node2D) -> void:
	if body is Ball:
		ball.reset()


func _on_brick_hit(brick: Brick) -> void:
	bricks_left -= 1
	brick.queue_free()
	if (bricks_left <= 0):
		await get_tree().create_timer(0.5).timeout
		bricks_left = brick_manager.create_bricks(10, 4, 4)
		
	
