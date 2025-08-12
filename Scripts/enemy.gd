extends CharacterBody2D

var speed = 120;
var click_position;
var target_position = null;
var allowMove = false;
var Astar:AStar2D;
var currentPathIndex = 0;
var loopDirection = 1;
var isDistracted = false;

@export var PathArray:Array[int] = [];
@export var dialogueResourceRef:dialogue_resource;

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
	if isDistracted:
		isDistracted = false
		var idOfPath = Astar.get_closest_point(global_position)
		currentPathIndex = PathArray.find(idOfPath)
		target_position = Astar.get_point_position(PathArray[currentPathIndex])
		pass
	else:
		move()

func distracted(position:Vector2):
	isDistracted = true
	target_position = position
		
