extends CanvasLayer

const HEART: PackedScene = preload("res://Scenes/heart.tscn")

@export var lives_container: HBoxContainer
@export var points_label: Label
@export var xp_bar: ProgressBar
@export var level_label: Label


func _ready() -> void:
	SignalBus.life_updated.connect(update_lives)
	SignalBus.points_updated.connect(update_points)
	SignalBus.xp_updated.connect(_on_update_xp)
	SignalBus.level_updated.connect(_on_update_level)


func update_lives(lives: int) -> void:
	var hearts: int = lives_container.get_child_count()
	if hearts == lives:
		return
	elif hearts > lives:
		var todel: int = hearts - lives
		for heart: Node in lives_container.get_children():
			heart.queue_free()
			todel -= 1
			if todel == 0:
				break
	else:
		var toadd: int = lives - hearts
		for i: int in range(toadd):
			lives_container.add_child(HEART.instantiate())


func update_points(points: int) -> void:
	points_label.text = "Points: %d" % points


func _on_update_xp(curr_xp: int, max_xp: int) -> void:
	xp_bar.max_value = max_xp
	xp_bar.value = curr_xp


func _on_update_level(level: int) -> void:
	level_label.text = "Level: %d" % level
