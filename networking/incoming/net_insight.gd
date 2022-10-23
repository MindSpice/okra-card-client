extends Reference

class_name NetInsight

var insight_type : int
var pawn_index : int
var stats : Dictionary
var action_cards : Array
var ability_cards : Array
var power_card : String
var effects : Array

func _init(msg : Dictionary) :
	insight_type = Network.insight_type.get(msg.get("insight_type"))
	pawn_index = Network.conv_pawn_in(msg.get("pawn_index"))
	
	if insight_type == Network.InsightType.STAT :
		stats = msg.get("stats")
		
	elif insight_type == Network.InsightType.EFFECT :
		effects == msg.get("effects")
		
	elif insight_type == Network.InsightType.CARD :
		action_cards = msg.get("action_cards")
		ability_cards = msg.get("ability_cards")
		power_card = msg.get("power_card")

