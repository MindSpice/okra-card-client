extends Reference

class_name NetTurnUpdate

var is_player : bool
var active_pawns : Array


func _init(msg : Dictionary):
	self.is_player = msg.get("is_player")
	self.active_pawns = Network.conv_pawn_arr(msg.get("active_pawns"))

