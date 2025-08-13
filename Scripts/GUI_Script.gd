extends CanvasLayer

@export var turnIndicator:Label;
@export var turnLimitLabel:Label;
@export var dialogueBox:MarginContainer;
@export var dialogueChoices:MarginContainer;
@export var ChoicesVbox:VBoxContainer;
@export var dialogueText:Label;
@export var dialogueLabel:Label;
@export var reminderText:Label;
@export var GameObjectives:VBoxContainer;
@export var Score:Label;

var choiceBox = preload("res://Scenes/GUI_Dialogue_Choice.tscn")
var objectiveText = preload("res://Scenes/GUI_ObjectiveText.tscn")

func _ready():
	GlobalSignals.player_choosing_move.connect(_player_choosing_move)
	GlobalSignals.new_turn.connect(_new_turn)
	
	GlobalSignals.open_dialogue.connect(_open_dialogue)
	GlobalSignals.exit_dialogue.connect(_exit_dialogue)
	GlobalSignals.choose_dialogue_response.connect(_choose_dialogue)
	GlobalSignals.change_dialogue.connect(_change_dialogue)
	GlobalSignals.objective_completed.connect(_objective_completed)
	
	turnIndicator.text = ("Turn: " + str(TurnController.turn_number)) 
	
	if get_tree().current_scene.name.contains("Level"):
		for x in Objectives.levelObjectives[get_tree().current_scene.name]:
			var newObjective = objectiveText.instantiate()
			newObjective.text = x
			GameObjectives.add_child(newObjective)

func _process(delta):
	if LevelController.levelCurrentlyIn != 0:
		turnLimitLabel.text = ("Turn Limit: " + str(LevelController.levelTurnLimit[LevelController.levelCurrentlyIn]))
	Score.text = "Score: "+str(Objectives.score)

func _open_dialogue(Text, Name):
	dialogueText.text = Text
	dialogueLabel.text = Name
	dialogueBox.visible = true;

func _exit_dialogue():
	dialogueBox.visible = false;
	
func _choose_dialogue(choices:Dictionary):
	dialogueBox.visible = false;
	
	for x in choices:
		var newChoiceBox:ChoiceBox = choiceBox.instantiate()
		newChoiceBox.textForButton = choices[x]
		newChoiceBox.keyChosen = x
		ChoicesVbox.add_child(newChoiceBox)
	
	dialogueChoices.visible = true;
	
func _change_dialogue(key):
	for x in ChoicesVbox.get_children():
		x.queue_free()
	
	dialogueChoices.visible = false;

func _player_choosing_move(textToDisplay:String):
	reminderText.visible = true
	reminderText.text = textToDisplay
	
func _new_turn():
	reminderText.visible = false
	turnIndicator.text = ("Turn: " + str(TurnController.turn_number)) 
	
func _objective_completed(levelIndex:String,objectiveIndex:int,score:int):
	var arrayOfText:Array[Node] = GameObjectives.get_children()
	var newText = "[color=#FF0000][s]"+arrayOfText[objectiveIndex].text+"[/s][/color]"
	arrayOfText[objectiveIndex].text = newText
	
func _on_invisible_button_button_up():
	GlobalSignals.continue_dialogue.emit()
