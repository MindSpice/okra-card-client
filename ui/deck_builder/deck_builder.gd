extends Node
onready var flowbox = get_node("View/DeckView/ActionAll/ScrollContainer/GridContainer")

func _ready():
	for i in range(24):
		var card = load("res://cards/card.tscn").instance()
		card.init("TWO")
		flowbox.add_child(card, true)
	
		
