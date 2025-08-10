extends CanvasLayer

@export var turnIndicator:RichTextLabel;

func _process(delta):
	turnIndicator.text = ("Turn: " + str(TurnController.turn_number)) 
