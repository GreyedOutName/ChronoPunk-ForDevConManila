extends VBoxContainer

@export var levelIndex:int;
@export var scoreLabel:Label;

func _ready():
	if LevelController.levelScore[levelIndex] == null:
		visible = false;
	
func _process(delta):
	var score = LevelController.levelScore[levelIndex]
	if score == null:
		scoreLabel.text = "Score: --"
	else:
		scoreLabel.text = "Score: " + str(int(score))
	
func _on_select_button_down():
	GlobalSignals.level_select.emit(levelIndex)
