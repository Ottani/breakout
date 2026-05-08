class_name CardData
extends Resource

@export var title: String
@export var description: String
@export var effect: String
@export var value: float
@export_range(0, 100) var rarity: int = 50
