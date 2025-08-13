extends Node2D

var turn_number = 1;
var current_level:int = 1;

func _ready():
	GlobalSignals.new_turn.connect(_new_turn)
	GlobalSignals.level_load.connect(_level_load)
	GlobalSignals.level_repeat.connect(_reset_counter)
	GlobalSignals.level_complete.connect(_reset_counter)

func _process(delta):
	if turn_number > LevelController.levelTurnLimit[current_level]:
		GlobalSignals.level_repeat.emit()

func _new_turn():
	TurnController.turn_number += 1
	
func _reset_counter():
	turn_number = 1;

func _level_load(levelNum:int):
	current_level = levelNum
