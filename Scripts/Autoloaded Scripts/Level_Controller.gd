extends Node

var levelSceneRef:Dictionary = {
	1:"res://Scenes/Level1.tscn",
	2:"",
	3:"",
	4:"",
	5:"",
}

var levelScore:Dictionary = {
	1:0,
	2:null,
	3:null,
	4:null,
	5:null,
}

var levelTurnLimit:Dictionary = {
	1:10,
	2:10,
	3:10,
	4:10,
	5:10,
}

var cutSceneIndex:int;
var cutSceneRenderer = "res://Scenes/cut_scene_renderer.tscn"
var levelSelect = "res://Scenes/level_select.tscn"

func _ready():
	GlobalSignals.level_repeat.connect(_level_repeat)
	GlobalSignals.level_complete.connect(_level_complete)
	GlobalSignals.level_load.connect(_level_load)
	GlobalSignals.level_select.connect(_level_select)
	
	var loadFile = SaveManager.load_game_data()
	if typeof(loadFile) == TYPE_DICTIONARY and not loadFile.is_empty():
		levelScore = loadFile
	
func _level_repeat():
	get_tree().reload_current_scene()

func _level_complete(levelNum:int):
	var scoreObtained = Objectives.score
	
	levelScore[levelNum] = scoreObtained
	Objectives.score = 0; #resets score counter
	
	#code that unlocks the next level for level select
	if (levelNum+1)<6:
		levelScore[levelNum+1] = 0; #turns score from null into 0, making it "unlocked"
		
	SaveManager.save_game_data(levelScore)
	get_tree().change_scene_to_file(levelSelect)
	
func _level_select(levelNum:int):
	cutSceneIndex = levelNum
	get_tree().change_scene_to_file(cutSceneRenderer)

func _level_load(levelNum:int):
	get_tree().change_scene_to_file(levelSceneRef[levelNum])
