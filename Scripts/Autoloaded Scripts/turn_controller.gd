extends Node2D

var turn_number = 1;

func _ready():
	GlobalSignals.new_turn.connect(_new_turn)

func _new_turn():
	TurnController.turn_number += 1
