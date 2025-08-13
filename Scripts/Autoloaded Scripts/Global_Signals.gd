extends Node

signal new_turn()
signal player_choosing_move(Text:String)

signal open_dialogue(dialogueText:String, characterName:String)
signal continue_dialogue()
signal choose_dialogue_response(choices:Dictionary)
signal exit_dialogue()
signal change_dialogue(dialogueKey:String)

signal objective_completed(levelIndex:String,objectiveIndex:int,score:int)
signal main_objective_completed()

signal level_repeat()
signal level_complete(levelnum:int)
signal level_select(levelnum:int)
signal level_load(levelnum:int)
