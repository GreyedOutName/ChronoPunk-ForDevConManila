extends Node

@export var thePlayer:Player

var notTalkedToBenuweYet = true;
var notUsedPC1Yet = true;
var notUsedPC2Yet = true;

func _ready():
	GlobalSignals.new_turn.connect(_new_turn)
	GlobalSignals.open_dialogue.connect(_check_who)
	GlobalSignals.level_complete.connect(_level_complete)
	
func _new_turn():
	pass

func _check_who(dialogueText:String, characterName:String):
	if characterName == "Benuwe" and notTalkedToBenuweYet:
		GlobalSignals.objective_completed.emit("Level2",2,100)
		notTalkedToBenuweYet = false
	elif characterName == "Computer" and notUsedPC1Yet:
		notUsedPC1Yet = false
		GlobalSignals.objective_completed.emit("Level2",0,100)
		GlobalSignals.main_objective_completed.emit()
	elif characterName == "Computer 2" and notUsedPC2Yet:
		notUsedPC2Yet = false
		GlobalSignals.objective_completed.emit("Level2",3,100)
		
func _level_complete():
	var v_teleporter = thePlayer.items_left[1]
	if v_teleporter==1:
		GlobalSignals.objective_completed.emit("Level2",4,100)
		
	GlobalSignals.objective_completed.emit("Level1",1,100)
