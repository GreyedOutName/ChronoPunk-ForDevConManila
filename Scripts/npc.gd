extends CharacterBody2D
class_name npc

var speed = 120;
var target_position = null;
var Astar:AStar2D;
var currentPathIndex = 0;
var loopDirection = 1;

@export var PathArray:Array[int] = [];

func _ready():
	Astar = $"../PathController".getAstar()
	GlobalSignals.new_turn.connect(_on_new_turn)
	
func _physics_process(_delta):	
	if target_position != null:
		var distance = global_position.distance_to(target_position);
		if distance > 4:
			var direction = (target_position - global_position).normalized()
			velocity = direction * speed
		else:
			global_position = target_position  # snap exactly to point
			velocity = Vector2.ZERO
	else:
		velocity = Vector2.ZERO
		
	move_and_slide()
	
func move():
	currentPathIndex += loopDirection
	print(str(TurnController.turn_number)+": "+str(currentPathIndex))
	if currentPathIndex < PathArray.size()-1 and currentPathIndex > 0:
		target_position = Astar.get_point_position(PathArray[currentPathIndex])
	elif currentPathIndex == PathArray.size()-1:
		# Upper bound reached (4), reverse
		loopDirection *= -1
		target_position = Astar.get_point_position(PathArray[currentPathIndex])
	elif currentPathIndex == 0:
		# Lower bound passed (-1), reverse & step back into range
		loopDirection *= -1
		target_position = Astar.get_point_position(PathArray[currentPathIndex])
	
func _on_new_turn():
		move()
		
