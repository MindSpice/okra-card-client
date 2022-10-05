extends Node
onready var  action_all_grid : Node = get_node("View/AllView/Action/ScrollContainer/CardGrid")
onready var  ability_all_grid : Node = get_node("View/AllView/Ability/ScrollContainer/CardGrid")
onready var  power_all_grid : Node = get_node("View/AllView/Power/ScrollContainer/CardGrid")
onready var  action_deck_grid : Node = get_node("View/DeckView/Action/ScrollContainer/CardGrid")
onready var  ability_deck_grid : Node = get_node("View/DeckView/Ability/ScrollContainer/CardGrid")
onready var  power_deck_grid : Node = get_node("View/DeckView/Power/ScrollContainer/CardGrid")

func _ready():
	for i in range(32):
		var card1 = load("res://cards/card.tscn").instance()
		card1.init("TWO")
		action_all_grid.add_child(card1, true)
		var card2 = load("res://cards/card.tscn").instance()
		card2.init("THREE")
		ability_all_grid.add_child(card2, true)
		var card3 = load("res://cards/card.tscn").instance()
		card3.init("TEN")
		power_all_grid.add_child(card3, true)
		
	for i in range(12):
		var card1 = load("res://cards/card.tscn").instance()
		card1.init("TWO")
		action_deck_grid.add_child(card1, true)
	
