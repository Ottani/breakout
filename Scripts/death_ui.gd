extends CanvasLayer

@export var try_again_button: Button
@export var color_rect: ColorRect
@export var label: Label


func _ready() -> void:
	get_tree().paused = true
	label.scale = Vector2.ZERO
	var bg_tween: Tween = create_tween()
	bg_tween.tween_property(color_rect, "color", Color(0,0,0,0.25), 0.3)\
		.from(Color(0,0,0,0))
	var label_tween: Tween = create_tween()
	label_tween.tween_property(label, "scale", Vector2.ONE, 0.5)\
		.set_trans(Tween.TRANS_ELASTIC)\
		.set_ease(Tween.EASE_OUT)\
		.from(Vector2.ZERO)
	try_again_button.call_deferred("grab_focus")


func _on_try_again_button_pressed() -> void:
	get_tree().quit()
