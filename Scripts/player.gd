extends CharacterBody2D
class_name Player

#player movement stats
var speed = 120;
var click_position;
var target_position = null;
var allowMove = false;
var placingDistractor = false;
var Astar:AStar2D;

#For Equipment
var items_left:Array[int] = [2,1,1]
var teleporter = preload("res://objects/teleporter_pointer.tscn")
var distractor = preload("res://objects/distractor.tscn")
var teleporterPointer:Node2D;

#GUI references
@export var ActionsMenu:Control;
@export var TeleporterButtonContainer:NinePatchRect;
@export var TalkButton:Button;

#Variables related to Signals
#Dialogue Related Things
var dialogueText:Dictionary
var dialogueLabel:String
var dialogueKey:String = "1st"
var dialogueIndex:int = 0

func _ready():
	#Get Astar for this level inside PathController
	if $"../PathController":
		Astar = $"../PathController".getAstar()
	#Connect new_turn() signal
	GlobalSignals.new_turn.connect(_new_turn)
	GlobalSignals.continue_dialogue.connect(_continue_dialogue)
	GlobalSignals.change_dialogue.connect(_change_dialogue)
	GlobalSignals.exit_dialogue.connect(_exit_dialogue)
	
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
		GlobalSignals.new_turn.emit()
		allowMove = !allowMove
		
func placeDistractor(roughTargetPosition:Vector2):
	var closest_point = Astar.get_closest_point(roughTargetPosition)
	var current_point = Astar.get_closest_point(global_position)
	
	if Astar.are_points_connected(closest_point,current_point):
		#check if mouse input is actually close to point
		var closest_point_position = Astar.get_point_position(closest_point)
		var maxDistance = 10; #in pixels
		if roughTargetPosition.distance_to(closest_point_position) > maxDistance:
			return
		
		var newDistractor:Node2D = distractor.instantiate()
		newDistractor.global_position = closest_point_position
		get_tree().current_scene.add_child(newDistractor)
		GlobalSignals.player_choosing_move.emit("Distractor Placed")
		
		placingDistractor=false
		ActionsMenu.visible = true;
	else:
		GlobalSignals.player_choosing_move.emit("Can only place in adjacent nodes")

func _physics_process(_delta):
	
	if Input.is_action_just_pressed("leftclick") and allowMove:
		click_position = get_global_mouse_position()
		movePlayer(click_position)
		
	if Input.is_action_just_pressed("leftclick") and placingDistractor:
		click_position = get_global_mouse_position()
		placeDistractor(click_position)
		
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
	if whatsInThisNode.is_in_group("talkable_npc"):
		dialogueText = whatsInThisNode.dialogueResourceRef.dialogueText;
		dialogueLabel = whatsInThisNode.dialogueResourceRef.dialogueLabel;
		TalkButton.visible = true
	elif whatsInThisNode.is_in_group("enemy"):
		GlobalSignals.level_repeat.emit()
	elif whatsInThisNode.is_in_group("object"):
		dialogueText = whatsInThisNode.dialogueResourceRef.dialogueText;
		dialogueLabel = whatsInThisNode.dialogueResourceRef.dialogueLabel;
		TalkButton.text = "INTERACT"
		TalkButton.visible = true
		
func _on_area_2d_area_exited(area):
	var whatsInThisNode = area.get_parent()
	if whatsInThisNode.is_in_group("npc"):
		TalkButton.visible = false # Replace with function body.	
	
func _on_talk_button_button_down():
	ActionsMenu.visible = false;
	GlobalSignals.open_dialogue.emit(dialogueText[dialogueKey][dialogueIndex],dialogueLabel)

func _on_move_button_button_down():
	ActionsMenu.visible = false;
	GlobalSignals.player_choosing_move.emit("Click where you want to move.")
	allowMove = !allowMove # This is from the move button
	
func _on_wait_button_button_down():
	GlobalSignals.new_turn.emit()
	
func _new_turn():
	ActionsMenu.visible = true;

func _continue_dialogue():
	dialogueIndex+=1
	if dialogueIndex < dialogueText[dialogueKey].size():
		
		#this code is for the dialogue choices
		var text = dialogueText[dialogueKey][dialogueIndex]
		if text is Dictionary:
			GlobalSignals.choose_dialogue_response.emit(text)
			return
			
		GlobalSignals.open_dialogue.emit(text,dialogueLabel)
	else:
		dialogueIndex = 0
		GlobalSignals.exit_dialogue.emit()

func _change_dialogue(key):
	dialogueKey = key
	dialogueIndex = 0
	
	var text = dialogueText[dialogueKey][dialogueIndex]
	GlobalSignals.open_dialogue.emit(text,dialogueLabel)
	
func _exit_dialogue():
	dialogueKey = "1st"
	dialogueIndex = 0
	ActionsMenu.visible = true
	

#for the 3 items
func _on_distractor_button_button_up():
	items_left[0] -= 1
	
	ActionsMenu.visible = false;
	placingDistractor = true
	GlobalSignals.player_choosing_move.emit("Click where to place distractor.")
	
func _on_teleporter_button_button_up():
	if teleporterPointer:
		global_position = teleporterPointer.global_position
		target_position = teleporterPointer.global_position
		teleporterPointer.queue_free()
		GlobalSignals.player_choosing_move.emit("Teleporter Used")
		
		TeleporterButtonContainer.visible = false
	else:
		items_left[1] -= 1
		teleporterPointer = teleporter.instantiate()
		teleporterPointer.global_position = global_position
		get_tree().current_scene.add_child(teleporterPointer)
		GlobalSignals.player_choosing_move.emit("Teleporter Placed")

func _on_invis_button_button_up():
	items_left[2] -= 1
	GlobalSignals.player_choosing_move.emit("Invisible for next turn")
