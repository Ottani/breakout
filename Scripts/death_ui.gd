extends CanvasLayer

@onready var try_again_button := $Control/VBoxContainer/TryAgainButton as Button
@onready var color_rect := $ColorRect as ColorRect
@onready var label := $Control/VBoxContainer/Label as Label


func _ready() -> void:
	get_tree().paused = true
	label.scale = Vector2.ZERO
	var bg_tween = create_tween()
	bg_tween.tween_property(color_rect, "color", Color(0,0,0,0.25), 0.3)\
		.from(Color(0,0,0,0))
	var label_tween = create_tween()
	label_tween.tween_property(label, "scale", Vector2.ONE, 0.5)\
		.set_trans(Tween.TRANS_ELASTIC)\
		.set_ease(Tween.EASE_OUT)\
		.from(Vector2.ZERO)
	try_again_button.call_deferred("grab_focus")


func _on_try_again_button_pressed() -> void:
	get_tree().quit()
