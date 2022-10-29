extends Reference

class_name NetCardUpdate

var is_player : bool
var pawn_cards : Dictionary

func _init(msg : Dictionary):
    is_player = msg.get("is_player")

    if msg.get("pawn_1") != null:
        pawn_cards[Game.Pawn.PAWN1] = Network.conv_card_hand(msg.get("pawn_1"))
    if msg.get("pawn_2") != null:
        pawn_cards[Game.Pawn.PAWN2] = Network.conv_card_hand(msg.get("pawn_2"))
    if msg.get("pawn_3") != null:
        pawn_cards[Game.Pawn.PAWN3] = Network.conv_card_hand(msg.get("pawn_3"))