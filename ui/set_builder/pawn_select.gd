extends Control

onready var _card_grid : Node = $Window/Hsplit/Cards/ScrollCont/CardGrid

func set_card_grid(domain : int, cards : Array):
	var card_instances = CardBase.instance_card_list(domain, cards)
	for card in card_instances:
		_card_grid.add_child(card)

func pop_up():
	print("here")
	$Window.popup_centered()
