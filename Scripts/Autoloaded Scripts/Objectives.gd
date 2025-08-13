extends Node

var score:int = 0;#code that resets this is in Level_Controller

func _ready():
	GlobalSignals.objective_completed.connect(_objective_completed)
	
func _objective_completed(levelIndex,objectiveIndex,addscore):
	score += addscore

var levelObjectives:Dictionary = {
	"Level1":[
		" - Destroy the Files",
		" - Reach The End Node",
		" - Talk to Jared",
		" - Use The Distractor (Item 1)",
		" - Use The Teleporter (Item 2)",
		" - Use The Invisibility Cloak (Item 3)",
	],
	"Level2":[],
	"Level3":[],
	"Level4":[],
	"Level5":[],
}
