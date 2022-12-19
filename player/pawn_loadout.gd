extends Reference

class_name PawnLoadout

var pawn_card : Card
var weapon_card_1 : Card
var weapon_card_2 : Card
var talisman_card : Card
var action_deck : Array = []
var ability_deck : Array = []


func load(loadout : Dictionary):
	pawn_card = CardBase.instance_card(Game.Domain.PAWN, loadout.get("pawn"))
	weapon_card_1 = CardBase.instance_card(Game.Domain.WEAPON, loadout.get("weapon1"))
	weapon_card_2 = CardBase.instance_card(Game.Domain.WEAPON, loadout.get("weapon2"))
	talisman_card = CardBase.instance_card(Game.Domain.WEAPON, loadout.get("talisman"))
	action_deck = CardBase.instance_card_list(Game.Domain.ACTION, loadout.get("actionDeck"))
	ability_deck = CardBase.instance_card_list(Game.Domain.ABILITY, loadout.get("abilityDeck"))

func is_valid() -> bool:
	if pawn_card == null or weapon_card_1 == null or weapon_card_2 == null or talisman_card == null:
		return false
		
	if action_deck.size() > Game.ACTION_MAX or action_deck.size() < Game.ACTION_MIN:
		return false
		
	if ability_deck.size() > Game.ABILITY_MAX or ability_deck.size() < Game.ABILITY_MIN:
		return false

	if  ((pawn_card.card_type != weapon_card_1.card_type) 
		or (weapon_card_1.card_type != weapon_card_2.card_type)):
		return false

	return true
	

func get_deck(domain : int) -> Array:
	if (domain == Game.Domain.ACTION):
		return action_deck
	else:
		return ability_deck
		

func set_deck(domain : int, deck : Array) -> void:
	if (domain == Game.Domain.ACTION):
		action_deck = deck
	else:
		ability_deck = deck


func get_as_dict() -> Dictionary:
	return {
		"pawn" 		: pawn_card.card_name,
		"weapon1" 		: weapon_card_1.card_name,
		"weapon2" 		: weapon_card_2.card_name,
		"actionDeck" 	: CardBase.card_nodes_as_names(action_deck),
		"abilityDeck" 	: CardBase.card_nodes_as_names(ability_deck),
		"talisman" 		: talisman_card.card_name
	} 

func clean_up() -> void:
	if pawn_card != null:
		pawn_card.queue_free()
		
	if weapon_card_1 != null:
		weapon_card_1.queue_free()

	if weapon_card_2 != null:
		weapon_card_2.queue_free()

	if talisman_card != null:
		talisman_card.queue_free()
	
	Util.free_array(action_deck)
	Util.free_array(ability_deck)
	

