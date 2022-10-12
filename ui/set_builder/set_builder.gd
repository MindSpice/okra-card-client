extends Control

var _action_cards_free : Array
var _ability_cards_free : Array
var _power_cards_free : Array
var _pawn_cards_free : Array
var _weapon_cards_free : Array

var _set_name : String
var _power_deck : Array
var _pawn_loadouts : Array


onready var _deck_builder := preload("res://ui/deck_builder/deck_builder.tscn").instance()
onready var _s_select := preload("res://ui/set_builder/pawn_select.tscn").instance()


func _ready():

	_action_cards_free = CardBase.instance_card_list(Game.Domain.ACTION, Player.action_cards_all)
	_ability_cards_free = CardBase.instance_card_list(Game.Domain.ABILITY, Player.ability_cards_all)
	_power_cards_free = CardBase.instance_card_list(Game.Domain.POWER, Player.power_cards_all)
	_pawn_cards_free = CardBase.instance_card_list(Game.Domain.PAWN, Player.pawn_cards_all)
	_weapon_cards_free = CardBase.instance_card_list(Game.Domain.WEAPON, Player.weapon_cards_all)

	_s_select.connect("_card_relay", self, "_set_single_card_selction")
	$Panel.add_child(_s_select)
	_deck_builder.connect("closed", self, "_on_deck_builder_close")
	
	for i in 3:
		_pawn_loadouts.append(PawnLoadout.new())
		
	for card in _action_cards_free:
		card.connect("context_selected", _deck_builder, "update_deck")
		
	for card in _ability_cards_free:
		card.connect("context_selected", _deck_builder, "update_deck")


func _set_pawn_loadout(pawn_idx : int, pawn_loadout : PawnLoadout):
	match(pawn_idx):
		Game.Pawn.PAWN1:
			_pawn_loadouts[0] = pawn_loadout
		Game.Pawn.PAWN2:
			_pawn_loadouts[1] = pawn_loadout
		Game.Pawn.PAWN3:
			_pawn_loadouts[2] = pawn_loadout


func _get_pawn_loadout(pawn_idx : int) -> PawnLoadout:
	match(pawn_idx):
		Game.Pawn.PAWN1:
			return _pawn_loadouts[0]
		Game.Pawn.PAWN2:
			return _pawn_loadouts[1]
		Game.Pawn.PAWN3:
			return _pawn_loadouts[2]
	push_error("Wrong Pawn Index")
	return null


func _get_card_window(pawn_idx :int, domain : int) -> Node:
	match(pawn_idx):
		Game.Pawn.PAWN1:
			if (domain == Game.Domain.PAWN):
				return $HSplit/VSplit/Pawn1/VBox/HBox2/VBox/PawnCard
			else:
				return $HSplit/VSplit/Pawn1/VBox/HBox2/VBox2/WeaponCard
		Game.Pawn.PAWN2:
			if (domain == Game.Domain.PAWN):
				return $HSplit/VSplit2/Pawn2/VBox/HBox2/VBox/PawnCard
			else:
				return $HSplit/VSplit2/Pawn2/VBox/HBox2/VBox2/WeaponCard
		Game.Pawn.PAWN3:
			if (domain == Game.Domain.PAWN):
				return $HSplit/VSplit/Pawn3/VBox/HBox2/VBox/PawnCard
			else:
				return $HSplit/VSplit/Pawn3/VBox/HBox2/VBox2/WeaponCard
				
	push_error("Wrong Domain")
	return null


func _get_all_by_domain(domain : int) -> Array:
	match (domain):
		Game.Domain.ACTION:
			return _action_cards_free
		Game.Domain.ABILITY:
			return _ability_cards_free
		Game.Domain.POWER:
			return _power_cards_free
		Game.Domain.PAWN:
			return _pawn_cards_free
		Game.Domain.WEAPON:
			return _weapon_cards_free
	
	push_error("Bad Domain Index")
	return []


func _remove_from_free(domain : int, card : Card) -> void:
	if card == null:
		return
	_get_all_by_domain(domain).erase(card)


func _replace_to_free(domain : int, card : Card):
	if card == null:
		return
	_get_all_by_domain(domain).append(card)


func _set_single_card_selction(pawn_idx : int, domain : int, card : Card) -> void:
	if card == null:
		return
		
	if domain == Game.Domain.PAWN:
		_replace_to_free(domain, _get_pawn_loadout(pawn_idx).pawn_card)
		_remove_from_free(domain, card)
		_get_pawn_loadout(pawn_idx).pawn_card = card
		
	elif domain == Game.Domain.WEAPON:
		_replace_to_free(domain, _get_pawn_loadout(pawn_idx).weapon_card)
		_remove_from_free(domain, card)
		_get_pawn_loadout(pawn_idx).weapon_card = card;
		
	else:
		push_error("Wrong Domain")
	
	_get_card_window(pawn_idx, domain).texture = card.get_image()


# These are pass an int that is indexed the same as
# Game.Pawn enum, ex. 0 = PAWN1, and are thus interchangeable 
func _on_SelectPawn_pressed(pawn_idx : int) -> void:
	_s_select.init(pawn_idx, Game.Domain.PAWN, _pawn_cards_free)
	_s_select.pop_up()


func _on_SelectWeapon_pressed(pawn_idx : int) -> void:
	_s_select.init(pawn_idx, Game.Domain.WEAPON, _weapon_cards_free)
	_s_select.pop_up()


func _on_Build_pressed(pawn_idx : int, domain : int) -> void:
	_deck_builder.init(
		pawn_idx, 
		domain, 
		_action_cards_free.duplicate(),
		_pawn_loadouts[pawn_idx].get_deck(domain).duplicate())
	_get_all_by_domain(domain).clear()
	
	$HSplit.hide()
	$Panel.add_child(_deck_builder)


func _on_BuildAbility_pressed(pawn_idx : int) -> void:
	pass


func _on_To_Menu_pressed():
	get_tree().change_scene("res://ui/menu/menu.tscn")


func _on_deck_builder_close(domain : int, free : Array) -> void:
	_get_all_by_domain(domain).append_array(free)
	$Panel.remove_child(_deck_builder)
	$HSplit.show()

# TODO 

# FIx the array swapping




func _on_deck_builder_save(pawn_idx : int, domain : int, deck : Array, free : Array) -> void:
	_pawn_loadouts[pawn_idx].set_deck(domain, deck)
	_get_all_by_domain(domain).append_array(free)
	$Panel.remove_child(_deck_builder)
	$HSplit.show()


func _on_BuildAttack_pressed(extra_arg_0: int, extra_arg_1: int) -> void:
	pass # Replace with function body.
