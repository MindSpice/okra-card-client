extends Control

var _card_grid : Node 
var _selected_card : Card
var _pawn : int
var _domain : int



func init(pawn : int, domain : int, cards : Array):
	_selected_card = null
	_pawn = pawn
	_domain = domain
	Util.free_children(_card_grid)
	$Window/Hsplit/Card/Image.texture = null
	
	var card_instances = CardBase.instance_card_list(domain, cards)
	_card_grid = $Window/Hsplit/Cards/ScrollCont/CardGrid
	
	for card in card_instances:
		card.enable_select(true)
		card.connect("card_selected", self, "_select_card")
		_card_grid.add_child(card)


func pop_up():
	$Window.popup_centered()


func _select_card(card : Card):
	_selected_card = card
	$Window/Hsplit/Card/Image.texture = card.get_image()
	

func _on_select_pressed():
	emit_signal("_card_relay", _pawn, _domain, _selected_card)
	$Window.hide()


signal _card_relay(pawn_idx, domain, card)
