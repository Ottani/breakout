extends CanvasLayer

@onready var continue_button := $MarginContainer/VBoxContainer/VBoxContainer/ContinueButton as Button
var is_closing: bool = false


func _ready() -> void:
	get_tree().paused = true
	continue_button.call_deferred("grab_focus")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel"):
		close()
		get_tree().root.set_input_as_handled()


func _on_continue_button_pressed() -> void:
	close()


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func close():
	if is_closing:
		return
	is_closing = true
	get_tree().paused = false
	queue_free()
