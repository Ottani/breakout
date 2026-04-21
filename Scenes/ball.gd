extends CharacterBody2D
class_name Ball


@export var speed: float = 300.0
@export var paddle_delta: float = 10.0


func _ready():
	velocity = Vector2(1, -1).normalized() * speed


func _physics_process(delta: float):
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		var node_hit := collision.get_collider() as Node2D
		if node_hit is Paddle:
			var distance: float = (position.x - node_hit.position.x) / paddle_delta
			var direction = Vector2(distance, -1).normalized()
			velocity = direction * speed
		else:
			velocity = velocity.bounce(collision.get_normal())
			if node_hit and node_hit.is_in_group("bricks"):
				node_hit.queue_free()
