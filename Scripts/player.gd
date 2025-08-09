extends CharacterBody2D

var speed = 120;
var click_position;
var target_position = null;
var Astar;


func _ready():
	Astar = get_tree().root.get_node("MainScene/PathController").getAstar()
	
func movePlayer(roughTargetPosition):
	#next_point and current_point gives values equal to a point index in the Astar Object
	var next_point = Astar.get_closest_point(roughTargetPosition)
	var current_point = Astar.get_closest_point(global_position)
	if next_point!=current_point:
		var path = Astar.get_point_path(current_point,next_point)
		target_position = path[1]

func _physics_process(_delta):
	if Input.is_action_just_pressed("leftclick"):
		click_position = get_global_mouse_position()
		movePlayer(click_position)
		
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
		
