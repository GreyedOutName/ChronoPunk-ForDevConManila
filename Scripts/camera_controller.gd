extends Node2D

var move_limit := 150 #value in pixels
var zoom_min := 2.0
var zoom_max := 12.0

func _input(event):
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("rightclick"):
			global_position += event.relative
			# Clamp position so it stays within [-500, 500] range in X and Y
			global_position.x = clamp(global_position.x, -move_limit, move_limit)
			global_position.y = clamp(global_position.y, -move_limit, move_limit)
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			$Camera2D.zoom -= Vector2(0.4,0.4)
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			$Camera2D.zoom += Vector2(0.4,0.4)
			
		# Clamp zoom so it's never less than zoom_min or more than zoom_max
		$Camera2D.zoom.x = clamp($Camera2D.zoom.x, zoom_min, zoom_max)
		$Camera2D.zoom.y = clamp($Camera2D.zoom.y, zoom_min, zoom_max)
