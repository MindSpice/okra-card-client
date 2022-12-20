extends Control

var _card_grid: Node 
var _selected_card: Card
var _pawn: int
var _domain: int
var _card_idx: int


var action_info := preload("res://cards/desc_ui/action_card_desc.tscn")
var ability_info := preload("res://cards/desc_ui/ability_card_desc.tscn")
var pawn_info := preload("res://cards/desc_ui/pawn_card_desc.tscn")
var power_info := preload("res://cards/desc_ui/power_card_desc.tscn")
var talisman_info := preload("res://cards/desc_ui/talisman_card_desc.tscn")
var weapon_info := preload("res://cards/desc_ui/weapon_card_desc.tscn")
onready var _all_grid := $Window/Hsplit/Cards/ScrollCont/CardGrid
var _all_free_cards: Array


func init(pawn : int, domain : int, cards : Array, card_idx: int):
	_selected_card = null
	_pawn = pawn
	_domain = domain
	_card_idx = card_idx
	_all_free_cards = cards
	Util.remove_children($Window/Hsplit/Cards/ScrollCont/CardGrid)
	Util.remove_children($Window/Hsplit/Card/HBox/Info/Stat)
	$Window/Hsplit/Card/HBox/VBox/Image.texture = null
	
	for card in cards:
		card.enable_select(true)
		# card.connect("card_selected", self, "_select_card")	- Done now in set_builder, left if revert needed
		$Window/Hsplit/Cards/ScrollCont/CardGrid.add_child(card)
	
	$Window/Hsplit/Cards/LevelCombo.select(0)
	$Window/Hsplit/Cards/TypeCombo.select(0)

func pop_up():
	$Window.popup_centered()


func _select_card(card : Card):
	_selected_card = card
	$Window/Hsplit/Card/HBox/VBox/Image.texture = card.get_image()

	var info_node : Node
	match card.card_domain:
		Game.Domain.ACTION:
			info_node = action_info.instance()
		Game.Domain.ABILITY:
			info_node = ability_info.instance()
		Game.Domain.PAWN:
			info_node = pawn_info.instance()
		Game.Domain.WEAPON:
			info_node = weapon_info.instance()
		Game.Domain.POWER:
			info_node =  power_info.instance()
		Game.Domain.TALISMAN:
			info_node = talisman_info.instance()
	info_node.init(card.card_info)
	$Window/Hsplit/Card/HBox/Info/Stat.add_child(info_node)
	$Window/Hsplit/Card/HBox/Info/Description.text = card.card_info.get("description")

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
	$Window/Hsplit/Cards/TypeCombo.select(typei)
	


func get_type_int(type : String) -> int:
	if type == "MELEE": return 1
	if type == "RANGED": return 2
	if type == "MAGIC": return 3
	return 0

func _on_select_pressed():
	emit_signal("_card_relay", _pawn, _domain, _selected_card, _card_idx)
	$Window.hide()


func _on_TypeCombo_item_selected(index):
	update_filtered_view(index, $Window/Hsplit/Cards/LevelCombo.get_selected_id())
	
	
func _on_LevelCombo_item_selected(index):
	update_filtered_view($Window/Hsplit/Cards/TypeCombo.get_selected_id(), index)


signal _card_relay(pawn_idx, domain, card, card_idx)
