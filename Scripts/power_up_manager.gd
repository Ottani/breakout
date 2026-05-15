class_name PowerUpManager extends Node

@export var power_up_container: Node2D
const power_up_scene: PackedScene = preload("uid://bid18oh6id54a")
const power_up_chance: float = 0.07
var power_up_pool: Array[PowerUpData] = []
var total_weight: int = 0


func _ready() -> void:
	SignalBus.brick_destroyed.connect(_on_brick_destroyed)
	var file: FileAccess = FileAccess.open("res://Data/power_ups.txt", FileAccess.READ)
	var _header: PackedStringArray = file.get_csv_line() 
	while not file.eof_reached():
		var line: PackedStringArray = file.get_csv_line()
		if line.size() < 4:
			continue
		var entry: PowerUpData = PowerUpData.new()
		entry.type = PowerUpData.Type[line[0]]
		entry.speed = line[1].to_float()
		entry.animation_name = line[2]
		entry.rarity = line[3].to_int()
		total_weight += entry.rarity
		power_up_pool.append(entry)


func _on_brick_destroyed(pos: Vector2, _score: int) -> void:
	if power_up_pool.is_empty() or randf() > power_up_chance:
		return
	
	var roll: int = randi_range(0, total_weight)
	var current_weight: int = 0
	
	for p: PowerUpData in power_up_pool:
		current_weight += p.rarity
		if roll <= current_weight:
			var instance: PowerUp = power_up_scene.instantiate() as PowerUp
			instance.data = p
			instance.global_position = pos
			get_parent().add_child(instance)
			return
