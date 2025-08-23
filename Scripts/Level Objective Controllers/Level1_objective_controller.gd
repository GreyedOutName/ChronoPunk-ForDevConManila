extends Node

@export var thePlayer:Player

var notTalkedToJaredYet = true;
var notUsedComputerYet = true;
var notUsedDistractorYet = true;
var notUsedTeleporterYet = true;
var notUsedInvisibilityYet = true;

func _ready():
	GlobalSignals.new_turn.connect(_new_turn)
	GlobalSignals.open_dialogue.connect(_check_who)
	GlobalSignals.level_complete.connect(_level_complete)
	
func _new_turn():
	var v_distractor = thePlayer.items_left[0]
	var v_teleporter = thePlayer.items_left[1]
	var v_invisibility = thePlayer.items_left[2]
	
	if v_distractor<2 and notUsedDistractorYet:
		GlobalSignals.objective_completed.emit("Level1",3,100)
		notUsedDistractorYet = false;
	if v_teleporter<1 and notUsedTeleporterYet:
		GlobalSignals.objective_completed.emit("Level1",4,100)
		notUsedTeleporterYet = false;
	if v_invisibility<1 and notUsedInvisibilityYet:
		GlobalSignals.objective_completed.emit("Level1",5,100)
		notUsedInvisibilityYet = false;

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
