extends NinePatchRect
class_name ChoiceBox

var textForButton:String
var keyChosen:String
@export var button:Button;

func _ready():
	button.text = textForButton

func _on_choice_button_button_up():
	GlobalSignals.change_dialogue.emit(keyChosen)
