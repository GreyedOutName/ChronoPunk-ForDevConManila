extends Node

@export var thePlayer:Player

var notTalkedToAreshaYet = true;
var notUsedComputerYet = true;
var notUsedLockerYet = true;

func _ready():
	GlobalSignals.new_turn.connect(_new_turn)
	GlobalSignals.open_dialogue.connect(_check_who)
	GlobalSignals.level_complete.connect(_level_complete)
	
func _new_turn():
	var v_all_items = thePlayer.items_left
	
	if v_all_items == [0,0,0]:
		GlobalSignals.objective_completed.emit("Level3",2,100)

func _check_who(dialogueText:String, characterName:String):
	if characterName == "Aresha" and notTalkedToAreshaYet:
		GlobalSignals.objective_completed.emit("Level3",3,100)
		notTalkedToAreshaYet = false
	elif characterName == "Computer" and notUsedComputerYet:
		notUsedComputerYet = false;
		GlobalSignals.objective_completed.emit("Level3",0,100)
		GlobalSignals.main_objective_completed.emit()
	elif characterName == "Locker" and notUsedLockerYet:
		GlobalSignals.objective_completed.emit("Level3",4,100)
		
func _level_complete():
	GlobalSignals.objective_completed.emit("Level3",1,100)
