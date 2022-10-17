extends Node
const ACTION_MIN : int = 6
const ACTION_MAX : int = 10
const ABILITY_MIN : int = 9
const ABILITY_MAX : int = 15
const POWER_MIN : int = 9
const POWER_MAX : int = 15
const POTION_LEVEL_MAX : int = 50
const ACTION_LEVEL_MEDIAN : float = 2.5
const ABILITY_LEVEL_MEDIAN : float = 2.5
const POWER_LEVEL_MEDIAN : float = 2.5
const P_PAWN_POS = [Vector2(1050, 850), Vector2(925, 750), Vector2(1050,650)]
const E_PAWN_POS = [Vector2(125, 845), Vector2(250, 745), Vector2(125,645)]
#const P_PAWN_POS = [Vector2(1050, 650), Vector2(925, 550), Vector2(1050,450)]
#const E_PAWN_POS = [Vector2(125, 645), Vector2(250, 545), Vector2(125,445)]


enum Domain {ACTION, ABILITY, POWER, PAWN, WEAPON}
enum Pawn {PAWN1, PAWN2, PAWN3}
enum PState {IDLE, LUNGE, ATTACK, DEFEND, RESET}
	
func get_deck_limit(domain : int, count : int) -> float:
	match (domain):
		Domain.ACTION:
			if count <= ACTION_MIN:
				return ACTION_MIN * ACTION_LEVEL_MEDIAN
			else:
				return count * ACTION_LEVEL_MEDIAN
		Domain.ABILITY:
			if count <= ABILITY_MIN:
				return ABILITY_MIN * ABILITY_LEVEL_MEDIAN
			else:
				return count * ABILITY_LEVEL_MEDIAN
		Domain.POWER:
			if count <= POWER_MIN:
				return POWER_MIN * POWER_LEVEL_MEDIAN
			else:
				return count * POWER_LEVEL_MEDIAN
	return 0.0
	

func get_deck_contraints(domain : int) -> Vector2:
	match (domain):
		Domain.ACTION:
			return Vector2(ACTION_MIN, ACTION_MAX)
		Domain.ABILITY:
			return Vector2(ABILITY_MIN, ABILITY_MAX)
		Domain.POWER:
			return Vector2(POWER_MIN, POWER_MAX)
	return Vector2(0,0)
	

func _validate_deck(domain : int, set_deck : Array) -> Array:
	var all_cards : Array = Player.get_owned_by_domain(domain).duplicate(true)
	var invalid_cards : Array
	
	for card in set_deck:
		if all_cards.find(card) == -1:
			invalid_cards.append(card)
			
	return invalid_cards


func validate_set(set : PawnSet) -> Dictionary:
	var invalid_cards : Dictionary
	
	for domain in Game.Domain.values():

		var invalid = _validate_deck(domain, set.get_all_card_names(domain))
		if not invalid.empty():
			invalid_cards[domain] = invalid
			
	if not invalid_cards.empty():
		# TODO message dialog listing invalids
		push_warning("Invalid Pawn Set, Don't Own Cards Contained")
		push_warning("invalid_cards")
		
	for domain in invalid_cards.keys():
		set.remove_invalids(domain, invalid_cards.get(domain))
		
	var rtn : Dictionary
	if invalid_cards.empty():
		rtn["valid"] = true
	else:
		rtn["valid"] = false
		rtn["invalid_cards"] = invalid_cards
	
	return rtn
	
	


		
