extends Reference

class_name NetGameAction

var data : Dictionary


func _init(action : String, player_pawn : String, target_pawn : String, potion: String) -> void:
	data["action"] = action
	data["player_pawn"] = player_pawn
	data["target_pawn"] = target_pawn
	if (potion != ""):
		data["potion"] = potion
	
	

