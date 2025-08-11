extends CharacterBody2D

var speed = 120;
var click_position;
var target_position = null;
var allowMove = false;
var Astar:AStar2D;
var currentPathIndex = 0;

@export var PathArray:Array[int] = [];
@export var dialogueResourceRef:dialogue_resource;

func _ready():
	Astar = get_tree().root.get_node("MainScene/PathController").getAstar()
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
	
func _on_new_turn():
	if currentPathIndex < PathArray.size()-1:
		currentPathIndex += 1
		target_position = Astar.get_point_position(PathArray[currentPathIndex])
		
