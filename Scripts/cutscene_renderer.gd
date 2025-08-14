extends Node2D

@export var dialogueFile:cutscene_text;
@export var TextLabel:RichTextLabel;
@export var levelIndex:int;

var currentIndexInText = 0;

var cutsceneTextRef:Dictionary[int,NodePath]={
	1:"res://Resources/level1_cutscene.tres",
	2:"res://Resources/cutscene_texts/level2_cutscene_text.tres",
	3:"res://Resources/cutscene_texts/level3_cutscene_text.tres",
	4:"res://Resources/cutscene_texts/level4_cutscene_text.tres",
	5:"res://Resources/cutscene_texts/ending_cutscene_text.tres",
}

func _ready():
	levelIndex = LevelController.cutSceneIndex
	dialogueFile = load(cutsceneTextRef[LevelController.cutSceneIndex])
	
	TextLabel.text = dialogueFile.cutscene_text[0]
	
func _level_load():
	GlobalSignals.level_load.emit(levelIndex)

func _on_invisible_button_button_down():
	currentIndexInText += 1
	MusicPlayer.play_sound("computer_dialogue")
	
	if currentIndexInText < dialogueFile.cutscene_text.size():		
		TextLabel.text = dialogueFile.cutscene_text[currentIndexInText]
	else:
		if levelIndex == 5:
			get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
			return
		_level_load()
