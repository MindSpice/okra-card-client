extends Control

var action_info := preload("res://cards/desc_ui/action_card_desc.tscn")
var ability_info := preload("res://cards/desc_ui/ability_card_desc.tscn")
var pawn_info := preload("res://cards/desc_ui/pawn_card_desc.tscn")
var power_info := preload("res://cards/desc_ui/power_card_desc.tscn")
var talisman_info := preload("res://cards/desc_ui/talisman_card_desc.tscn")
var weapon_info := preload("res://cards/desc_ui/weapon_card_desc.tscn")


func set_card(card : Card) -> void:
	$Window/CardView.texture = card.get_image()

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
	$Window/Info/Stat.add_child(info_node)
	$Window/Info/Description.text = card.card_info.get("description")
	

func pop_up() -> void:
	$Window.popup_centered()
