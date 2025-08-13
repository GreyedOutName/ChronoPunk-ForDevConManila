extends Node

signal new_turn()
signal player_choosing_move()

signal open_dialogue(dialogueText:String, characterName:String)
signal continue_dialogue()
signal choose_dialogue_response(choices:Dictionary)
signal exit_dialogue()
signal change_dialogue(dialogueKey:String)

signal objective_completed(index:int,score:int)

signal level_repeat()
signal level_complete(levelnum:int)
signal level_select(levelnum:int)
signal level_load(levelnum:int)
