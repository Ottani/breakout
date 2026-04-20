extends CharacterBody2D


@export var speed: float = 300.0


func _ready():
	velocity = Vector2(1, -1).normalized() * speed


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		
		# Optional: Check if we hit a brick to destroy it
		#if collision.get_collider().is_in_group("bricks"):
		#    collision.get_collider().queue_free()
