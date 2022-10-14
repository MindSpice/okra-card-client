extends Node

class_name PawnLoadout

var pawn_card : Card
var weapon_card : Card
var action_deck : Array = []
var ability_deck : Array = []


func is_valid() -> bool:
	if pawn_card == null or weapon_card == null:
		return false
		
	if action_deck.size() > Game.ACTION_MAX or action_deck.size() < Game.ACTION_MIN:
		return false
		
	if ability_deck.size() > Game.ABILITY_MAX or ability_deck.size() < Game.ABILITY_MIN:
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
	var act_deck_names : Array
	var abl_deck_names : Array
	
	for card in action_deck:
		act_deck_names.append(card.card_name)
		
	for card in ability_deck:
		abl_deck_names.append(card.card_name)
		
	return {
		"pawn_card" : pawn_card.card_name,
		"weapon_card" : weapon_card.card_name,
		"action_deck" : act_deck_names,
		"ability_deck" : abl_deck_names
	} 

func clean_up() -> void:
	pawn_card.queue_free()
	weapon_card.queue_free()
	Util.free_array(action_deck)
	Util.free_array(ability_deck)
	

