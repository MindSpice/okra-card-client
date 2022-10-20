extends Reference


var pawn_card : Card
var weapon_card : Card
var stats : Dictionary
var stats_max : Dictionary

# Card hand
var action_card_1 : Card
var action_card_2 : Card
var ability_card : Card
var power_card : Card

var status_effects : Array
var is_dead : bool
var is_active: bool

enum CardSlot {ACTION1, ACTION2, ABILITY, POWER}

func _init(pawn_card : Card, weapon_card: Card, 
	stats : Dictionary, stats_max : Dictionary) -> void:
	pawn_card = pawn_card
	weapon_card = weapon_card
	self.stats = stats
	self.stats_max = stats_max
	is_dead = false
	is_active = true
	
func set_new_cards(card_hand : Dictionary) -> void:
	for card in card_hand.keys():
		if card_hand.get(card) == null:
			continue
		match(card):
			"ACTION_1" : action_card_1 = card_hand.get(card)
			"ACTION_2" : action_card_2 = card_hand.get(card)
			"ABILITY" : ability_card = card_hand.get(card)
			"POWER" : power_card = card_hand.get(card)
			
func set_stats(stat_map : Dictionary) -> void:
	stats = stat_map
	
func set_status_effect(effects : Array) -> void:
	e
	
	

	
	


