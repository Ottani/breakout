extends CharacterBody2D
class_name Paddle

@export var SPEED: float = 250.0
@export var left_sprite: Sprite2D
@export var middle_sprite: Sprite2D
@export var right_sprite: Sprite2D
@export var anchor: Marker2D
# this is safer to get cast errors before, but too noisy
@onready var collision_shape: CapsuleShape2D = ($CollisionShape2D as CollisionShape2D).shape as CapsuleShape2D


const _initial_width: float = 64.0
var _curr_width: float = _initial_width
var _curr_speed: float = SPEED

const _min_width: float = 34.0
const _max_width: float = 160.0
const _sprite_size: float = 16.0

var _half_width: float
var half_width: float:
	get:
		return _half_width


func _ready() -> void:
	_calculate_width()


func _calculate_width() -> void:
	_half_width = _curr_width / 2.0
	left_sprite.position.x = -_half_width + (_sprite_size / 2.0)
	right_sprite.position.x = _half_width - (_sprite_size / 2.0)
	var target_middle_width: float = _curr_width - (2 * _sprite_size)
	middle_sprite.scale.x = target_middle_width / _sprite_size
	collision_shape.height = _curr_width
	anchor.position.x = right_sprite.position.x


func apply_powerup_stretch(amount: float, duration: float) -> void:
	if _curr_width >= _max_width or _curr_width <= _min_width or amount == 0:
		return
	var reset: float = amount
	if amount > 0:
		if _curr_width + amount > _max_width:
			reset = _max_width - _curr_width
	else:
		if _curr_width + amount < _min_width:
			reset = _min_width - _curr_width
	_curr_width += reset
	_calculate_width()
	await get_tree().create_timer(duration).timeout
	if is_inside_tree():
		_curr_width -= reset
		_calculate_width()


func apply_power_up_speed(amount: float, duration: float) -> void:
	_curr_speed += amount
	await get_tree().create_timer(duration).timeout
	if is_inside_tree():
		_curr_speed -= amount


func _physics_process(_delta: float) -> void:
	velocity = Vector2(Input.get_axis("move_left", "move_right"), 0) * _curr_speed
	move_and_slide()


func get_anchor() -> Vector2:
	return anchor.global_position
	
