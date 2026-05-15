class_name PowerUpData extends Resource

enum Type { LIFE, WIDE_PADDLE, FAST_BALL }

@export var type: Type
@export var speed: float = 150.0
@export var animation_name: String
@export_range(0, 100) var rarity: int = 50
