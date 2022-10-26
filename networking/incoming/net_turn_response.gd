extends Reference

class_name NetTurnResponse

var is_player : bool
var player_pawn : int
var target_pawn : int
var action_flags : Array
var animation : String

func _init(msg : Dictionary) :
	is_player = msg.get("is_player")
	player_pawn = Network.conv_pawn_in(msg.get("player_pawn"))
	target_pawn = Network.conv_pawn_in(msg.get("target_pawn"))
	action_flags = msg.get("action_flags")
	animation = msg.get("animation")