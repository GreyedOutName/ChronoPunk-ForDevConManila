extends CanvasLayer

@export var turnIndicator:Label;
@export var dialogueBox:MarginContainer;
@export var dialogueChoices:MarginContainer;
@export var ChoicesVbox:VBoxContainer;
@export var dialogueText:Label;
@export var dialogueLabel:Label;
@export var reminderText:Label;

var choiceBox = preload("res://Scenes/GUI_Dialogue_Choice.tscn")

func _ready():
	GlobalSignals.player_choosing_move.connect(_player_choosing_move)
	GlobalSignals.new_turn.connect(_new_turn)
	
	GlobalSignals.open_dialogue.connect(_open_dialogue)
	GlobalSignals.exit_dialogue.connect(_exit_dialogue)
	GlobalSignals.choose_dialogue_response.connect(_choose_dialogue)
	GlobalSignals.change_dialogue.connect(_change_dialogue)
	
	turnIndicator.text = ("Turn: " + str(TurnController.turn_number)) 

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
	ChoicesVbox.visible = false;
	dialogueChoices.visible = false;

func _player_choosing_move():
	reminderText.visible = true
	reminderText.text = "Click on the point you want to move to."
	
func _new_turn():
	reminderText.visible = false
	turnIndicator.text = ("Turn: " + str(TurnController.turn_number)) 

func _on_invisible_button_button_up():
	GlobalSignals.continue_dialogue.emit()
