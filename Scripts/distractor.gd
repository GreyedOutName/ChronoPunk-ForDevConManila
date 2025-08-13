extends Node2D

var Astar:AStar2D;

func checkForEnemies():
	var currentPoint = Astar.get_closest_point(global_position)
	var connectedPoints:Array = Astar.get_point_connections(currentPoint)
	
	for connectedPoint in connectedPoints:
		var checkThisPoint = Astar.get_point_position(connectedPoint)
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsPointQueryParameters2D.new()
		query.position = checkThisPoint # Replace 'your_point_vector' with the Vector2 of your point
		query.collide_with_areas = true # Crucially, set this to true to detect areas
		query.collide_with_bodies = false # Set to false if you only care about areas
		var result = space_state.intersect_point(query)
		
		for areaHit in result:
			var whoisthis = areaHit.collider.get_parent()
			if whoisthis.is_in_group("enemy"):
				whoisthis.distracted(global_position)
				
func _new_turn():
	checkForEnemies()

func _ready():
	Astar = $"../PathController".getAstar()
	GlobalSignals.new_turn.connect(_new_turn)
	checkForEnemies()

func _on_area_2d_area_entered(area):
	var whatsInThisNode = area.get_parent()
	if whatsInThisNode.is_in_group("enemy"):
		queue_free()
