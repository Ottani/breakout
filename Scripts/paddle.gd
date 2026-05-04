extends CharacterBody2D
class_name Paddle

@export var SPEED: float = 250.0
@onready var left_sprite := $LeftSprite as Sprite2D
@onready var middle_sprite := $MiddleSprite as Sprite2D
@onready var right_sprite := $RightSprite as Sprite2D
@onready var anchor := $Marker2D as Marker2D
@onready var collision_shape := ($CollisionShape2D as CollisionShape2D).shape as RectangleShape2D
@onready var marker_2d := $Marker2D as Marker2D


const _initial_width: float = 64.0
var _curr_width: float = _initial_width
var _width_mod: float = 1.0
const _min_width_mod: float = 0.6
const _max_width_mod: float = 2.5
const _sprite_size: float = 16.0

var _half_width: float
var half_width: float:
	get:
		return _half_width


func _ready() -> void:
	_calculate_width()


func _calculate_width() -> void:
	_curr_width = _initial_width * _width_mod
	_half_width = _curr_width / 2.0
	left_sprite.position.x = -_half_width + (_sprite_size / 2.0)
	right_sprite.position.x = _half_width - (_sprite_size / 2.0)
	var target_middle_width := _curr_width - (2 * _sprite_size)
	middle_sprite.scale.x = target_middle_width / _sprite_size
	collision_shape.size.x = _curr_width
	marker_2d.position.x = right_sprite.position.x


func change_size_mod(delta: float) -> void:
	_width_mod += delta
	_width_mod = clampf(_width_mod, _min_width_mod, _max_width_mod)
	_calculate_width()


# TODO REMOVE
func _unhandled_key_input(event: InputEvent) -> void:
	var key := (event as InputEventKey).keycode
	if key == Key.KEY_PAGEUP:
		change_size_mod(0.01)
	elif key == Key.KEY_PAGEDOWN:
		change_size_mod(-0.01)


func _physics_process(_delta: float) -> void:
	velocity = Vector2(Input.get_axis("move_left", "move_right"), 0) * SPEED
	move_and_slide()


func get_anchor() -> Vector2:
	return anchor.global_position
	
