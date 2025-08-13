extends Node2D

var AStar = AStar2D.new()
var line: Line2D

@export var connections:Array[PackedInt32Array]

func getAstar():
	return AStar;
	
func drawLine(firstPos:int,secondPos:int):
	var path = AStar.get_point_path(firstPos, secondPos)

	# Outline (black, thicker)
	var outline = Line2D.new()
	outline.width = 3
	outline.default_color = Color.BLACK
	for pos in path:
		outline.add_point(pos)
	add_child(outline)

	# Main line (colored, thinner)
	var line = Line2D.new()
	line.width = 1
	line.default_color = Color(0.5, 0.5, 0.5)  # gray
	for pos in path:
		line.add_point(pos)
	add_child(line)

func addPointsToAstar():
	# Get all path nodes
	var points = get_tree().get_nodes_in_group("PathNodes")
	
	# Add points to AStar
	for i in range(points.size()):
		AStar.add_point(i, points[i].position, 1.0)
		
	for i in range(connections.size()):
		AStar.connect_points(connections[i][0],connections[i][1])
		drawLine(connections[i][0],connections[i][1])
	
func _ready():
	addPointsToAstar();
	
func just_in_case():
	# Connect points (example setup)
	# Set this for each level
	# TODO (Keoj): Need to compact this to avoid D.R.Y
	AStar.connect_points(0, 1)
	drawLine(0,1)
	AStar.connect_points(0, 2)
	drawLine(0,2)
	AStar.connect_points(1, 3)
	drawLine(1,3)
	AStar.connect_points(2, 3)
	drawLine(2,3)
	AStar.connect_points(2, 4)
	drawLine(2,4)
	AStar.connect_points(3, 4)
	drawLine(3,4)
