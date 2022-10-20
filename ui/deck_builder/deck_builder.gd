extends Node

class_name DeckBuilder

onready var _all_grid : Node
onready var  _deck_grid : Node
onready var inspect_window = preload("res://ui/deck_builder/inspect_card.tscn").instance()

#Domain of selection
var _domain : int
var _pawn : int
var _all_free_cards : Array
var _deck_level : int = 0

func _ready() -> void:
	$Panel.add_child(inspect_window)


func init(pawn : int, domain : int, free_card_list : Array, curr_deck : Array):
	_all_grid = $View/AllView/ScrollContainer/CardGrid
	_deck_grid = $View/DeckView/ScrollContainer/CardGrid
	_pawn = pawn
	_domain = domain
	_deck_level = CardBase.get_cards_level(curr_deck)
	_all_free_cards = free_card_list

	for card in _all_free_cards:
		_all_grid.add_child(card)
		card.is_in_deck = false
	
	for card in curr_deck:
		_deck_grid.add_child(card)
		card.is_in_deck = true

	if domain != Game.Domain.ACTION:
		$View/AllView/Top/TypeCombo.hide()
		$View/AllView/Top/TypeCombo.select(0)
	else:
		$View/AllView/Top/TypeCombo.show()
		$View/AllView/Top/TypeCombo.select(get_type_int(curr_deck[0].card_type) if curr_deck.size() > 0 else 0)
		
	$View/AllView/Top/LevelCombo.select(0)
	update_filtered_view(
		$View/AllView/Top/TypeCombo.get_selected_id(), 
		$View/AllView/Top/LevelCombo.get_selected_id())	
	update_all_count()
	update_deck_count()
	

func get_built_deck() -> Array:
	return _deck_grid.get_children()
	

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
		push_warning(str("Type Mis-Match, Deck Type Is:", type_bound))
		return
		
	if (_deck_grid.get_child_count() >= maxv) or (_deck_level + card.card_level > limit):
		#Throw dialog
		push_warning(str("Max Count/Limit | ", "MAX: ",maxv," COUNT: ", 
			_deck_grid.get_child_count(), "DECK_LVL: ", limit, "MAX_LVL", limit))
		return

	_all_grid.remove_child(card) # !!! Removal MUST come first on node swaps
	_deck_grid.add_child(card)
	_all_free_cards.erase(card)
	_deck_level += card.card_level
	card.is_in_deck = true
	
	if (_domain == Game.Domain.ACTION) :
		$View/AllView/Top/TypeCombo.select(get_type_int(card.card_type))
		update_filtered_view(
			get_type_int(card.card_type),
			$View/AllView/Top/LevelCombo.get_selected_id())
			
	update_all_count()
	update_deck_count()


func remove_from_deck(card : Card):
	_all_free_cards.append(card)
	_deck_grid.remove_child(card)
	_deck_level -= card.card_level
	card.is_in_deck = false
	
	update_filtered_view(
		$View/AllView/Top/TypeCombo.get_selected_id(), 
		$View/AllView/Top/LevelCombo.get_selected_id())
	update_all_count()
	update_deck_count()


func update_deck(card : Card, id : int):
	match (id):
		0: add_to_deck(card)
		1: remove_from_deck(card)
		2: 
			inspect_window.set_card(card)
			inspect_window.pop_up()
			


func update_filtered_view(typei : int, level : int):
	Util.remove_children(_all_grid)
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
		
func get_type_int(type : String) -> int:
	if type == "MELEE": return 1
	if type == "RANGED": return 2
	if type == "MAGIC": return 3
	return 0


func update_all_count():
	$View/AllView/CardTotal.text = "All Cards:" + str(_all_grid.get_child_count())


func update_deck_count():
	$View/DeckView/LoadBox/CardTotal.text = "Deck: " +(str(_deck_grid.get_child_count()) + " / " 
	+ str(Game.get_deck_contraints(_domain).y) + " (Min:" + str(Game.get_deck_contraints(_domain).x) +")")


func _on_TypeCombo_item_selected(index):
	update_filtered_view(index, $View/AllView/Top/LevelCombo.get_selected_id())


func _on_LevelCombo_item_selected(index):
	update_filtered_view($View/AllView/Top/TypeCombo.get_selected_id(),index)


func _on_Save_pressed() -> void:
	if (_deck_grid.get_child_count() < Game.get_deck_contraints(_domain).y
		or _deck_grid.get_child_count() > Game.get_deck_contraints(_domain).x):
			push_warning("Save Constaints Mis-Match")
			pass
	emit_signal("save",
		 _pawn, 
		_domain,
		_deck_grid.get_children() if _deck_grid.get_child_count() > 0 else [], 
		_all_grid.get_children() if _all_grid.get_child_count() > 0 else [])
	Util.remove_children(_all_grid)
	Util.remove_children(_deck_grid)


# Unused
#func _on_Reset_pressed() -> void:
#	for card in _deck_grid.get_children():
#		_all_free_cards.append(card)
#		_deck_grid.remove_child(card)
#		_deck_level = 0
#		card.is_in_deck = false
#		update_filtered_view(
#			$View/AllView/Top/TypeCombo.get_selected_id(), 
#			$View/AllView/Top/LevelCombo.get_selected_id())


func _on_Close_pressed() -> void:
	emit_signal("closed", _domain, _deck_grid.get_children())
	Util.remove_children(_all_grid)
	Util.remove_children(_deck_grid)
	
	
	   
signal closed(domain, free)
signal save (pawn, domain, deck, free)

