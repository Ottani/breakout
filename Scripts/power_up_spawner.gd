extends Node
class_name PowerUpSpawner

@export var power_up_scene: PackedScene
@export var power_up_pool: Array[PowerUpData] = []

var total_weight: int = 0


func _ready() -> void:
	if power_up_pool.is_empty(): 
		return
	for p: PowerUpData in power_up_pool:
		total_weight += p.rarity


func spawn_random_powerup(spawn_position: Vector2) -> void:
	if power_up_pool.is_empty(): 
		return
	
	var roll: int = randi_range(0, total_weight)
	var current_weight: int = 0
	
	for p: PowerUpData in power_up_pool:
		current_weight += p.rarity
		if roll <= current_weight:
			var instance: PowerUp = power_up_scene.instantiate() as PowerUp
			instance.data = p
			instance.global_position = spawn_position
			get_parent().add_child(instance)
			return
