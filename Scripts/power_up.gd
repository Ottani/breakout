class_name PowerUp
extends Area2D

@export var data: PowerUpData
@export var sprite: AnimatedSprite2D

const speed: Vector2 = Vector2(0, 150.0)


func _ready() -> void:
	if data:
		sprite.play(data.animation_name)
	else:
		push_warning("PowerUp spawned without data!")


func _physics_process(delta: float) -> void:
	if data:
		position.y += data.speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body is Paddle:
		SignalBus.power_up_picked.emit(data.type)
		queue_free()
