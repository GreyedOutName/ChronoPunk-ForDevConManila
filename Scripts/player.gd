extends CharacterBody2D
#player movement stats
var speed = 120;
var click_position;
var target_position = null;
var allowMove = false;
var Astar:AStar2D;
#GUI references
@export var MoveButton:Button;
@export var TalkButton:Button;

#Variables related to Signals
var dialogueText:String
var dialogueLabel:String

func _ready():
	#Get Astar for this level inside PathController
	Astar = get_tree().root.get_node("MainScene/PathController").getAstar()
	#Connect new_turn() signal
	GlobalSignals.new_turn.connect(_new_turn)
	
func movePlayer(roughTargetPosition:Vector2):
	#next_point and current_point gives values equal to a point index in the Astar Object
	var next_point = Astar.get_closest_point(roughTargetPosition)
	var current_point = Astar.get_closest_point(global_position)
	
	#check if mouse input is actually close to point
	var next_point_position = Astar.get_point_position(next_point)
	var maxDistance = 10; #in pixels
	if roughTargetPosition.distance_to(next_point_position) > maxDistance:
		#this means that input is invalid
		return
	
	if next_point!=current_point:
		var path = Astar.get_point_path(current_point,next_point)
		target_position = path[1]
		TurnController.turn_number += 1
		GlobalSignals.new_turn.emit()
		allowMove = !allowMove

func _physics_process(_delta):
	
	if Input.is_action_just_pressed("leftclick") and allowMove:
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
	
#All of the event driven code
func _on_area_2d_area_entered(area:Area2D):
	var whatsInThisNode = area.get_parent()
	if whatsInThisNode.is_in_group("npc"):
		dialogueText = whatsInThisNode.dialogue;
		dialogueLabel = whatsInThisNode.npc_name;
		TalkButton.visible = true
	
func _on_talk_button_button_down():
	GlobalSignals.open_dialogue.emit(dialogueText,dialogueLabel)

func _on_move_button_button_down():
	GlobalSignals.player_choosing_move.emit()
	allowMove = !allowMove # This is from the move button
	
func _on_wait_button_button_down():
	GlobalSignals.new_turn.emit()
	
func _new_turn():
	TalkButton.visible = false
