extends npc

var isDistracted = false;
var isChasing = false

var distractorPosition = null;

func _on_new_turn():
	if isDistracted and distractorPosition != null: #this code is going back from distracted status to normal
		target_position=distractorPosition
		
		isDistracted = false
		distractorPosition = null
		return
		
	var idOfPath = Astar.get_closest_point(global_position)
	currentPathIndex = PathArray.find(idOfPath)
	target_position = Astar.get_point_position(PathArray[currentPathIndex])
	move()

func distracted(distractorPosArgument:Vector2):
	isDistracted = true
	distractorPosition = distractorPosArgument
		
