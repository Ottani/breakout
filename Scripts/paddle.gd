extends CharacterBody2D
class_name Paddle

@export var SPEED: float = 250.0
@onready var sprite: Sprite2D = $Sprite2D as Sprite2D
@onready var anchor: Marker2D = $Marker2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var marker_2d: Marker2D = $Marker2D

var _calculated_width: float
var half_width: float:
	get:
		return _calculated_width


func _ready() -> void:
	var shape := collision_shape.shape as RectangleShape2D
	_calculated_width = shape.size.x / 2.0


func _physics_process(_delta: float) -> void:
	velocity = Vector2(Input.get_axis("move_left", "move_right"), 0) * SPEED
	move_and_slide()


func get_anchor() -> Vector2:
	return anchor.global_position
	
