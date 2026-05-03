extends CanvasLayer

const HEART = preload("res://Scenes/heart.tscn")
@onready var lives_container := $Control/MarginContainer/HBoxContainer/Lives as  HBoxContainer
@onready var points_label: Label = $Control/MarginContainer/HBoxContainer/PointsLabel


func _ready() -> void:
	SignalBus.life_updated.connect(update_lives)
	SignalBus.points_updated.connect(update_points)


func update_lives(lives: int) -> void:
	var hearts: int = lives_container.get_child_count()
	if hearts == lives:
		return
	elif hearts > lives:
		var todel: int = hearts - lives
		for heart in lives_container.get_children():
			heart.queue_free()
			todel -= 1
			if todel == 0:
				break
	else:
		var toadd: int = lives - hearts
		for i in range(toadd):
			lives_container.add_child(HEART.instantiate())


func update_points(points: int) -> void:
	points_label.text = "Points: %d" % points
