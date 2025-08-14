extends Button

func _on_button_down():
	SaveManager.delete_save_data()
	get_tree().reload_current_scene()


func _on_mouse_entered() -> void:
	MusicPlayer.play_sound("button_hover")
