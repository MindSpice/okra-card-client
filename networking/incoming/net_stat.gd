extends Reference

class_name NetStat

var is_player : bool
var pawn_1 : Dictionary
var pawn_2 : Dictionary
var pawn_3 : Dictionary

func _init(msg : Dictionary) :
	is_player = msg.get("is_player")
	
	if msg.get("pawn_1") != null:
		pawn_1 = Network.conv_stat_dict(msg.get("pawn_1"))

	if msg.get("pawn_2") != null:
		pawn_2 = Network.conv_stat_dict(msg.get("pawn_2"))

	if msg.get("pawn_2") != null:
		pawn_3 = Network.conv_stat_dict(msg.get("pawn_3"))

 
# TODO either store as a dict or create function to return one
