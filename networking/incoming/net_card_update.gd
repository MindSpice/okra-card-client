extends Reference

class_name NetCardUpdate

var pawn_1 : Dictionary
var pawn_2 : Dictionary
var pawn_3 : Dictionary

func _init(msg : Dictionary):
    pawn_1 = Network.conv_card_hand(msg.get("pawn_1")) if msg.get("pawn_1") != null else {}
    pawn_2 = Network.conv_card_hand(msg.get("pawn_2")) if msg.get("pawn_2") != null else {}
    pawn_3 = Network.conv_card_hand(msg.get("pawn_3")) if msg.get("pawn_3") != null else {}
