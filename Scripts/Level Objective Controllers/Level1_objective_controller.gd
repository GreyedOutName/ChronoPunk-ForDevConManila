extends Node

@export var thePlayer:Player

var notTalkedToJaredYet = true;
var notUsedComputerYet = true;

func _ready():
	GlobalSignals.new_turn.connect(_new_turn)
	GlobalSignals.open_dialogue.connect(_check_who)
	GlobalSignals.level_complete.connect(_level_complete)
	
func _new_turn():
	var v_distractor = thePlayer.items_left[0]
	var v_teleporter = thePlayer.items_left[1]
	var v_invisibility = thePlayer.items_left[2]
	
	if v_distractor<2:
		GlobalSignals.objective_completed.emit("Level1",3,100)
	if v_teleporter<1:
		GlobalSignals.objective_completed.emit("Level1",4,100)
	if v_invisibility<1:
		GlobalSignals.objective_completed.emit("Level1",5,100)

func _check_who(dialogueText:String, characterName:String):
	if characterName == "Jared" and notTalkedToJaredYet:
		GlobalSignals.objective_completed.emit("Level1",2,100)
		notTalkedToJaredYet = false
	elif characterName == "Computer" and notUsedComputerYet:
		notUsedComputerYet = false;
		GlobalSignals.objective_completed.emit("Level1",0,100)
		GlobalSignals.main_objective_completed.emit()
		
func _level_complete():
	GlobalSignals.objective_completed.emit("Level1",1,100)
