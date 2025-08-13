extends Node

var score:int = 0;#code that resets this is in Level_Controller

func _ready():
	GlobalSignals.objective_completed.connect(_objective_completed)
	
func _objective_completed(index,addscore):
	score += addscore

var levelObjectives:Dictionary = {
	"Level1":[
		" - Move Once",
		" - Talk Once",
		" - Reach Point 4"
	],
	"Level2":[],
	"Level3":[],
	"Level4":[],
	"Level5":[],
}
