extends Node

var levelSceneRef:Dictionary = {
	1:"res://Scenes/Level1.tscn",
	2:"",
	3:"",
	4:"",
	5:"",
}

var cutSceneIndex:int;
var cutSceneRenderer = "res://Scenes/cut_scene_renderer.tscn"

func _ready():
	GlobalSignals.level_repeat.connect(_level_repeat)
	GlobalSignals.level_complete.connect(_level_complete)
	GlobalSignals.level_load.connect(_level_load)
	GlobalSignals.level_select.connect(_level_select)
	
func _level_repeat():
	get_tree().reload_current_scene()

func _level_complete():
	pass

func _level_select(levelNum:int):
	cutSceneIndex = levelNum
	get_tree().change_scene_to_file(cutSceneRenderer)

func _level_load(levelNum:int):
	get_tree().change_scene_to_file(levelSceneRef[levelNum])
