extends Node

var score:int = 0;#code that resets this is in Level_Controller

func _ready():
	GlobalSignals.objective_completed.connect(_objective_completed)
	
func _objective_completed(levelIndex,objectiveIndex,addscore):
	score += addscore

var levelObjectives:Dictionary = {
	"Level1":[
		" - Main Goal: Destroy the Files",
		" - Leave the area undetected",
		" - Talk to Jared",
		" - Use The Distractor (Item 1)",
		" - Use The Teleporter (Item 2)",
		" - Use The Invisibility Cloak (Item 3)",
	],
	"Level2":[
		" - Main Goal: Delete the Files",
		" - Leave the area undetected",
		" - Talk to Benuwe",
		" - Obtain additional info",
		" - Do not use the teleporter",
	],
	"Level3":[
		" - Main Goal: Delete the Files, Again",
		" - Leave the area undetected",
		" - Use up all your equipment",
		" - Talk to Aresha",
		" - Open the locker",
	],
	"Level4":[
		" - Talk with the leader."
	],
}
