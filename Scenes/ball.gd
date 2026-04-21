extends CharacterBody2D
class_name Ball


@export var speed: float = 300.0


func _ready():
	velocity = Vector2(1, -1).normalized() * speed


func _physics_process(delta: float):
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		var brick := collision.get_collider() as StaticBody2D
		if brick and brick.is_in_group("bricks"):
			brick.queue_free()
