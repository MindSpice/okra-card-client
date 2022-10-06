extends Node
onready var  action_all_grid : Node = get_node("View/AllView/Action/ScrollContainer/CardGrid")
onready var  ability_all_grid : Node = get_node("View/AllView/Ability/ScrollContainer/CardGrid")
onready var  power_all_grid : Node = get_node("View/AllView/Power/ScrollContainer/CardGrid")
onready var  action_deck_grid : Node = get_node("View/DeckView/Action/ScrollContainer/CardGrid")
onready var  ability_deck_grid : Node = get_node("View/DeckView/Ability/ScrollContainer/CardGrid")
onready var  power_deck_grid : Node = get_node("View/DeckView/Power/ScrollContainer/CardGrid")


# Treat as immutable
var action_cards_all : Array
var ability_cards_all : Array
var power_cards_all : Array

#var action_nodes_all : Array
#var ability_nodes_all : Array
#var power_nodes_all : Array

# Holds the deck being built or focued on
var action_deck_focus : Array
var ability_deck_focus : Array
var power_deck_focus : Array




func _ready():
	action_cards_all = CardBase.instance_card_list(Game.Domain.ACTION, Player.action_cards_all)
	ability_cards_all = CardBase.instance_card_list(Game.Domain.ABILITY, Player.ability_cards_all)
	power_cards_all = CardBase.instance_card_list(Game.Domain.POWER, Player.power_cards_all)
#
	for card in action_cards_all:
		action_all_grid.add_child(card)
		
	for card in ability_cards_all:
		ability_all_grid.add_child(card)
	
	for card in power_cards_all:
		power_all_grid.add_child(card)
		



# TODO add label and updating for deck limits
# Also add a save check for it

# remember to add back cards to all when saving or swaping from a deck


func add_to_action(card : Card):
	if action_deck_grid.get_child_count() >= Game.ACTION_MAX:
		#TODO dialog
		return
	#var card = 
	action_deck_grid.add_child(card.duplicate(), false)
	
	
func add_to_ability(card : Card):
	if ability_deck_grid.get_child_count() >= Game.ABILITY_MAX:
		#TODO dialog
		return
	ability_deck_grid.add_child(card.duplicate(),false)
	
	
func add_to_power(card : Card):
	if power_deck_grid.get_child_count() >= Game.POWER_MAX:
		#TODO dialog
		return
	power_deck_grid.add_child(card.duplicate(),false)


func get_action_deck() -> Array:
	var count : int = action_deck_grid.get_child_count()
	var deck_list : Array
	
	if count < Game.ACTION_MIN:
		# TODO dialog for not enough
		return deck_list
	if count > Game.ACTION_MAX:
		#TODO dialog for too many
		return deck_list
	
	for card in action_deck_grid.get_children():
		deck_list.append(card.card_name)
		
	return deck_list
	
	
func get_ability_deck() -> Array:
	var count : int = ability_deck_grid.get_child_count()
	var deck_list : Array
	
	if count < Game.ABILITY_MIN:
		# TODO dialog for not enough
		return deck_list
	if count > Game.ABILITY_MAX:
		#TODO dialog for too many
		return deck_list
		pass
	
	for card in ability_deck_grid.get_children():
		deck_list.append(card.card_name)
		
	return deck_list
	
	
func get_power_deck() -> Array:
	var count : int = power_deck_grid.get_child_count()
	var deck_list : Array
	
	if count < Game.POWER_MIN:
		return deck_list
		# TODO dialog for not enough
		pass
	if count > Game.POWER_MAX:
		return deck_list
		#TODO dialog for too many
		pass
	
	for card in power_deck_grid.get_children():
		deck_list.append(card.card_name)
		
	return deck_list
	
	
func get_cards_by_domain(domain : int) -> Array:
	match (domain):
		Game.Domain.ACTION:
			return action_cards_all
		Game.Domain.ABILITY:
			return ability_cards_all
		Game.Domain.POWER:
			return power_cards_all
	return []
	
	
func get_grid_by_domain(domain : int) -> Node:
		match (domain):
			Game.Domain.ACTION:
				return action_all_grid
			Game.Domain.ABILITY:
				return ability_all_grid
			Game.Domain.POWER:
				return power_all_grid
		return null
		
	
func update_filtered_view(domain : int, typei : int, level : int):
	var cards = get_cards_by_domain(domain)
	var grid = get_grid_by_domain(domain)
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
		

func _on_Action_Level_Select(index):
	update_filtered_view(
		Game.Domain.ACTION,
		$"View/AllView/Action/Top/TypeCombo".get_selected_id(),
		index)


func _on_Ability_Level_Select(index):
		update_filtered_view(
		Game.Domain.ABILITY,
		0,
		index)


func _on_Power_Level_Select(index):
	update_filtered_view(
		Game.Domain.POWER,
		0,
		index)
