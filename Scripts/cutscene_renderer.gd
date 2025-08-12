extends Node2D

@export var dialogueFile:cutscene_text;
@export var TextLabel:RichTextLabel;
@export var levelIndex:int;

var currentIndexInText = 0;

var cutsceneTextRef:Dictionary[int,NodePath]={
	1:"res://Resources/level1_cutscene.tres",
	2:"",
	3:"",
	4:"",
	5:"",
	6:"",
}

func _ready():
	levelIndex = LevelController.cutSceneIndex
	dialogueFile = load(cutsceneTextRef[LevelController.cutSceneIndex])
	
	TextLabel.text = dialogueFile.cutscene_text[0]
	
func _level_load():
	GlobalSignals.level_load.emit(levelIndex)

func _on_invisible_button_button_down():
	currentIndexInText += 1
	
	if currentIndexInText < dialogueFile.cutscene_text.size():		
		TextLabel.text = dialogueFile.cutscene_text[currentIndexInText]
	else:
		_level_load()
