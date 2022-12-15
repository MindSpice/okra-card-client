extends Node
enum DamageClass {SINGLE, MULTI}
enum ActionType {MELEE, MAGIC, RANGED}
enum Level {ONE, TWO, THREE, FOUR}
var null_card = "res://cards/images/cardBack.png"

const ACTION_RES = "res://cards/images/"
const CARD_TEMPLATE = preload("res://cards/card.tscn")


func instance_card(domain : int, card_name : String) -> Node:
	print(domain, card_name)
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

		Game.Domain.DEFENSE:
			card.init(domain, card_name, DEFENSECARDS.get(card_name))

		Game.Domain.TALISMAN:
			card.init(domain, card_name, TALISMANARDS.get(card_name))

	return card

func instance_card_by_slot(card_slot : int, card_name : String) -> Node:
		match(card_slot):
			Game.CardSlot.PAWN_CARD:
				return instance_card(Game.Domain.PAWN, card_name)

			Game.CardSlot.WEAPON_CARD_1, Game.CardSlot.WEAPON_CARD_2:
				return instance_card(Game.Domain.WEAPON, card_name)

			Game.CardSlot.ACTION_CARD_1, Game.CardSlot.ACTION_CARD_2:
				 return instance_card(Game.Domain.ACTION, card_name)

			Game.CardSlot.ABILITY_CARD_1, Game.CardSlot.ABILITY_CARD_2:
				return instance_card(Game.Domain.ABILITY, card_name)

			Game.CardSlot.POWER_CARD:
				return instance_card(Game.Domain.POWER, card_name)

			Game.CardSlot.TALISMAN_CARD:
				return instance_card(Game.Domain.POWER, card_name)

		return null

	
	
func instance_card_list(domain: int, cards: Array) -> Array:
	var instances: Array
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
		
func get_cards_level(card_list : Array) -> int:
	var level : int = 0
	for card in card_list:
		level += card.card_level
	return level
	
	
func card_nodes_as_names (card_nodes : Array) -> Array:
	var card_names : Array
	for card in card_nodes:
		card_names.append(card.card_name)
	return card_names

# TODO find a better representation
# export from back into into csv and maintain indexing?
const ACTIONCARDS = {
	"ONE" : ["SINGLE", "MELEE", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TWO" : ["SINGLE", "MELEE", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"THREE" : ["SINGLE", "MELEE", false, 2, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"FOUR" : ["SINGLE", "MELEE", false, 3 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"FIVE" : ["SINGLE", "MELEE", false, 4 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"SIX" : ["SINGLE", "RANGED", false, 1,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"SEVEN" : ["SINGLE", "RANGED", false, 4 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"EIGHT" : ["SINGLE", "RANGED", false, 3 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"NINE" : ["SINGLE", "MAGIC", false, 4 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TEN" : ["SINGLE", "MAGIC", false, 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"ACTION1" : ["SINGLE", "MAGIC", false, 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"ACTION2" : ["SINGLE", "MAGIC", false, 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"NULL" : ["SINGLE", "MAGIC", false, 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TESTCARD" : ["SINGLE", "MAGIC", false, 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0]
}

const ABILITYCARDS = {
	"ONE" : ["SINGLE", "MELEE", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TWO" : ["SINGLE", "MELEE", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"THREE" : ["SINGLE", "MELEE", false, 2, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"FOUR" : ["SINGLE", "MELEE", false, 3 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"FIVE" : ["SINGLE", "MELEE", false, 4 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"SIX" : ["SINGLE", "RANGED", false, 1,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"SEVEN" : ["SINGLE", "RANGED", false, 4 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"EIGHT" : ["SINGLE", "RANGED", false, 3 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"NINE" : ["SINGLE", "MAGIC", false, 4 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TEN" : ["SINGLE", "MAGIC", false, 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TEST_ENEMY" : ["SINGLE", "MAGIC", false, 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"NULL" : ["SINGLE", "MAGIC", false, 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TESTCARD" : ["SINGLE", "MAGIC", false, 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0]
}

const POWERCARDS = {
	"ONE" : ["SINGLE", "MELEE", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TWO" : ["SINGLE", "MELEE", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"THREE" : ["SINGLE", "MELEE", false, 2, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"FOUR" : ["SINGLE", "MELEE", false, 3 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"FIVE" : ["SINGLE", "MELEE", false, 4 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"SIX" : ["SINGLE", "RANGED", false, 1,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"SEVEN" : ["SINGLE", "RANGED", false, 4 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"EIGHT" : ["SINGLE", "RANGED", false, 3 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"NINE" : ["SINGLE", "MAGIC", false, 4 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TEN" : ["SINGLE", "MAGIC", false, 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TEST" : ["SINGLE", "MAGIC", false, 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"NULL" : ["SINGLE", "MAGIC", false, 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TESTCARD" : ["SINGLE", "MAGIC", false, 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0]
}

const TALISMANARDS = {
	"ONE" : ["SINGLE", "MELEE", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TWO" : ["SINGLE", "MELEE", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"THREE" : ["SINGLE", "MELEE", false, 2, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"FOUR" : ["SINGLE", "MELEE", false, 3 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"FIVE" : ["SINGLE", "MELEE", false, 4 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"SIX" : ["SINGLE", "RANGED", false, 1,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"SEVEN" : ["SINGLE", "RANGED", false, 4 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"EIGHT" : ["SINGLE", "RANGED", false, 3 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"NINE" : ["SINGLE", "MAGIC", false, 4 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TEN" : ["SINGLE", "MAGIC", false, 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TEST_ENEMY" : ["SINGLE", false, "MAGIC", 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"NULL" : ["SINGLE", "MAGIC", false, 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TESTCARD" : ["SINGLE", "MAGIC", false, 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0]
}

const PAWNCARDS = {
	"PAWN1" : ["SINGLE", "MELEE", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"PAWN2" : ["SINGLE", "RANGED", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"PAWN3" : ["SINGLE", "MAGIC", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"OKRUID" : ["SINGLE", "MAGIC", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"NULL" : ["SINGLE", "MAGIC", false, 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TESTCARD" : ["SINGLE", "MAGIC", false, 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0]
}

const WEAPONCARDS = {
	"WEAPON1" : ["SINGLE", "MELEE", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"WEAPON2" : ["SINGLE", "RANGED", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"WEAPON3" : ["SINGLE", "MAGIC", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"ENCHANTED_BOW" : ["SINGLE", "MAGIC", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"NULL" : ["SINGLE", "MAGIC", false, 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TESTCARD" : ["SINGLE", "MAGIC", false, 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0]
}

const DEFENSECARDS = {
	"WEAPON1" : ["SINGLE", "MELEE", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"WEAPON2" : ["SINGLE", "RANGED", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"WEAPON3" : ["SINGLE", "MAGIC", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"ENCHANTED_BOW" : ["SINGLE", "MAGIC", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"NULL" : ["SINGLE", "MAGIC", false, 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TESTCARD" : ["SINGLE", "MAGIC", false, 1 ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0]
}




const POTIONS = {
	"POTION1" : ["SINGLE", "MELEE", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"POTION2" : ["SINGLE", "RANGED", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"POTION3" : ["SINGLE", "MAGIC", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"POTION4" : ["SINGLE", "MELEE", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"POTION5" : ["SINGLE", "RANGED", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"POTION6" : ["SINGLE", "MAGIC", false, 1, true, false, 10, 5, 5, 5, 0 ,0, 22, 0]
}


