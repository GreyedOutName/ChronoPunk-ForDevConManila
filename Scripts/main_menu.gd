extends Node2D

func _on_play_button_button_down():
	get_tree().change_scene_to_file("res://Scenes/level_select.tscn")
	MusicPlayer.play_song("PB - Data Shortcut")

# Implement credits and quit
func _on_quit_button_button_down() -> void:
	get_tree().quit()
