extends CharacterBody2D
class_name Ball

enum State { ATTACHED, MOVING, DYING }

var speed: float = 250.0
var paddle_delta: float = 10.0
var bounce_influence: float = 1.7
var min_y_tilt: float = 0.3
@export var paddle: Paddle

var current_state: State = State.ATTACHED


func _ready() -> void:
	reset()


func reset() -> void:
	global_position = paddle.get_anchor()
	scale = Vector2.ONE
	velocity = Vector2.ZERO
	current_state = State.ATTACHED
	

func _hit_paddle() -> void:
	var distance: float = (global_position.x - paddle.global_position.x) / paddle.half_width
	distance = clampf(distance, -1.0, 1.0)
	var direction: Vector2 = Vector2(distance * bounce_influence, -1).normalized()
	velocity = direction * speed


func _physics_process(delta: float) -> void:
	match current_state:
		State.ATTACHED:
			global_position = paddle.get_anchor()
			if Input.is_action_just_pressed("launch"):
				velocity = Vector2(randf_range(-0.75, 0.75), -1.0).normalized() * speed
				current_state = State.MOVING
		State.MOVING:		
			var collision: KinematicCollision2D = move_and_collide(velocity * delta)
			if collision:
				var node_hit: Node2D = collision.get_collider() as Node2D
				if node_hit is Paddle:
					_hit_paddle()
				else:
					velocity = velocity.bounce(collision.get_normal())
					if absf(velocity.y) < min_y_tilt:
						velocity.y = signf(velocity.y) * min_y_tilt
						velocity = velocity.normalized() * speed
					if node_hit and node_hit.is_in_group("bricks"):
						(node_hit as Brick).die()
						
		State.DYING:
			pass
