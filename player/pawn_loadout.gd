extends Node

class_name PawnLoadout

# These can't be set directly hence the getters/setters
# As the set objects will become null if not duplicated 
# If their referrened objects get GCd
var _pawn_card : Card
var _weapon_card : Card
var _action_deck : Array
var _ability_deck : Array


func is_valid() -> bool:
	if _pawn_card == null or _weapon_card == null:
		return false
		
	if _action_deck.size() > Game.ABILITY_MAX or _action_deck.size() < Game.ABILITY_MIN:
		return false
		
	if _ability_deck.size() > Game.ABILITY_MAX or _ability_deck.size() < Game.ABILITY_MIN:
		return false
		
	return true


# Only need setters, but using getters to in an attempt to enforce a contract
func get_pawn_card() -> Card:
	return _pawn_card


func set_pawn_card(card : Card):
	_pawn_card = card.duplicate()


func get_weapon_card() -> Card:
	return _weapon_card


func set_weapon_card(card : Card):
	_weapon_card = card.duplicate()


func get_action_deck() -> Array:
	return _action_deck


func set_action_deck(deck : Array):
	_action_deck = deck.duplicate(false)


func get_ability_deck() -> Array:
	return _ability_deck


func set_ability_deck(deck : Array):
	_ability_deck = deck.duplicate(true)
