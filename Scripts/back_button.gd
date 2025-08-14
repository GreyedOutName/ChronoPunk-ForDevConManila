extends Button

func _on_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_mouse_entered() -> void:
	MusicPlayer.play_sound("button_hover")
