extends npc

var isDistracted = false;
var isChasing = false

func _on_new_turn():
	if isDistracted:
		isDistracted = false
		var idOfPath = Astar.get_closest_point(global_position)
		currentPathIndex = PathArray.find(idOfPath)
		target_position = Astar.get_point_position(PathArray[currentPathIndex])
		pass
	elif isChasing:
		pass
	else:
		move()

func distracted(position:Vector2):
	isDistracted = true
	target_position = position
		
