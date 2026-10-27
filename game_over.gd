extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	Global.reset_game()
	get_tree().reload_current_scene()


func _on_exit_button_pressed() -> void:
	get_tree().quit()
