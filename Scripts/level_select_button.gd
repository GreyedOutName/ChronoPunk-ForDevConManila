extends Button

@export var parentVBox:VBoxContainer;
@export var levelIndex:int;

func _on_button_down():
	GlobalSignals.level_select.emit(levelIndex)
