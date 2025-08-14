extends Node2D

func _on_play_button_button_down():
	get_tree().change_scene_to_file("res://Scenes/level_select.tscn")

# Implement credits and quit
func _on_quit_button_button_down() -> void:
	get_tree().quit()


func _on_play_button_mouse_entered() -> void:
	MusicPlayer.play_sound("button_hover")


func _on_credits_button_mouse_entered() -> void:
	MusicPlayer.play_sound("button_hover")


func _on_quit_button_mouse_entered() -> void:
	MusicPlayer.play_sound("button_hover")
