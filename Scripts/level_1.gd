extends Node2D

@export var brick_manager: BrickManager
@export var ball: Ball
@export var power_up_spawner: PowerUpSpawner
@export var paddle: Paddle

const pause_scene: PackedScene = preload("res://Scenes/pause_menu.tscn")
const death_scene: PackedScene = preload("res://Scenes/death_ui.tscn")

const power_up_chance: float = 0.07
const max_lives: int = 9

var bricks_left: int = 0
var lives: int = 3
var points: int = 0


func _ready() -> void:
	ExperienceManager.reset()
	SignalBus.brick_hit.connect(_on_brick_hit)
	_create_bricks()
	lives = 3
	SignalBus.life_updated.emit(lives)
	points = 0
	SignalBus.points_updated.emit(points)
	SignalBus.power_up_picked.connect(_on_power_up_picked)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel"):
		add_child(pause_scene.instantiate())
		get_tree().root.set_input_as_handled()


func _on_death_area_body_entered(body: Node2D) -> void:
	if body is Ball:
		ball.current_state = Ball.State.DYING
		lives -= 1
		SignalBus.life_updated.emit(lives)
		var tween: Tween = create_tween()
		tween.tween_property(ball, 'scale', Vector2.ZERO, 0.4)\
			.set_ease(Tween.EASE_IN)
		await tween.finished
		if lives == 0:
			add_child(death_scene.instantiate())
		else:
			ball.reset()


func _on_death_area_area_entered(area: Area2D) -> void:
	if area is PowerUp:
		area.queue_free()


func _on_brick_hit(brick: Brick) -> void:
	bricks_left -= 1
	var value: int = brick.xp
	brick.queue_free()
	points += value
	SignalBus.points_updated.emit(points)
	ExperienceManager.add_xp(value)
	if (bricks_left <= 0):
		await get_tree().create_timer(0.5).timeout
		_create_bricks()
	else:
		if randf() <= power_up_chance:
			power_up_spawner.spawn_random_powerup(brick.global_position)


func _on_power_up_picked(type: PowerUpData.Type) -> void:
	match type:
		PowerUpData.Type.LIFE:
			lives += 1
			lives = clampi(lives, 0, max_lives)
			SignalBus.life_updated.emit(lives)
		
		PowerUpData.Type.WIDE_PADDLE:
			paddle.apply_powerup_stretch(30, 5)
		
		PowerUpData.Type.FAST_BALL:
			paddle.apply_power_up_speed(50, 5)
 
func _create_bricks() -> void:
	bricks_left = brick_manager.create_bricks(11, 6, 6, 4)
