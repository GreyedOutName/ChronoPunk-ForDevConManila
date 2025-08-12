extends Label

@export var Player:Player
@export var MyItemIndex:int

func _process(delta):
	if text =="0":
		get_parent().visible = false
	else:
		get_parent().visible = true
		modulate = Color(1,1,1)
		
	var changeNum = Player.items_left[MyItemIndex]
	text = str(changeNum)
