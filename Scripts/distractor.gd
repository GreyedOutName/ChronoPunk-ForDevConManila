extends Node2D

var Astar:AStar2D;

func _ready():
	Astar = $"../PathController".getAstar()

func _on_area_2d_area_entered(area):
	var whatsInThisNode = area.get_parent()
	if whatsInThisNode.is_in_group("enemy"):
		queue_free()
