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



