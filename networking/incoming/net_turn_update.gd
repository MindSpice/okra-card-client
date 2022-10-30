extends Reference

class_name NetTurnUpdate

var is_player : bool
var pawn_turns : Dictionary


func _init(msg : Dictionary):
	is_player = msg.get("is_player")
	pawn_turns[Game.Pawn.PAWN1] = msg.get("pawn_1")
	pawn_turns[Game.Pawn.PAWN2] = msg.get("pawn_2")
	pawn_turns[Game.Pawn.PAWN3] = msg.get("pawn_3")
	

