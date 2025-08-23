extends Node

var levelSceneRef:Dictionary = {
	1:"res://Scenes/Level1.tscn",
	2:"res://Scenes/Level2.tscn",
	3:"res://Scenes/Level3.tscn",
	4:"res://Scenes/Level4.tscn",
}

var levelScore:Dictionary = {
	1:0,
	2:null,
	3:null,
	4:null,
}

var levelTurnLimit:Dictionary = {
	1:14,
	2:20,
	3:22,
	4:20,
}

var cutSceneIndex:int;
var cutSceneRenderer = "res://Scenes/cut_scene_renderer.tscn"
var levelSelect = "res://Scenes/level_select.tscn"

var levelCurrentlyIn:int;

func _ready():
	GlobalSignals.level_repeat.connect(_level_repeat)
	GlobalSignals.level_complete.connect(_level_complete)
	GlobalSignals.level_load.connect(_level_load)
	GlobalSignals.level_select.connect(_level_select)
	
	GlobalSignals.progress_deleted.connect(_progress_deleted)
	
	var loadFile = SaveManager.load_game_data()
	print(loadFile)
	if typeof(loadFile) == TYPE_DICTIONARY and not loadFile.is_empty():
		var fixed = {}
		for key in loadFile.keys():
			fixed[int(key)] = loadFile[key]
		levelScore = fixed
	
func _level_repeat():
	Objectives.score = 0; #resets score counter
	get_tree().reload_current_scene()

func _level_complete():
	var scoreObtained = Objectives.score
	
	levelScore[levelCurrentlyIn] = scoreObtained
	Objectives.score = 0; #resets score counter
	
	#code that unlocks the next level for level select
	if (levelCurrentlyIn+1)<5:
		levelScore[levelCurrentlyIn+1] = 0; #turns score from null into 0, making it "unlocked"
	
	GlobalSignals.player_choosing_move.emit("Level Complete !")
	SaveManager.save_game_data(levelScore)
	await get_tree().create_timer(2.0).timeout
	
	get_tree().change_scene_to_file(levelSelect)
	
func _level_select(levelNum:int):
	cutSceneIndex = levelNum
	get_tree().change_scene_to_file(cutSceneRenderer)

func _level_load(levelNum:int):
	print(levelNum)
	levelCurrentlyIn = levelNum
	get_tree().change_scene_to_file(levelSceneRef[levelNum])
	
func _progress_deleted():
	levelScore = {
	1:0,
	2:null,
	3:null,
	4:null,
}
