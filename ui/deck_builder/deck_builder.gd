extends Node

class_name DeckBuilder

onready var  action_all_grid : Node = get_node("View/AllView/Action/ScrollContainer/CardGrid")
onready var  ability_all_grid : Node = get_node("View/AllView/Ability/ScrollContainer/CardGrid")
onready var  power_all_grid : Node = get_node("View/AllView/Power/ScrollContainer/CardGrid")
onready var  action_deck_grid : Node = get_node("View/DeckView/Action/ScrollContainer/CardGrid")
onready var  ability_deck_grid : Node = get_node("View/DeckView/Ability/ScrollContainer/CardGrid")
onready var  power_deck_grid : Node = get_node("View/DeckView/Power/ScrollContainer/CardGrid")

# All card instances (that player owns)
var action_cards_all : Array
var ability_cards_all : Array
var power_cards_all : Array

# Deck level
var action_deck_lvl : int = 0
var ability_deck_lvl : int = 0
var power_deck_lvl : int = 0


func _ready():
	action_cards_all = CardBase.instance_card_list(Game.Domain.ACTION, Player.action_cards_all)
	ability_cards_all = CardBase.instance_card_list(Game.Domain.ABILITY, Player.ability_cards_all)
	power_cards_all = CardBase.instance_card_list(Game.Domain.POWER, Player.power_cards_all)
	
	for card in action_cards_all:
		action_all_grid.add_child(card)
		card.connect("context_selected", self, "update_deck")
		
	for card in ability_cards_all:
		ability_all_grid.add_child(card)
		card.connect("context_selected", self, "update_deck")
		
	for card in power_cards_all:
		power_all_grid.add_child(card)
		card.connect("context_selected", self, "update_deck")
		
	update_all_count(Game.Domain.ACTION)
	update_all_count(Game.Domain.ABILITY)
	update_all_count(Game.Domain.POWER)
		
	

	

# TODO add label and updating for deck limits
# Also add a save check for it

# remember to add back cards to all when saving or swaping from a deck


# TODO this can be set to use domain

func get_cards_by_domain(domain : int) -> Array:
	match (domain):
		Game.Domain.ACTION:
			return action_cards_all
		Game.Domain.ABILITY:
			return ability_cards_all
		Game.Domain.POWER:
			return power_cards_all
	return []
	
func get_deck_grid_by_domain(domain : int) -> Node:
		match (domain):
			Game.Domain.ACTION:
				return action_deck_grid
			Game.Domain.ABILITY:
				return ability_deck_grid
			Game.Domain.POWER:
				return power_deck_grid
		return null
	
	
func get_all_grid_by_domain(domain : int) -> Node:
		match (domain):
			Game.Domain.ACTION:
				return action_all_grid
			Game.Domain.ABILITY:
				return ability_all_grid
			Game.Domain.POWER:
				return power_all_grid
		return null
		
		
func get_built_deck(domain : int) -> Array:
	var deck : Array
	
	for card in get_deck_grid_by_domain(domain).get_children():
		deck.append(card)
	return deck
	
	
func get_deck_lvl(domain : int) -> int:
	match(domain):
		Game.Domain.ACTION: return action_deck_lvl
		Game.Domain.ABILITY: return ability_deck_lvl
		Game.Domain.POWER: return power_deck_lvl
	return 0
	
	
func set_deck_level(domain: int, value : int):
	match(domain):
		Game.Domain.ACTION: action_deck_lvl += value
		Game.Domain.ABILITY: ability_deck_lvl += value
		Game.Domain.POWER: power_deck_lvl  += value
	
	
func add_to_deck(domain : int, card : Card):
	var all_grid = get_all_grid_by_domain(domain)
	var deck_grid = get_deck_grid_by_domain(domain)
	var maxv = Game.get_deck_contraints(domain).y
	var limit = Game.get_deck_limit(domain, deck_grid.get_child_count() + 1)
	var existing : Card = deck_grid.get_child(0)
	if (existing != null):
		print(existing.domain)
	
	if domain == Game.Domain.ACTION and existing != null and card.domain != existing.domain:
		#Throw Dialog
		print("domain mismatch")
		return
	if (deck_grid.get_child_count() >= maxv) or (get_deck_lvl(domain) + card.card_level > limit):
		#Throw dialog
		print("max count/limit mismatch", "MAX:",maxv," COUNT", deck_grid.get_child_count())
		return
		
	all_grid.remove_child(card)
	deck_grid.add_child(card)
	set_deck_level(domain, card.card_level)
	card.is_in_deck = true
	update_all_count(domain)
	
func remove_from_deck(domain: int, card : Card):
	var all_grid = get_all_grid_by_domain(domain)
	var deck_grid = get_deck_grid_by_domain(domain)
	
	deck_grid.remove_child(card)
	all_grid.add_child(card)
	set_deck_level(domain, -card.card_level)
	card.is_in_deck = false
	update_all_count(domain)
	
	match (domain):
		Game.Domain.ACTION:
			update_filtered_view(
				domain,
				$"View/AllView/Action/Top/TypeCombo".get_selected_id(), 
				$"View/AllView/Action/Top/LevelCombo".get_selected_id())
		Game.Domain.ABILITY:
			update_filtered_view(
				domain,
				0, 
				$"View/AllView/Ability/Top/LevelCombo".get_selected_id())
		Game.Domain.Power:
			update_filtered_view(
				domain,
				0, 
				$"View/AllView/Power/Top/LevelCombo".get_selected_id())



func update_deck(card : Card, id : int):
	match (id):
		0: add_to_deck(card.domain, card)
		1: remove_from_deck(card.domain, card)
		2: 
			pass
	
	var minv : int  = Game.get_deck_contraints(card.domain).x
	var maxv : int  = Game.get_deck_contraints(card.domain).y
	
		
	
func update_filtered_view(domain : int, typei : int, level : int):
	var cards = get_cards_by_domain(domain)
	var grid = get_all_grid_by_domain(domain)
	Util.remove_children(grid)
	
	var type : String
	match (typei):
		0: type = ""
		1: type = "MELEE"
		2: type = "RANGED"
		3: type = "MAGIC"
		
	for card in cards:
		if (type != "") and (card.card_type != type):
			continue
		if (level != 0) and (card.card_level != level):
			continue
		grid.add_child(card)
		
	
func _on_Action_Type_Select(index):
	update_filtered_view(
		Game.Domain.ACTION, 
		index, 
		$"View/AllView/Action/Top/LevelCombo".get_selected_id())
	update_all_count(Game.Domain.ACTION)
	 
		
func _on_Action_Level_Select(index):
	update_filtered_view(
		Game.Domain.ACTION,
		$"View/AllView/Action/Top/TypeCombo".get_selected_id(),
		index)
	update_all_count(Game.Domain.ACTION)


func _on_Ability_Level_Select(index):
	update_filtered_view(
		Game.Domain.ABILITY,
		0,
		index)
	update_all_count(Game.Domain.ABILITYT)


func _on_Power_Level_Select(index):
	update_filtered_view(
		Game.Domain.POWER,
		0,
		index)
	update_all_count(Game.Domain.POWER)



func update_all_count(domain : int):
	match(domain):
		Game.Domain.ACTION : 
			$View/AllView/Action/Top/CardTotal.text = "Cards:" + str(action_all_grid.get_child_count())
		Game.Domain.ABILITY:
			$View/AllView/Ability/Top/CardTotal.text = "Cards:" + str(ability_all_grid.get_child_count())
		Game.Domain.POWER:
			$View/AllView/Power/Top/CardTotal.text = "Cards:" +  str(ability_all_grid.get_child_count())
			
	
			
