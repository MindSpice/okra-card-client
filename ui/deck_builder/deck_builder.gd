extends Node

class_name DeckBuilder

onready var _all_grid : Node 
onready var  _deck_grid : Node 
onready var inspect_window = preload("res://ui/deck_builder/inspect_card.tscn").instance()

#Domain of selection
var _domain : int
# All free card instances (that player owns)
var _all_free_cards : Array
# Deck level
var _deck_level : int = 0


func _ready():
#	_all_free_cards =  CardBase.instance_card_list(Game.Domain.ACTION, Player.action_cards_all)
#	print(_all_free_cards.size())
#	_all_grid = get_node("View/AllView/ScrollContainer/CardGrid")
#	for card in _all_free_cards:
#		print(_all_grid)
#		_all_grid.add_child(card)
#		card.connect("context_selected", self, "update_deck")
#	_all_free_cards = CardBase.instance_card_list(Game.Domain.ACTION, Player.action_cards_all)
##	ability_cards_all = CardBase.instance_card_list(Game.Domain.ABILITY, Player.ability_cards_all)
##	power_cards_all = CardBase.instance_card_list(Game.Domain.POWER, Player.power_cards_all)
#
#	for card in _all_free_cards:
#		_all_grid.add_child(card)
#		card.connect("context_selected", self, "update_deck")
##
	# for card in ability_cards_all:
	# 	ability_all_grid.add_child(card)
	# 	card.connect("context_selected", self, "update_deck")

	# for card in power_cards_all:
	# 	power_all_grid.add_child(card)
	# 	card.connect("context_selected", self, "update_deck")

	# update_all_count(Game.Domain.ACTION)
	# update_all_count(Game.Domain.ABILITY)
	# update_all_count(Game.Domain.POWER)
	# $View/AllView/Ability.hide()
	pass
	
	
func init(domain : int, free_card_list : Array):
	_all_free_cards =  CardBase.instance_card_list(Game.Domain.ACTION, free_card_list)
	_all_grid = get_node("View/AllView/ScrollContainer/CardGrid")
	_deck_grid = get_node("View/DeckView/ScrollContainer/CardGrid")

	for card in _all_free_cards:
		_all_grid.add_child(card)
		card.connect("context_selected", self, "update_deck")
		#test
	
	if domain != Game.Domain.ACTION:
		$View/AllView/Cards/Top/TypeCombo.hide()
		pass
	#update_all_count()
	

func get_built_deck() -> Array:
	var deck : Array
	
	for card in _deck_grid.get_children():
		deck.append(card)
	return deck


func get_deck_type_bound():
	for card in _deck_grid.get_children():
		return card.card_type
	return ""


func add_to_deck(card : Card):
	var maxv = Game.get_deck_contraints(_domain).y
	var limit = Game.get_deck_limit(_domain, _deck_grid.get_child_count() + 1)
	var type_bound = get_deck_type_bound()
	
	if _domain == Game.Domain.ACTION and type_bound != "" and card.card_type != type_bound:
		#Throw Dialog
		print("type mismatch; deck is of type:", type_bound)
		return
	if (_deck_grid.get_child_count() >= maxv) or (_deck_level + card.card_level > limit):
		#Throw dialog
		print("max count/limit mismatch", "MAX:",maxv," COUNT", _deck_grid.get_child_count())
		return
		
	_all_grid.remove_child(card)
	_deck_grid.add_child(card)
	_deck_level += card.card_level
	card.is_in_deck = true
	update_all_count()
	update_deck_count()


func remove_from_deck(card : Card):

	_deck_grid.remove_child(card)
	_all_grid.add_child(card)
	_deck_level -= card.card_level
	card.is_in_deck = false
	update_all_count()
	update_deck_count()


	# Updates the all card view filter, as to no wrongly show retuned cards
	match (_domain):
		Game.Domain.ACTION:
			update_filtered_view(
				get_node("View/AllView/Top/TypeCombo").get_selected_id(), 
				$"View/AllView/Top/LevelCombo".get_selected_id())
		Game.Domain.ABILITY:
			update_filtered_view(
				0, 
				$"View/AllView/Top/LevelCombo".get_selected_id())
		Game.Domain.Power:
			update_filtered_view(
				0, 
				$"View/AllView/Top/LevelCombo".get_selected_id())


func update_deck(card : Card, id : int):
	match (id):
		0: add_to_deck(card)
		1: remove_from_deck(card)
		2: 
			$Panel.add_child(inspect_window)
			inspect_window.set_card(card)
			inspect_window.pop_up()
			


func update_filtered_view(typei : int, level : int):
	Util.remove_children(_all_grid)
	print("typei:",typei)
	print("level:",level)
	var type : String
	match (typei):
		0: type = ""
		1: type = "MELEE"
		2: type = "RANGED"
		3: type = "MAGIC"
		
		
	for card in _all_free_cards:
		if (type != "") and (card.card_type != type):
			continue
		if (level != 0) and (card.card_level != level):
			continue
		_all_grid.add_child(card)


func update_all_count():
	$View/AllView/CardTotal.text = "All Cards:" + str(_all_grid.get_child_count())


func update_deck_count():
	$View/DeckView/LoadBox/CardTotal.text = "Deck: " +(str(_deck_grid.get_child_count()) + " / " 
	+ str(Game.get_deck_contraints(_domain).x) + " (Min:" + str(Game.get_deck_contraints(_domain).y) +")")


func _on_TypeCombo_item_selected(index):
	print($View/AllView/Top/LevelCombo.get_index())
	update_filtered_view(index, $View/AllView/Top/LevelCombo.get_selected_id())


func _on_LevelCombo_item_selected(index):
	update_filtered_view($View/AllView/Top/TypeCombo.get_selected_id(),index)
	

	
