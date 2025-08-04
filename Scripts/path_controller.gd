extends Node2D

var AStar = AStar2D.new()
var line: Line2D

func _ready():
	# Create and add Line2D node to draw the path
	line = Line2D.new()
	add_child(line)
	line.width = 4
	line.default_color = Color(128, 150, 0) # red line

	# Get all path nodes
	var points = get_tree().get_nodes_in_group("PathNodes")
	
	# Add points to AStar
	for i in range(points.size()):
		AStar.add_point(i, points[i].position, 1.0)
	
	# Connect points (example setup)
	AStar.connect_points(0, 1)
	AStar.connect_points(0, 2)
	AStar.connect_points(1, 3)
	AStar.connect_points(2, 3)
	AStar.connect_points(3, 4)
	
	# Get path from 0 to 3
	var path = AStar.get_point_path(1, 4)  # returns actual positions, unlike get_id_path
	
	# Draw path using Line2D
	for pos in path:
		line.add_point(pos)
