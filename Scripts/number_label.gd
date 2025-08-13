extends Label

@export var Player:Player
@export var MyItemIndex:int

func _process(delta):
	var changeNum = Player.items_left[MyItemIndex]
	text = str(changeNum)
	
	if text =="0" and MyItemIndex != 1:
		get_parent().modulate = Color(0.3, 0.3, 0.3, 1)
		get_parent().modulate.a = 0.8 #change opacity of parent
		modulate = Color(1,0,0)
	elif text =="0" and MyItemIndex == 1:
		visible = false;
	else:
		get_parent().visible = true
		modulate = Color(1,1,1)
