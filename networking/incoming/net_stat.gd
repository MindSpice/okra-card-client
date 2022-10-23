extends Reference

class_name NetStat

var is_player : bool
var pawn_1 : Dictionary
var pawn_2 : Dictionary
var pawn_3 : Dictionary

func _init(msg : Dictionary) :
	is_player = msg.get("is_player")
	pawn_1 = msg.get("pawn_1") if msg.get("pawn_1") != null else {}
	pawn_2 = msg.get("pawn_2") if msg.get("pawn_2") != null else {}
	pawn_3 = msg.get("pawn_3") if msg.get("pawn_3") != null else {}
 
# TODO either store as a dict or create function to return one
