extends Node2D

@export var num_indicator:Label

func _ready():
	num_indicator.text = self.name
