extends Node



var ability_cards_all: Array 
var action_cards_all: Array
var power_cards_all: Array
var pawn_cards_all: Array
var weapon_cards_all: Array
var talisman_cards_all: Array
var _pawn_sets: Dictionary
var potions: Dictionary
var is_premieum: bool

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
		Game.Domain.TALISMAN:
			return talisman_cards_all.duplicate(true)

func _ready(): 
	action_cards_all = ["ACTION1", "ACTION2", "TEST_MULTI", "TEST_SINGLE","ACTION1", "ACTION2", "TEST_MULTI", "TEST_SINGLE","ACTION1", 
	"ACTION2", "TEST_MULTI", "TEST_SINGLE", "ACTION1", "ACTION2", "TEST_MULTI", "TEST_SINGLE",]
	
	ability_cards_all = ["ABILITY1", "ABILITY2", "TEST_SELF", "TEST_ENEMY", "TEST_RESIST", "TEST_CURE", "ABILITY1", "ABILITY2", "TEST_SELF", 
	"TEST_ENEMY", "TEST_RESIST", "TEST_CURE","ABILITY1", "ABILITY2", "TEST_SELF", "TEST_ENEMY", "TEST_RESIST", "TEST_CURE"]
	
	power_cards_all = ["TEST", "TEST_RESIST", "TEST", "TEST_RESIST", "TEST", "TEST_RESIST", "TEST", "TEST_RESIST", "TEST", "TEST_RESIST", ]
	
	pawn_cards_all = ["WARRIOR","RANGER", "OKRUID", "WARRIOR","RANGER", "OKRUID", "WARRIOR","RANGER", "OKRUID", "WARRIOR","RANGER", "OKRUID",]
	
	weapon_cards_all = [ "TEST_MELEE", "TEST_MAGIC", "SHORT_SWORD", "TEST_MELEE", "TEST_MAGIC", "SHORT_SWORD"]

	talisman_cards_all = ["TEST_TALISMAN", "TEST_TALISMAN", "TEST_TALISMAN"]

func get_pawn_sets() -> Dictionary:
	return _pawn_sets

func remove_pawn_set(name: String) -> void:
	_pawn_sets.erase(name)

func add_pawn_set(name: String, pawn_set: PawnSet) -> bool:
	if _pawn_sets.size() >= (10 if is_premieum else 5):
		return false
	else:
		_pawn_sets[name] = pawn_set
		return true


	
	#pawn_sets.append({"PAWN1":{"ability_deck":["FIVE","FOUR","SEVEN","THREE","NINE","ONE"],"action_deck":["FIVE","ONE","TWO","FIVE","THREE"],"pawn_card":"PAWN1","weapon_card":"WEAPON2"},"PAWN2":{"ability_deck":["TWO","TEN","FIVE","FOUR","SEVEN"],"action_deck":["SEVEN","SEVEN","EIGHT","SEVEN"],"pawn_card":"PAWN3","weapon_card":"WEAPON2"},"PAWN3":{"ability_deck":["TEN","EIGHT","THREE","NINE","ONE","EIGHT","TWO"],"action_deck":["NINE","NINE","TEN","TEN","NINE","TEN"],"pawn_card":"PAWN1","weapon_card":"WEAPON3"},"power_deck":["EIGHT","TWO","TEN","FIVE","FOUR","SEVEN","THREE","NINE"],"preferred_potions":["POTION1","POTION2","POTION3"],"set_name":"Test_Set1"})
	#pawn_sets.append({"PAWN1":{"ability_deck":["FIVE","FOUR","SEVEN","THREE","NINE","ONE"],"action_deck":["FIVE","ONE","TWO","FIVE","THREE"],"pawn_card":"PAWN1","weapon_card":"WEAPON2"},"PAWN2":{"ability_deck":["TWO","TEN","FIVE","FOUR","SEVEN"],"action_deck":["SEVEN","SEVEN","EIGHT","SEVEN"],"pawn_card":"PAWN3","weapon_card":"WEAPON2"},"PAWN3":{"ability_deck":["TEN","EIGHT","THREE","NINE","ONE","EIGHT","TWO"],"action_deck":["NINE","NINE","TEN","TEN","NINE","TEN"],"pawn_card":"PAWN1","weapon_card":"WEAPON3"},"power_deck":["EIGHT","TWO","TEN","FIVE","FOUR","SEVEN","THREE","NINE"],"preferred_potions":["POTION1","POTION2","POTION3"],"set_name":"Test_Set2"})
	#pawn_sets.append({"PAWN1":{"ability_deck":["FIVE","FOUR","SEVEN","THREE","NINE","ONE"],"action_deck":["FIVE","ONE","TWO","FIVE","THREE"],"pawn_card":"PAWN1","weapon_card":"WEAPON2"},"PAWN2":{"ability_deck":["TWO","TEN","FIVE","FOUR","SEVEN"],"action_deck":["SEVEN","SEVEN","EIGHT","SEVEN"],"pawn_card":"PAWN3","weapon_card":"WEAPON2"},"PAWN3":{"ability_deck":["TEN","EIGHT","THREE","NINE","ONE","EIGHT","TWO"],"action_deck":["NINE","NINE","TEN","TEN","NINE","TEN"],"pawn_card":"PAWN1","weapon_card":"WEAPON3"},"power_deck":["EIGHT","TWO","TEN","FIVE","FOUR","SEVEN","THREE","NINE"],"preferred_potions":["POTION1","POTION2","POTION3"],"set_name":"Test_Set3"})
	#pawn_sets.append({"PAWN1":{"ability_deck":["FI4VE","FOUR","SEVEN","THR3EE","NINE","ON4E"],"action_deck":["FIVE","ON43E","TWO","FIV3E","THREE"],"pawn_card":"PA5WN1","weapon_card":"WEAPON42"},"PAWN2":{"ability_deck":["TW5O","TEN","FIVE","FO5UR","SEVEN"],"action_deck":["SEV4EN","SEVEN","EIGHT","SE4VEN"],"pawn_card":"PAW3N3","weapon_card":"WEAPON2"},"PAWN3":{"ability_deck":["TEN","EI6GHT","THREE","NINE","O4NE","EIGHT","TWO"],"action_deck":["NINE","NINE","TEN","TEN","NINE","TEN"],"pawn_card":"PAWN1","weapon_card":"WEAP6ON3"},"power_deck":["EIGHT","TWO","TEN","FIVE","FOU4R","SEV6EN","THREE","NINE"],"preferred_potions":["POTION1","POTION2","POTION3"],"set_name":"Fucked_Set"})
	
	

