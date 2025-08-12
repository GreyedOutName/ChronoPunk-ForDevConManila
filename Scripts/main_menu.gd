extends Node2D


func _on_play_button_button_down():
	get_tree().change_scene_to_file("res://Scenes/level_select.tscn")

# Implement options, credits, etc.
