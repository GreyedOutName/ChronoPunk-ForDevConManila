extends VBoxContainer

@export var levelIndex:int;
@export var scoreLabel:Label;

func _ready():
	if LevelController.levelScore[levelIndex] == null:
		visible = false;
	
func _process(delta):
	scoreLabel.text = "Score: "+str(LevelController.levelScore[levelIndex])
	
func _on_select_button_down():
	GlobalSignals.level_select.emit(levelIndex)
