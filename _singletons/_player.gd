extends Node

var _ability_cards_all: Array 
var _action_cards_all: Array
var _power_cards_all: Array
var _pawn_cards_all: Array
var _weapon_cards_all: Array
var _talisman_cards_all: Array
var _pawn_sets: Dictionary
var potions: Dictionary
var is_premieum : = false

var okra_tokens : float = 0

func get_owned_by_domain(domain : int):
	match (domain):
		Game.Domain.ACTION:
			return _action_cards_all.duplicate(true)
		Game.Domain.ABILITY:
			return _ability_cards_all.duplicate(true)
		Game.Domain.POWER:
			return _power_cards_all.duplicate(true)
		Game.Domain.PAWN:
			return _pawn_cards_all.duplicate(true)
		Game.Domain.WEAPON:
			return _weapon_cards_all.duplicate(true)
		Game.Domain.TALISMAN:
			return _talisman_cards_all.duplicate(true)

func _ready(): 
	pass
	#_action_cards_all = ["ACTION1", "ACTION2", "TEST_MULTI", "TEST_SINGLE","ACTION1", "ACTION2", "TEST_MULTI", "TEST_SINGLE","ACTION1", 
	#"ACTION2", "TEST_MULTI", "TEST_SINGLE", "ACTION1", "ACTION2", "TEST_MULTI", "TEST_SINGLE",]
	
	# _ability_cards_all = ["ABILITY1", "ABILITY2", "TEST_SELF", "TEST_ENEMY", "TEST_RESIST", "TEST_CURE", "ABILITY1", "ABILITY2", "TEST_SELF", 
	# "TEST_ENEMY", "TEST_RESIST", "TEST_CURE","ABILITY1", "ABILITY2", "TEST_SELF", "TEST_ENEMY", "TEST_RESIST", "TEST_CURE"]
	
	# _power_cards_all = ["TEST", "TEST_RESIST", "TEST", "TEST_RESIST", "TEST", "TEST_RESIST", "TEST", "TEST_RESIST", "TEST", "TEST_RESIST", ]
	
	# _pawn_cards_all = ["WARRIOR","RANGER", "OKRUID", "WARRIOR","RANGER", "OKRUID", "WARRIOR","RANGER", "OKRUID", "WARRIOR","RANGER", "OKRUID",]
	
	# _weapon_cards_all = [ "TEST_MELEE", "TEST_MAGIC", "SHORT_SWORD", "TEST_MELEE", "TEST_MAGIC", "SHORT_SWORD"]

	# _talisman_cards_all = ["TEST_TALISMAN", "TEST_TALISMAN", "TEST_TALISMAN"]

func get_pawn_sets() -> Dictionary:
	return _pawn_sets


func add_pawn_set(pawn_set: PawnSet) -> bool:
	var existing
	if pawn_set.set_number != -1:
		if _pawn_sets.has(pawn_set.set_number):
			existing = _pawn_sets[pawn_set.set_number]
	
	if existing == null:
		if _pawn_sets.size() >= (10 if is_premieum else 5):
			return false
		else:
			var slot = get_open_slot()
			pawn_set.set_number = slot
			_pawn_sets[slot] = pawn_set
			return true
	else:
		existing = pawn_set
		return true


func set_exists(index: int) -> bool:
	if index == -1:
		return false
	
	if _pawn_sets.has(index):
		return true
	else:
		return false
	

func get_open_slot() -> int:
	for i in range(0, (10 if is_premieum else 5)):
		if not _pawn_sets.has(i):
			return i
	return -1


func remove_pawn_set(idx: int) -> void:
	_pawn_sets.erase(idx)



func set_pawn_sets(pawn_sets: Dictionary) -> void:
	_pawn_sets.clear()
	for pawn_set in pawn_sets.values():
		var pset = PawnSet.new()
		pset.load(pawn_set)
		_pawn_sets[pset.set_number] = pset
		


func set_owned_cards(cards: Dictionary) -> void:
	_action_cards_all = cards["ACTION"]
	_ability_cards_all = cards["ABILITY"]
	_power_cards_all = cards["POWER"]
	_talisman_cards_all = cards["TALISMAN"]
	_weapon_cards_all = cards["WEAPON"]
	_pawn_cards_all = cards["PAWN"]


	
	#pawn_sets.append({"PAWN1":{"ability_deck":["FIVE","FOUR","SEVEN","THREE","NINE","ONE"],"action_deck":["FIVE","ONE","TWO","FIVE","THREE"],"pawn_card":"PAWN1","weapon_card":"WEAPON2"},"PAWN2":{"ability_deck":["TWO","TEN","FIVE","FOUR","SEVEN"],"action_deck":["SEVEN","SEVEN","EIGHT","SEVEN"],"pawn_card":"PAWN3","weapon_card":"WEAPON2"},"PAWN3":{"ability_deck":["TEN","EIGHT","THREE","NINE","ONE","EIGHT","TWO"],"action_deck":["NINE","NINE","TEN","TEN","NINE","TEN"],"pawn_card":"PAWN1","weapon_card":"WEAPON3"},"power_deck":["EIGHT","TWO","TEN","FIVE","FOUR","SEVEN","THREE","NINE"],"preferred_potions":["POTION1","POTION2","POTION3"],"set_name":"Test_Set1"})
	#pawn_sets.append({"PAWN1":{"ability_deck":["FIVE","FOUR","SEVEN","THREE","NINE","ONE"],"action_deck":["FIVE","ONE","TWO","FIVE","THREE"],"pawn_card":"PAWN1","weapon_card":"WEAPON2"},"PAWN2":{"ability_deck":["TWO","TEN","FIVE","FOUR","SEVEN"],"action_deck":["SEVEN","SEVEN","EIGHT","SEVEN"],"pawn_card":"PAWN3","weapon_card":"WEAPON2"},"PAWN3":{"ability_deck":["TEN","EIGHT","THREE","NINE","ONE","EIGHT","TWO"],"action_deck":["NINE","NINE","TEN","TEN","NINE","TEN"],"pawn_card":"PAWN1","weapon_card":"WEAPON3"},"power_deck":["EIGHT","TWO","TEN","FIVE","FOUR","SEVEN","THREE","NINE"],"preferred_potions":["POTION1","POTION2","POTION3"],"set_name":"Test_Set2"})
	#pawn_sets.append({"PAWN1":{"ability_deck":["FIVE","FOUR","SEVEN","THREE","NINE","ONE"],"action_deck":["FIVE","ONE","TWO","FIVE","THREE"],"pawn_card":"PAWN1","weapon_card":"WEAPON2"},"PAWN2":{"ability_deck":["TWO","TEN","FIVE","FOUR","SEVEN"],"action_deck":["SEVEN","SEVEN","EIGHT","SEVEN"],"pawn_card":"PAWN3","weapon_card":"WEAPON2"},"PAWN3":{"ability_deck":["TEN","EIGHT","THREE","NINE","ONE","EIGHT","TWO"],"action_deck":["NINE","NINE","TEN","TEN","NINE","TEN"],"pawn_card":"PAWN1","weapon_card":"WEAPON3"},"power_deck":["EIGHT","TWO","TEN","FIVE","FOUR","SEVEN","THREE","NINE"],"preferred_potions":["POTION1","POTION2","POTION3"],"set_name":"Test_Set3"})
	#pawn_sets.append({"PAWN1":{"ability_deck":["FI4VE","FOUR","SEVEN","THR3EE","NINE","ON4E"],"action_deck":["FIVE","ON43E","TWO","FIV3E","THREE"],"pawn_card":"PA5WN1","weapon_card":"WEAPON42"},"PAWN2":{"ability_deck":["TW5O","TEN","FIVE","FO5UR","SEVEN"],"action_deck":["SEV4EN","SEVEN","EIGHT","SE4VEN"],"pawn_card":"PAW3N3","weapon_card":"WEAPON2"},"PAWN3":{"ability_deck":["TEN","EI6GHT","THREE","NINE","O4NE","EIGHT","TWO"],"action_deck":["NINE","NINE","TEN","TEN","NINE","TEN"],"pawn_card":"PAWN1","weapon_card":"WEAP6ON3"},"power_deck":["EIGHT","TWO","TEN","FIVE","FOU4R","SEV6EN","THREE","NINE"],"preferred_potions":["POTION1","POTION2","POTION3"],"set_name":"Fucked_Set"})
	
	

