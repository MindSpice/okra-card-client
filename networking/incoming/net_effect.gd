extends Reference

class_name NetEffect

var is_player : bool
var pawn_effects : Dictionary

func _init(msg : Dictionary):
	is_player = msg.get("is_player")

	if msg.get("pawn_1") != null:
		pawn_effects[Game.Pawn.PAWN1] = msg.get("pawn_1")
	if msg.get("pawn_2") != null:
		pawn_effects[Game.Pawn.PAWN2] = msg.get("pawn_2")
	if msg.get("pawn_3") != null:
		pawn_effects[Game.Pawn.PAWN3] = msg.get("pawn_3")


