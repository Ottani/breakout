extends Node2D

@onready var brick_manager = $BrickManager as BrickManager
var ball_scene: PackedScene = preload("res://Scenes/ball.tscn")

func _ready() -> void:
	brick_manager.create_bricks(10, 4, 4)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("cancel"):
		get_tree().quit()


func _on_death_area_body_entered(body: Node2D) -> void:
	if body is Ball:
		body.queue_free()
		await get_tree().create_timer(0.5).timeout
		var ball := ball_scene.instantiate() as Ball
		add_child(ball)
