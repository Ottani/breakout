extends CharacterBody2D

@export var SPEED: float = 250.0
@onready var sprite: Sprite2D = $Sprite2D as Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(_delta: float) -> void:
	velocity = Vector2(Input.get_axis("move_left", "move_right"), 0) * SPEED
	move_and_slide()
