extends Node
enum DamageClass {SINGLE, MULTI}
enum ActionType {MELEE, MAGIC, RANGED}
enum Level {ONE, TWO, THREE, FOUR}

const ACTION_RES = "res://cards/images/"
const CARD_TEMPLATE = preload("res://cards/card.tscn")


func instance_card(domain : int, card_name : String) -> Node:
	var card = CARD_TEMPLATE.instance()
	match(domain):
		Game.Domain.ACTION:
			card.init(domain, card_name, ACTIONCARDS.get(card_name))
		Game.Domain.ABILITY:
			card.init(domain, card_name, ABILITYCARDS.get(card_name))
		Game.Domain.POWER:
			card.init(domain, card_name, POWERCARDS.get(card_name))
		Game.Domain.PAWN:
			card.init(domain, card_name, PAWNCARDS.get(card_name))
		Game.Domain.WEAPON:
			card.init(domain, card_name, WEAPONCARDS.get(card_name))
			
	return card
	
	
func instance_card_list(domain : int, cards : Array) -> Array:
	var instances : Array
	for card in cards:
		instances.append(instance_card(domain, card))
		
	return instances
	
func get_card_dict_by_domain(domain : int) -> Dictionary:
	match(domain):
		Game.Domain.ACTION:
			return ACTIONCARDS
		Game.Domain.ABILITY:
			return ABILITYCARDS
		Game.Domain.POWER:
			return POWERCARDS
		Game.Domain.PAWN:
			return PAWNCARDS
		Game.Domain.WEAPON:
			return WEAPONCARDS
		
	return {}
		



# TODO find a better representation
# export from back into into csv and maintain indexing?
const ACTIONCARDS = {
	"ONE" : ["SINGLE", "MELEE", 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TWO" : ["SINGLE", "MELEE", 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"THREE" : ["SINGLE", "MELEE", 2, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"FOUR" : ["SINGLE", "MELEE", 3 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"FIVE" : ["SINGLE", "MELEE", 4 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"SIX" : ["SINGLE", "RANGED", 1,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"SEVEN" : ["SINGLE", "RANGED", 4 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"EIGHT" : ["SINGLE", "RANGED", 3 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"NINE" : ["SINGLE", "MAGIC", 4 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TEN" : ["SINGLE", "MAGIC", 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0]
}

const ABILITYCARDS = {
	"ONE" : ["SINGLE", "MELEE", 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TWO" : ["SINGLE", "MELEE", 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"THREE" : ["SINGLE", "MELEE", 2, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"FOUR" : ["SINGLE", "MELEE", 3 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"FIVE" : ["SINGLE", "MELEE", 4 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"SIX" : ["SINGLE", "RANGED", 1,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"SEVEN" : ["SINGLE", "RANGED", 4 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"EIGHT" : ["SINGLE", "RANGED", 3 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"NINE" : ["SINGLE", "MAGIC", 4 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TEN" : ["SINGLE", "MAGIC", 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0]
}

const POWERCARDS = {
	"ONE" : ["SINGLE", "MELEE", 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TWO" : ["SINGLE", "MELEE", 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"THREE" : ["SINGLE", "MELEE", 2, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"FOUR" : ["SINGLE", "MELEE", 3 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"FIVE" : ["SINGLE", "MELEE", 4 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"SIX" : ["SINGLE", "RANGED", 1,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"SEVEN" : ["SINGLE", "RANGED", 4 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"EIGHT" : ["SINGLE", "RANGED", 3 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"NINE" : ["SINGLE", "MAGIC", 4 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TEN" : ["SINGLE", "MAGIC", 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0]
}

const PAWNCARDS = {
	"PAWN1" : ["SINGLE", "MELEE", 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"PAWN2" : ["SINGLE", "RANGED", 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"PAWN3" : ["SINGLE", "MAGIC", 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0]
}

const WEAPONCARDS = {
	"WEAPON1" : ["SINGLE", "MELEE", 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"WEAPON2" : ["SINGLE", "RANGED", 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"WEAPON3" : ["SINGLE", "MAGIC", 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0]
}


