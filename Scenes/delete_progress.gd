extends Button

func _on_button_down():
	SaveManager.delete_save_data()
	get_tree().reload_current_scene()
