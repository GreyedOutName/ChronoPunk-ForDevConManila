extends CanvasLayer

@export var turnIndicator:Label;
@export var dialogueBox:MarginContainer;
@export var dialogueText:Label;
@export var dialogueLabel:Label;
@export var reminderText:Label;

func _ready():
	GlobalSignals.open_dialogue.connect(_open_dialogue)
	GlobalSignals.player_choosing_move.connect(_player_choosing_move)
	GlobalSignals.new_turn.connect(_new_turn)
	turnIndicator.text = ("Turn: " + str(TurnController.turn_number)) 

func _open_dialogue(Text, Name):
	dialogueText.text = Text
	dialogueLabel.text = Name
	dialogueBox.visible = true;

func _player_choosing_move():
	reminderText.visible = true
	reminderText.text = "Click on the point you want to move to."
	
func _new_turn():
	reminderText.visible = false
	turnIndicator.text = ("Turn: " + str(TurnController.turn_number)) 

func _on_invisible_button_button_up():
	dialogueBox.visible = false;
