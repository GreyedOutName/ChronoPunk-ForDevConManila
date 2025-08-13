extends Node2D

@export var completionArea:Area2D
var isObjectiveCompleted:bool = false;

func _ready():
	GlobalSignals.main_objective_completed.connect(_main_objective_completed)

func _on_area_2d_area_entered(area):
	var who = area.get_parent()
	if who.is_in_group("player") and isObjectiveCompleted:
		GlobalSignals.level_complete.emit()
		
func _main_objective_completed():
	isObjectiveCompleted = true;
