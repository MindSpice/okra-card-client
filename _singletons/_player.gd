extends Node



var ability_cards_all : Array 
var action_cards_all : Array
var power_cards_all : Array
var pawn_cards_all : Array
var weapon_cards_all : Array
var pawn_sets : Array
var potions : Dictionary

var okra_tokens : float = 0

func get_owned_by_domain(domain : int):
	match (domain):
		Game.Domain.ACTION:
			return action_cards_all.duplicate(true)
		Game.Domain.ABILITY:
			return ability_cards_all.duplicate(true)
		Game.Domain.POWER:
			return power_cards_all.duplicate(true)
		Game.Domain.PAWN:
			return pawn_cards_all.duplicate(true)
		Game.Domain.WEAPON:
			return weapon_cards_all.duplicate(true)

func _ready(): 
	action_cards_all = ["ONE", "EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE","ONE", 
	"EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE","ONE", "EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE"]
	
	ability_cards_all = ["ONE", "EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE","ONE", 
	"EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE","ONE", "EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE"]
	
	power_cards_all = ["ONE", "EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE","ONE", 
	"EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE","ONE", "EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE"]
	
	pawn_cards_all = ["PAWN1","PAWN1", "PAWN2", "PAWN2", "PAWN3", "PAWN3"]
	
	weapon_cards_all = [ "WEAPON1", "WEAPON1", "WEAPON2", "WEAPON2", "WEAPON3", "WEAPON3"]
	
	pawn_sets.append({"PAWN1":{"ability_deck":["FIVE","FOUR","SEVEN","THREE","NINE","ONE"],"action_deck":["FIVE","ONE","TWO","FIVE","THREE"],"pawn_card":"PAWN1","weapon_card":"WEAPON2"},"PAWN2":{"ability_deck":["TWO","TEN","FIVE","FOUR","SEVEN"],"action_deck":["SEVEN","SEVEN","EIGHT","SEVEN"],"pawn_card":"PAWN3","weapon_card":"WEAPON2"},"PAWN3":{"ability_deck":["TEN","EIGHT","THREE","NINE","ONE","EIGHT","TWO"],"action_deck":["NINE","NINE","TEN","TEN","NINE","TEN"],"pawn_card":"PAWN1","weapon_card":"WEAPON3"},"power_deck":["EIGHT","TWO","TEN","FIVE","FOUR","SEVEN","THREE","NINE"],"preferred_potions":["POTION1","POTION2","POTION3"],"set_name":"Test_Set1"})
	pawn_sets.append({"PAWN1":{"ability_deck":["FIVE","FOUR","SEVEN","THREE","NINE","ONE"],"action_deck":["FIVE","ONE","TWO","FIVE","THREE"],"pawn_card":"PAWN1","weapon_card":"WEAPON2"},"PAWN2":{"ability_deck":["TWO","TEN","FIVE","FOUR","SEVEN"],"action_deck":["SEVEN","SEVEN","EIGHT","SEVEN"],"pawn_card":"PAWN3","weapon_card":"WEAPON2"},"PAWN3":{"ability_deck":["TEN","EIGHT","THREE","NINE","ONE","EIGHT","TWO"],"action_deck":["NINE","NINE","TEN","TEN","NINE","TEN"],"pawn_card":"PAWN1","weapon_card":"WEAPON3"},"power_deck":["EIGHT","TWO","TEN","FIVE","FOUR","SEVEN","THREE","NINE"],"preferred_potions":["POTION1","POTION2","POTION3"],"set_name":"Test_Set2"})
	pawn_sets.append({"PAWN1":{"ability_deck":["FIVE","FOUR","SEVEN","THREE","NINE","ONE"],"action_deck":["FIVE","ONE","TWO","FIVE","THREE"],"pawn_card":"PAWN1","weapon_card":"WEAPON2"},"PAWN2":{"ability_deck":["TWO","TEN","FIVE","FOUR","SEVEN"],"action_deck":["SEVEN","SEVEN","EIGHT","SEVEN"],"pawn_card":"PAWN3","weapon_card":"WEAPON2"},"PAWN3":{"ability_deck":["TEN","EIGHT","THREE","NINE","ONE","EIGHT","TWO"],"action_deck":["NINE","NINE","TEN","TEN","NINE","TEN"],"pawn_card":"PAWN1","weapon_card":"WEAPON3"},"power_deck":["EIGHT","TWO","TEN","FIVE","FOUR","SEVEN","THREE","NINE"],"preferred_potions":["POTION1","POTION2","POTION3"],"set_name":"Test_Set3"})
	pawn_sets.append({"PAWN1":{"ability_deck":["FI4VE","FOUR","SEVEN","THR3EE","NINE","ON4E"],"action_deck":["FIVE","ON43E","TWO","FIV3E","THREE"],"pawn_card":"PA5WN1","weapon_card":"WEAPON42"},"PAWN2":{"ability_deck":["TW5O","TEN","FIVE","FO5UR","SEVEN"],"action_deck":["SEV4EN","SEVEN","EIGHT","SE4VEN"],"pawn_card":"PAW3N3","weapon_card":"WEAPON2"},"PAWN3":{"ability_deck":["TEN","EI6GHT","THREE","NINE","O4NE","EIGHT","TWO"],"action_deck":["NINE","NINE","TEN","TEN","NINE","TEN"],"pawn_card":"PAWN1","weapon_card":"WEAP6ON3"},"power_deck":["EIGHT","TWO","TEN","FIVE","FOU4R","SEV6EN","THREE","NINE"],"preferred_potions":["POTION1","POTION2","POTION3"],"set_name":"Fucked_Set"})
	
	

