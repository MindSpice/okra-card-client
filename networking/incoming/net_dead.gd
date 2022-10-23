extends Reference

class_name NetDead

var is_player: bool
var pawn_index : int

func _init(msg : Dictionary):
	self.is_player = msg.get("is_player")
	self.pawn_index = Network.conv_pawn_in(msg.get("pawn_index"))
