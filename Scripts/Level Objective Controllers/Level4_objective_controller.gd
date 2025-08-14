extends Node

@export var thePlayer:Player

var notTalkedToLeaderYet = true;

func _ready():
	GlobalSignals.new_turn.connect(_new_turn)
	GlobalSignals.open_dialogue.connect(_check_who)
	GlobalSignals.level_complete.connect(_level_complete)
	
func _new_turn():
	pass

func _check_who(dialogueText:String, characterName:String):
	if characterName == "The Leader" and notTalkedToLeaderYet:
		GlobalSignals.objective_completed.emit("Level4",0,100)
		GlobalSignals.main_objective_completed.emit()
		notTalkedToLeaderYet = false
		
func _level_complete():
	pass
