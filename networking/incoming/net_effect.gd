extends Reference

class_name NetEffect

var pawn_1 : Array
var pawn_2  : Array
var pawn_3 : Array

func _init(msg : Dictionary):
	pawn_1 = msg.get("pawn_1") if msg.get("pawn_1") != null else []
	pawn_2 = msg.get("pawn_2") if msg.get("pawn_2") != null else []
	pawn_3 = msg.get("pawn_3") if msg.get("pawn_3") != null else []


