extends Node
onready var  action_all_grid : Node = get_node("View/AllView/Action/ScrollContainer/CardGrid")
onready var  ability_all_grid : Node = get_node("View/AllView/Ability/ScrollContainer/CardGrid")
onready var  power_all_grid : Node = get_node("View/AllView/Power/ScrollContainer/CardGrid")
onready var  action_deck_grid : Node = get_node("View/DeckView/Action/ScrollContainer/CardGrid")
onready var  ability_deck_grid : Node = get_node("View/DeckView/Ability/ScrollContainer/CardGrid")
onready var  power_deck_grid : Node = get_node("View/DeckView/Power/ScrollContainer/CardGrid")


const ACTION_MIN : int = 6
const ACTION_MAX : int = 8
const ABILITY_MIN : int = 9
const ABILITY_MAX : int = 12
const POWER_MIN : int = 9
const POWER_MAX : int = 12

func _ready():
	for i in range(48):
		action_all_grid.add_child(CardBase.get_card_instance("ONE"), true)
		ability_all_grid.add_child(CardBase.get_card_instance("TWO"), true)
		power_all_grid.add_child(CardBase.get_card_instance("FOUR"), true)
		
	for i in range(24):
#		var card1 = load("res://cards/card.tscn").instance()
#		card1.init("TWO")
		add_to_action(action_all_grid.get_child(i))	

	
	
func add_to_action(card : Card):
	if action_deck_grid.get_child_count() > ACTION_MAX:
		#TODO dialog
		return
	#var card = 
	action_deck_grid.add_child(card.duplicate(),false)
	
	
func add_to_ability(card : Card):
	if ability_deck_grid.get_child_count() > ABILITY_MAX:
		#TODO dialog
		return
	ability_deck_grid.add_child(card.duplicate(),false)
	
	
func add_to_power(card : Card):
	if power_deck_grid.get_child_count() > POWER_MAX:
		#TODO dialog
		return
	power_deck_grid.add_child(card.duplicate(),false)

func get_action_deck() -> Array:
	var count : int = action_deck_grid.get_child_count()
	var deck_list : Array
	
	if count < ACTION_MIN:
		# TODO dialog for not enough
		return deck_list
	if count > ACTION_MAX:
		#TODO dialog for too many
		return deck_list
	
	for card in action_deck_grid.get_children():
		deck_list.append(card.card_name)
		
	return deck_list
	
	
func get_ability_deck() -> Array:
	var count : int = ability_deck_grid.get_child_count()
	var deck_list : Array
	
	if count < ABILITY_MIN:
		# TODO dialog for not enough
		return deck_list
	if count > ABILITY_MAX:
		#TODO dialog for too many
		return deck_list
		pass
	
	for card in ability_deck_grid.get_children():
		deck_list.append(card.card_name)
		
	return deck_list
	
	
func get_power_deck() -> Array:
	var count : int = power_deck_grid.get_child_count()
	var deck_list : Array
	
	if count < POWER_MIN:
		return deck_list
		# TODO dialog for not enough
		pass
	if count > POWER_MAX:
		return deck_list
		#TODO dialog for too many
		pass
	
	for card in power_deck_grid.get_children():
		deck_list.append(card.card_name)
		
	return deck_list
	
	
	
		
	
	
