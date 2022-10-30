extends Reference

class_name NetTurnResponse
var is_player : bool
var player_pawn : int
var affected_pawns_player : Dictionary
var affected_pawns_enemy : Dictionary
var animation : String

func _init(msg : Dictionary) :
	is_player = msg.get("is_player")
	player_pawn = Network.conv_pawn_in(msg.get("player_pawn"))
	affected_pawns_player = Network.conv_turn_reponse(msg.get("affected_pawns_player")) if msg.get("affected_pawns_player") != null else {}
	affected_pawns_enemy = Network.conv_turn_reponse(msg.get("affected_pawns_enemy")) if msg.get("affected_pawns_enemy") != null else {}
	animation = msg.get("animation")
