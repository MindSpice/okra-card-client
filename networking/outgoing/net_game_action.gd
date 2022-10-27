extends Reference

class_name NetGameAction

var data : Dictionary


# make potion enum idk
func _init(action : int, player_pawn : int, target_pawn : int, potion: String) -> void:
	data["action"] = Network.conv_player_action_out(action)
	data["player_pawn"] = Network.conv_pawn_out(player_pawn)
	data["target_pawn"] = Network.conv_pawn_out(target_pawn)
	if (potion != ""):
		data["potion"] = potion
	